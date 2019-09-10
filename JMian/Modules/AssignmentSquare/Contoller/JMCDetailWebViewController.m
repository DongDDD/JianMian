//
//  JMCDetailWebViewController.m
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailWebViewController.h"
#import "JMHTTPManager+FectchTaskOrderInfo.h"
#import "JMHTTPManager+FectchTaskInfo.h"
#import "JMHTTPManager+CreateTaskOrder.h"
#import "JMHTTPManager+CompanyLike.h"
#import "JMCompanyIntroduceViewController.h"
#import "JMShareView.h"
#import "WXApi.h"
#import "JMCDetailModel.h"
#import "JMMessageListModel.h"
#import "JMChatViewController.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMIDCardIdentifyViewController.h"
#import "JMApplyForProtocolView.h"
#import "JMTaskManageViewController.h"
#import "JMTaskApplyForView.h"


@interface JMCDetailWebViewController ()<JMShareViewDelegate,JMApplyForProtocolViewDelegate,JMTaskApplyForViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, copy) NSString *favorites_id;
@property (nonatomic, strong) JMShareView *shareView;
@property (nonatomic ,strong) UIView *BGPayView;
@property (nonatomic ,strong) JMCDetailModel *detailModel;
@property (copy, nonatomic)NSString *user_id;
@property (nonatomic, strong) JMApplyForProtocolView *applyForProtocolView;
@property (nonatomic, strong) JMTaskApplyForView *taskApplyForView;
@property (nonatomic, strong) UIView *windowViewBGView;

@property (nonatomic, assign)BOOL isRead;

@end

@implementation JMCDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位详情";
    [self setHTMLPath:@"SecondModulesHTML/C/Cdetail.html"];
    [self.wkUController addScriptMessageHandler:self.weakScriptMessageDelegate  name:@"bbb"];
    [self.wkUController addScriptMessageHandler:self.weakScriptMessageDelegate  name:@"ccc"];
    [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
    [self initView];
    
    //    _isRead = YES;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.bottom.mas_equalTo(self.view).offset(-self.bottomView.frame.size.height);
    }];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

-(void)initView{
    [self showProgressHUD_view:self.view];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.shareView];
    
    [self.view addSubview:self.BGPayView];
    
    [self initTaskApplyForView];
    [self.BGPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_shareView.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenChoosePayView)];
    [self.BGPayView addGestureRecognizer:tap];
    
}

-(void)initTaskApplyForView{
    [[UIApplication sharedApplication].keyWindow addSubview:self.windowViewBGView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.taskApplyForView];
    [self.taskApplyForView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.width.mas_equalTo(330);
        make.height.mas_equalTo(250);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenApplyForView)];
    [self.windowViewBGView addGestureRecognizer:tap];
    
    
}
-(void)fanhui{
    [super fanhui];
    // 用完移除
    [[self.webView configuration].userContentController removeScriptMessageHandlerForName:@"bbb"];
    [[self.webView configuration].userContentController removeScriptMessageHandlerForName:@"ccc"];
    
}




