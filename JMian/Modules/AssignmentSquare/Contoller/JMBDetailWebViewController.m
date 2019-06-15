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
#import "JMChatViewViewController.h"
#import "JMVideoChatView.h"
#import "JMInterViewModel.h"

@interface JMBDetailWebViewController ()<JMVideoChatViewDelegate>

@property (nonatomic, strong) NSDictionary *favorites;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (copy, nonatomic)NSString *task_order_id;
@property (copy, nonatomic)NSString *user_id;
@property (nonatomic, strong) JMVideoChatView *videoChatView;
@property (nonatomic, strong) JMInterViewModel *interViewModel;


@end

@implementation JMBDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兼职人才详情";
    [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
    [self setHTMLPath:@"SecondModulesHTML/B/Bdetail.html"];
    [self.view addSubview:self.bottomView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setRightBtnImageViewName:(NSString *)imageName  imageNameRight2:(NSString *)imageNameRight2 {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *colectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colectBtn.frame = CGRectMake(45, 0, 25, 25);
    if (self.favorites) {
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
#pragma mark - 数据请求

-(void)rightAction:(UIButton *)sender{
    NSLog(@"收藏");
    sender.selected = !sender.selected;
    if (sender.selected) {
        [[JMHTTPManager sharedInstance]createLikeWith_type:nil Id:self.ability_id SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        
        [[JMHTTPManager sharedInstance]deleteLikeWith_Id:self.ability_id SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消收藏成功"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
    }
    
}

//创建聊天
-(void)createChatRequstWithForeign_key:(NSString *)foreign_key user_id:(NSString *)user_id{
    
    [[JMHTTPManager sharedInstance]createChat_type:@"1" recipient:user_id foreign_key:foreign_key successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
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

-(void)getData{
    [[JMHTTPManager sharedInstance]fectchAbilityDetailInfo_Id:self.ability_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSDictionary *dic = responsObject[@"data"];
            [self ocToJs_dicData:dic];
            
            
            _user_id = dic[@"user"][@"user_id"];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

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
        NSLog(@"%@",message.body);
        self.favorites = message.body;
        [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
        
        //        self.labsJson = message.body;
        //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:message.body preferredStyle:UIAlertControllerStyleAlert];
        //        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        }])];
        //        [self presentViewController:alertController animated:YES completion:nil];
    }
    
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
