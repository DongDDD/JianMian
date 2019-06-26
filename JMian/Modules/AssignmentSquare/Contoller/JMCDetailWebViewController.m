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
#import "JMChatViewViewController.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMIDCardIdentifyViewController.h"
#import "JMApplyForProtocolView.h"



@interface JMCDetailWebViewController ()<JMShareViewDelegate,JMApplyForProtocolViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, copy) NSString *favorites_id;
@property (nonatomic, strong) JMShareView *choosePayView;
@property (nonatomic ,strong) UIView *BGPayView;
@property (nonatomic ,strong) JMCDetailModel *detailModel;
@property (copy, nonatomic)NSString *user_id;
@property (nonatomic, strong) JMApplyForProtocolView *applyForProtocolView;
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
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.choosePayView];
    [self.view addSubview:self.BGPayView];

    [self.BGPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_choosePayView.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenChoosePayView)];
    [self.BGPayView addGestureRecognizer:tap];

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

    [self showChoosePayView];

}


-(void)rightAction:(UIButton *)sender{
    NSLog(@"收藏");
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

-(void)showChoosePayView{
    [self.choosePayView setHidden:NO];
    [self.BGPayView setHidden:NO];
    
    [UIView animateWithDuration:0.18 animations:^{
        self.choosePayView.frame =CGRectMake(0, self.view.frame.size.height-205, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
        
        
    }];
    
}

-(void)hiddenChoosePayView{
    [self.choosePayView setHidden:YES];
    [self.BGPayView setHidden:YES];
    [UIView animateWithDuration:0.18 animations:^{
        self.choosePayView.frame =CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
        
        
    }];
    
}

-(void)showAlertVCWithCustumView:(UIView *)custumView
                         message:(NSString *)message
                       leftTitle:(NSString *)leftTitle
                      rightTitle:(NSString *)rightTitle

{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n" message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     }]];
    [alert addAction:[UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (_isRead) {
            [self sendResquest];//申请请求
        }else{
            [self showAlertSimpleTips:@"提示" message:@"请阅读并同意《平台服务协议》" btnTitle:@"好的"];
        
        }
    }]];
 
  
    [alert.view addSubview:custumView];
    [custumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(alert.view).mas_offset(10);
        make.left.mas_equalTo(alert.view).mas_offset(10);
        make.right.mas_equalTo(alert.view).mas_offset(-10);
        make.height.mas_equalTo(150);

    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - 点击事件

-(void)shareViewCancelAction{
    [self hiddenChoosePayView];
}

-(void)shareViewLeftAction{
    
    [self wxShare:0];
 }
-(void)shareViewRightAction{
    [self wxShare:1];

}


- (IBAction)bottomLeftAction:(UIButton *)sender {
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        [self createChatRequstWithForeign_key:self.task_id user_id:_user_id];
        
    }else{
       [self showAlertWithTitle:@"提示" message:@"实名认证后才能聊天" leftTitle:@"返回" rightTitle:@"去实名认证"];
    }

}

- (IBAction)bottomRightAction:(UIButton *)sender {
    
    [self showAlertVCWithCustumView:self.applyForProtocolView message:@"" leftTitle:@"取消" rightTitle:@"确认"];
//    [self sendResquest];
}

-(void)isReadProtocol:(BOOL)isRead{
    _isRead = isRead;

}



#pragma mark -- 获取数据

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

//创建聊天
-(void)createChatRequstWithForeign_key:(NSString *)foreign_key user_id:(NSString *)user_id{
    
    [[JMHTTPManager sharedInstance]createChat_type:@"2" recipient:user_id foreign_key:foreign_key successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"创建对话成功"
        //                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        //        [alert show];
        JMChatViewViewController *vc = [[JMChatViewViewController alloc]init];
        
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
    
    for (JMCDetailImageModel *imgModel in self.detailModel.images) {
        
        
        
    }
    
    NSString *url;
    if (self.detailModel.images.count > 0) {
        for (int i = 0; i < self.detailModel.images.count; i++) {
            JMCDetailImageModel *imgModel = self.detailModel.images[0];
            url = imgModel.file_path;
        }
        
    }else if (self.detailModel.company_logo_path){
        url= self.detailModel.company_logo_path;
    }
    
    UIImage *image = [self getImageFromURL:url];
    //缩略图,压缩图片,不超过 32 KB
    NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
    [urlMessage setThumbData:thumbData];
    //分享实例
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = self.detailModel.share_url;
    
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    //发送分享
    [WXApi sendReq:sendReq];

}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}

//申请职位
-(void)sendResquest{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    
    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        [[JMHTTPManager sharedInstance]createTaskOrder_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            [self showAlertSimpleTips:@"提示" message:@"申请成功" btnTitle:@"好的"];
            
            //发送自定义消息
            NSString *receiverId = [NSString stringWithFormat:@"%@b",_user_id];
            [self setTaskMessage_receiverID:receiverId dic:nil title:@"任务提醒"];
            
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        [self showAlertWithTitle:@"提示" message:@"实名认证后才能申请兼职" leftTitle:@"返回" rightTitle:@"去实名认证"];
        
    }
}



-(void)alertRightAction{
    JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)ocToJs_dicData:(NSDictionary *)dicData{
    //OC调用JS
    NSString *json;
    if (dicData) {
        json = [self dicToJSONWithDic:dicData];
    }
    
    
    NSString *showInfoFromJava = [NSString stringWithFormat:@"showInfoFromJava('%@')",json];
    [self.webView evaluateJavaScript:showInfoFromJava completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        //显示对话框
        
        //延迟
        NSLog(@"OC调用JS方法 showInfoFromJava ");
    }];
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self getData];
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
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
        
        
    }];
    
    
}

#pragma mark -- getter

-(JMShareView *)choosePayView{
    if (!_choosePayView) {
        _choosePayView = [[JMShareView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight)];
        _choosePayView.delegate = self;
        [_choosePayView.btn1 setImage:[UIImage imageNamed:@"WeChat"] forState:UIControlStateNormal];
        [_choosePayView.btn2 setImage:[UIImage imageNamed:@"Friendster"] forState:UIControlStateNormal];
        _choosePayView.lab1.text = @"微信分享";
        _choosePayView.lab2.text = @"朋友圈";
    }
    return _choosePayView;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