- (void)setRightBtnImageViewName:(NSString *)imageName  imageNameRight2:(NSString *)imageNameRight2 {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *colectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colectBtn.frame = CGRectMake(45, 0, 25, 25);
    if (self.favorites_id) {
        colectBtn.selected = YES;
    }else{
        colectBtn.selected = NO;
        
    }
    [colectBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [colectBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [colectBtn setImage:[UIImage imageNamed:@"Collection_of_selected"] forState:UIControlStateSelected];
    
    [bgView addSubview:colectBtn];
    if (imageNameRight2 != nil) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(0, 0, 25, 25);
        [shareBtn addTarget:self action:@selector(right2Action) forControlEvents:UIControlEventTouchUpInside];
        [shareBtn setImage:[UIImage imageNamed:imageNameRight2] forState:UIControlStateNormal];
        [bgView addSubview:shareBtn];
        
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

-(void)right2Action{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self loginOut];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self showShareView];
    
}


-(void)rightAction:(UIButton *)sender{
    NSLog(@"收藏");
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self loginOut];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [[JMHTTPManager sharedInstance]createLikeWith_type:nil Id:self.task_id mode:@"2" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            [self showAlertSimpleTips:@"提示" message:@"收藏成功" btnTitle:@"好的"];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        
        [[JMHTTPManager sharedInstance]deleteLikeWith_Id:self.favorites_id  mode:@"2" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            [self showAlertSimpleTips:@"提示" message:@"已取消收藏" btnTitle:@"好的"];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
    }
    
}

-(void)showShareView{
    [self.shareView setHidden:NO];
    [self.BGPayView setHidden:NO];
    
    [UIView animateWithDuration:0.18 animations:^{
        self.shareView.frame =CGRectMake(0, self.view.frame.size.height-205, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
        
        
    }];
    
}


-(void)hiddenChoosePayView{
    [self.shareView setHidden:YES];
    [self.BGPayView setHidden:YES];
    
    [UIView animateWithDuration:0.18 animations:^{
        self.shareView.frame =CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
        
        
    }];
    
}

-(void)hiddenApplyForView{
    [self.taskApplyForView setHidden:YES];
    [self.windowViewBGView setHidden:YES];
    
}

-(void)showApplyForView{
    [self.taskApplyForView setHidden:NO];
    [self.windowViewBGView setHidden:NO];
    
}

//-(void)showAlertVCWithCustumView:(UIView *)custumView
//                         message:(NSString *)message
//                       leftTitle:(NSString *)leftTitle
//                      rightTitle:(NSString *)rightTitle
//
//{
//
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n" message:message preferredStyle: UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//     }]];
//    [alert addAction:[UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        if (_isRead) {
//            [self sendResquest];//申请请求
//        }else{
//            [self showAlertSimpleTips:@"提示" message:@"请阅读并同意《平台服务协议》" btnTitle:@"好的"];
//
//        }
//    }]];
//
//
//    [alert.view addSubview:custumView];
//    [custumView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(alert.view).mas_offset(10);
//        make.left.mas_equalTo(alert.view).mas_offset(10);
//        make.right.mas_equalTo(alert.view).mas_offset(-10);
//        make.height.mas_equalTo(150);
//
//    }];
//
//    [self presentViewController:alert animated:YES completion:nil];
//
//}
#pragma mark - MyDelegate

-(void)shareViewCancelAction{
    [self hiddenChoosePayView];
}

-(void)shareViewLeftAction{
    [self wxShare:0];
    [self hiddenChoosePayView];
    
}
-(void)shareViewRightAction{
    [self wxShare:1];
    [self hiddenChoosePayView];
    
    
}


-(void)applyForViewDeleteAction{
    [self hiddenApplyForView];
    
}

-(void)applyForViewComfirmAction{
    [self hiddenApplyForView];
    [self sendResquest];
    
}


#pragma mark - 点击事件


- (IBAction)bottomLeftAction:(UIButton *)sender {
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self loginOut];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        [self createChatRequstWithForeign_key:self.task_id user_id:_user_id];
        
    }else{
        [self showAlertWithTitle:@"提示" message:@"实名认证后才能聊天" leftTitle:@"返回" rightTitle:@"去实名认证"];
    }
    
}

- (IBAction)bottomRightAction:(UIButton *)sender {
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self loginOut];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    //    [self showAlertVCWithCustumView:self.applyForProtocolView message:@"" leftTitle:@"取消" rightTitle:@"确认"];
    //    [self sendResquest];
    //    [self initTaskApplyForView];
    NSString *isRead = kFetchMyDefault(@"isRead");
    if ([isRead isEqualToString:@"1"]) {
        [self sendResquest];
        
    }else{
        [self showApplyForView];
        
    }
}



-(void)isReadProtocol:(BOOL)isRead{
    if (isRead) {
        //不再提醒
        kSaveMyDefault(@"isRead", @"1");
        
    }else{
        kSaveMyDefault(@"isRead", @"0");
        
    }
    
}



#pragma mark -- Data

