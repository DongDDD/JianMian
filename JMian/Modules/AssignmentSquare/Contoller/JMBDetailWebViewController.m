//
//  JMBDetailWebViewController.m
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBDetailWebViewController.h"
#import "JMHTTPManager+FectchAbilityInfo.h"
#import "JMHTTPManager+CompanyLike.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMMessageListModel.h"
#import "JMChatViewController.h"
#import "JMVideoChatView.h"
#import "JMInterViewModel.h"
#import "JMShareView.h"
#import "WXApi.h"
#import "JMBDetailModel.h"


@interface JMBDetailWebViewController ()<JMVideoChatViewDelegate,JMShareViewDelegate>

@property (nonatomic, copy) NSString *favorites_id;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (copy, nonatomic)NSString *task_order_id;
@property (copy, nonatomic)NSString *user_id;
@property (nonatomic, strong) JMVideoChatView *videoChatView;
@property (nonatomic, strong) JMInterViewModel *interViewModel;

@property (nonatomic, strong) JMShareView *choosePayView;
@property (nonatomic ,strong) UIView *BGPayView;
@property (nonatomic ,strong) JMBDetailModel *detailModel;


@end

@implementation JMBDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兼职人才详情";
    [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
    [self setHTMLPath:@"SecondModulesHTML/B/Bdetail.html"];
    [self initView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.bottom.mas_equalTo(self.view).offset(-self.bottomView.frame.size.height);
    }];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
-(void)initView{
    [self showProgressHUD_view:self.view];
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
        JMVersionModel *model = [JMVersionManager getVersoinInfo];
        if ([model.test isEqualToString:@"1"]) {
            [shareBtn setHidden:YES];
            
        }
        [shareBtn addTarget:self action:@selector(right2Action) forControlEvents:UIControlEventTouchUpInside];
        [shareBtn setImage:[UIImage imageNamed:imageNameRight2] forState:UIControlStateNormal];
        [bgView addSubview:shareBtn];
        
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark - 点击事件
-(void)right2Action{
    
    [self showChoosePayView];
    
}


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
- (IBAction)bottomLeftAction:(UIButton *)sender {
    [self createChatRequstWithForeign_key:self.ability_id user_id:_user_id];
}

- (IBAction)bottomRightAction:(UIButton *)sender {
    [self gotoVideoChatViewWithForeign_key:self.ability_id recipient:_user_id chatType:@"2"];
}

-(void)gotoVideoChatViewWithForeign_key:(NSString *)foreign_key
                              recipient:(NSString *)recipient
                               chatType:(NSString *)chatType{
    _videoChatView = [[JMVideoChatView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    _videoChatView.delegate = self;
    _videoChatView.tag = 222;
    [_videoChatView createChatRequstWithForeign_key:foreign_key recipient:recipient chatType:chatType];
    //    [_videoChatView setInterviewModel:nil];
    [self.view addSubview:_videoChatView];
    [self.navigationController setNavigationBarHidden:YES];
}
//JMVideoChatViewDelegate 挂断
-(void)hangupAction_model:(JMInterViewModel *)model{
    
    [_videoChatView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO];
    
}

#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n
{   //检测是否安装微信
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = self.detailModel.user_nickname;
    urlMessage.description = self.detailModel.type_label_name ;
    
    //    UIImageView *imgView = [[UIImageView alloc]init];
    //    [imgView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.company_logo_path]];
    //
    
    UIImage *image = [self getImageFromURL:self.detailModel.user_avatar];   //缩略图,压缩图片,不超过 32 KB
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
#pragma mark - 数据请求

-(void)rightAction:(UIButton *)sender{
    NSLog(@"收藏");
    sender.selected = !sender.selected;
    if (sender.selected) {
        [[JMHTTPManager sharedInstance]createLikeWith_type:@"2" Id:self.ability_id mode:@"2" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            [self showAlertSimpleTips:@"提示" message:@"收藏成功" btnTitle:@"好的"];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        
        [[JMHTTPManager sharedInstance]deleteLikeWith_Id:self.ability_id mode:@"2" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            [self showAlertSimpleTips:@"提示" message:@"已取消收藏" btnTitle:@"好的"];
            
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
    }
    
}

//创建聊天
-(void)createChatRequstWithForeign_key:(NSString *)foreign_key user_id:(NSString *)user_id{
    if (user_id && foreign_key) {
        [[JMHTTPManager sharedInstance]createChat_type:@"2" recipient:user_id foreign_key:foreign_key successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            JMChatViewController *vc = [[JMChatViewController alloc]init];
            
            vc.myConvModel = messageListModel;
            [self.navigationController pushViewController:vc animated:YES];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }
}

-(void)getData{
    [[JMHTTPManager sharedInstance]fectchAbilityDetailInfo_Id:self.ability_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            
            self.detailModel = [JMBDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            NSDictionary *dic = responsObject[@"data"];
            [self ocToJs_dicData:dic];
            //判断是否有被收藏过
            if (![dic[@"favorites"] isEqual:[NSNull null]]) {
                self.favorites_id = dic[@"favorites"][@"favorite_id"];
                [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
                
            }
            //获取该用户ID
            _user_id = self.detailModel.user_id ;
            if (!_user_id) {
                //异常处理
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该用户已被删除" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:([UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }])];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
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
        NSLog(@"%@",message.body);
        self.favorites_id = message.body;
        [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
        
        //        self.labsJson = message.body;
        //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:message.body preferredStyle:UIAlertControllerStyleAlert];
        //        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        }])];
        //        [self presentViewController:alertController animated:YES completion:nil];
    }
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