-(void)getData{
    
    [[JMHTTPManager sharedInstance]fectchTaskInfo_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.detailModel = [JMCDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            
            NSDictionary *dic = responsObject[@"data"];
            //判断是否有被收藏过
            if (![dic[@"favorites"] isEqual:[NSNull null]]) {
                self.favorites_id = dic[@"favorites"][@"favorite_id"];
                [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
                
            }
            _user_id = dic[@"user"][@"user_id"];
            
            [self ocToJs_dicData:dic];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

//申请职位
-(void)sendResquest{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    
    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        [[JMHTTPManager sharedInstance]createTaskOrder_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            //            [self showAlertSimpleTips:@"提示" message:@"申请成功" btnTitle:@"好的"];
            
            //创建聊天
            [self createChatToSendCustumMessageRequstWithForeign_key:self.task_id user_id:_user_id];
            //            [self setTaskMessage_receiverID:receiverId dic:nil title:@"任务提醒"];
            
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        [self showAlertWithTitle:@"提示" message:@"实名认证后才能申请任务" leftTitle:@"返回" rightTitle:@"去实名认证"];
        
    }
}
//申请任务后的创建聊天，用来发送自定义消息
-(void)createChatToSendCustumMessageRequstWithForeign_key:(NSString *)foreign_key user_id:(NSString *)user_id{
    
    [[JMHTTPManager sharedInstance]createChat_type:@"2" recipient:user_id foreign_key:foreign_key successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        //        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        //
        NSString *receiverId = [NSString stringWithFormat:@"%@b",_user_id];
        [self setTaskMessage_receiverID:receiverId dic:nil title:@"[任务申请]"];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}
//创建聊天
-(void)createChatRequstWithForeign_key:(NSString *)foreign_key user_id:(NSString *)user_id{
    
    [[JMHTTPManager sharedInstance]createChat_type:@"2" recipient:user_id foreign_key:foreign_key successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
    
        
        JMChatViewController *vc = [[JMChatViewController alloc]init];

        vc.myConvModel = messageListModel;
        [self.navigationController pushViewController:vc animated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n
{   //检测是否安装微信
    
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = self.detailModel.task_title;
    urlMessage.description = self.detailModel.myDescription;
    
    //    UIImageView *imgView = [[UIImageView alloc]init];
    //    [imgView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.company_logo_path]];
    //
    
    NSString *url;
    if (self.detailModel.images.count > 0) {
        for (int i = 0; i < self.detailModel.images.count; i++) {
            JMCDetailImageModel *imgModel = self.detailModel.images[0];
            url = imgModel.file_path;
        }
        
    }else if (self.detailModel.company_logo_path){
        url= self.detailModel.company_logo_path;
    }
    
    //    UIImage *image = [self getImageFromURL:url];
    //    UIImage *image = [UIImage imageNamed:@"demi_home"];
    //NSData *thumbData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    //缩略图,压缩图片,不超过 32 KB
    UIImage *image = [self handleImageWithURLStr:url];
    NSData *thumbData = UIImageJPEGRepresentation(image, 0.1);
    [urlMessage setThumbData:thumbData];
    //分享实例
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = self.detailModel.share_url;
    
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    //发送分享
    [WXApi sendReq:sendReq];
    
}

- (UIImage *)handleImageWithURLStr:(NSString *)imageURLStr {
    NSURL *url = [NSURL URLWithString:imageURLStr];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    NSData *newImageData = imageData;
    // 压缩图片data大小
    newImageData = UIImageJPEGRepresentation([UIImage imageWithData:newImageData scale:0.1], 0.1f);
    UIImage *image = [UIImage imageWithData:newImageData];
    
    // 压缩图片分辨率(因为data压缩到一定程度后，如果图片分辨率不缩小的话还是不行)
    CGSize newSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,(NSInteger)newSize.width, (NSInteger)newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}




-(void)iconAlertRightAction{
    JMTaskManageViewController *vc = [[JMTaskManageViewController alloc]init];
    [vc setMyIndex:0];
    vc.title = @"我的任务";
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

-(void)alertRightAction{
    JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)ocToJs_dicData:(NSDictionary *)dicData{
    //OC调用JS
    NSString *json;
    NSString *token;
    if (dicData) {
        json = [self dicToJSONWithDic:dicData];
    }
    token = kFetchMyDefault(@"token");
    
    NSString *showInfoFromJava = [NSString stringWithFormat:@"showInfoFromJava('%@','%@')",json,token];
    [self.webView evaluateJavaScript:showInfoFromJava completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        //显示对话框
        
        //延迟
        NSLog(@"OC调用JS方法 showInfoFromJava ");
    }];
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self getData];
    [self hiddenHUD];
    [self.bottomView setHidden:NO];
    
    //    [self ocToJs];
}


//被自定义的WKScriptMessageHandler在回调方法里通过代理回调回来，绕了一圈就是为了解决内存不释放的问题
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    //用message.body获得JS传出的参数体
    // NSDictionary * parameter = message.body;
    //JS调用OC
    if([message.name isEqualToString:@"aaa"]){
        NSLog(@"message.body---%@",message.body);
        //        self.favorites = message.body;
        //        self.labsJson = message.body;
        //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:message.body preferredStyle:UIAlertControllerStyleAlert];
        //        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        }])];
        //        [self presentViewController:alertController animated:YES completion:nil];
    }else if([message.name isEqualToString:@"bbb"]){
        
        JMCompanyIntroduceViewController *vc = [[JMCompanyIntroduceViewController alloc]init];
        vc.viewType = JMCompanyIntroduceViewControllerCDetail;
        vc.company_id = message.body;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
}


#pragma mark -  （自定义消息）

-(void)setTaskMessage_receiverID:(NSString *)receiverID dic:(NSDictionary *)dic title:(NSString *)title{
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:receiverID];
    
    // 转换为 NSData
    
    TIMCustomElem * custom_elem = [[TIMCustomElem alloc] init];
    //    [custom_elem setData:data];
    if (dic) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        [custom_elem setData:data];
        
    }
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    [custom_elem setDesc:title];
    TIMMessage * msg = [[TIMMessage alloc] init];
    [msg addElem:custom_elem];
    [conv sendMessage:msg succ:^(){
        NSLog(@"SendMsg Succ");
        [self showAlertVCWithHeaderIcon:@"purchase_succeeds" message:@"申请成功" leftTitle:@"返回" rightTitle:@"查看任务"];
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
        
        
    }];
    
    
}

#pragma mark -- getter

-(JMShareView *)shareView{
    if (!_shareView) {
        _shareView = [[JMShareView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight)];
        _shareView.delegate = self;
        [_shareView.btn1 setImage:[UIImage imageNamed:@"WeChat"] forState:UIControlStateNormal];
        [_shareView.btn2 setImage:[UIImage imageNamed:@"Friendster"] forState:UIControlStateNormal];
        _shareView.lab1.text = @"微信分享";
        _shareView.lab2.text = @"朋友圈";
    }
    return _shareView;
}

-(UIView *)BGPayView{
    if (!_BGPayView) {
        _BGPayView = [[UIView alloc]init];
        _BGPayView.backgroundColor = [UIColor blackColor];
        _BGPayView.alpha = 0.5;
        _BGPayView.hidden = YES;
    }
    return  _BGPayView;
    
}

-(JMApplyForProtocolView *)applyForProtocolView{
    if (!_applyForProtocolView) {
        _applyForProtocolView = [[JMApplyForProtocolView alloc]init];
        _applyForProtocolView.delegate = self;
        
    }
    return  _applyForProtocolView;
    
}

-(JMTaskApplyForView *)taskApplyForView{
    if (!_taskApplyForView) {
        _taskApplyForView = [[JMTaskApplyForView alloc]init];
        _taskApplyForView.layer.cornerRadius = 10;
        [_taskApplyForView setHidden:YES];
        _taskApplyForView.delegate = self;
    }
    return _taskApplyForView;
}


-(UIView *)windowViewBGView{
    if (!_windowViewBGView) {
        _windowViewBGView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _windowViewBGView.backgroundColor = [UIColor blackColor];
        [_windowViewBGView setHidden:YES];
        _windowViewBGView.alpha = 0.3;
    }
    return _windowViewBGView;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
