//
//  JMCDetailViewController.m
//  JMian
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailViewController.h"
#import "JMTaskDetailHeaderView.h"
#import "JMTitlesView.h"
#import "JMTaskDetailHeaderTableViewCell.h"
#import "JMCDetailCellConfigures.h"
#import "JMHTTPManager+FectchTaskInfo.h"
#import "JMHTTPManager+FectchCommentInfo.h"
#import "JMVideoPlayManager.h"
#import "JMPlayerViewController.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMMessageListModel.h"
#import "JMChatViewController.h"
#import "WXApi.h"
#import "JMTaskApplyForView.h"
#import "JMShareView.h"
#import "JMHTTPManager+CreateTaskOrder.h"
#import "JMHTTPManager+CompanyLike.h"
#import "JMCompanyDetailViewController.h"
#import "JMPostPartTimeResumeViewController.h"
#import "JMIDCardIdentifyViewController.h"


@interface JMCDetailViewController ()<UITableViewDelegate,UITableViewDataSource,JMCDetailVideoTableViewCellDelegate,JMShareViewDelegate,JMTaskApplyForViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

//@property (nonatomic, strong) UIView *headerTitleView;
@property (nonatomic, strong) JMTaskDetailHeaderView *taskDetailHeaderView;

@property (nonatomic, strong) JMTitlesView *titleView;
@property (assign, nonatomic) NSUInteger index;
@property (nonatomic, strong) JMCDetailCellConfigures *configures;
@property (copy, nonatomic) NSString *user_id;
@property (nonatomic, strong) UIView *windowViewBGView;
@property (nonatomic, strong) JMTaskApplyForView *taskApplyForView;
@property (nonatomic, strong) JMShareView *shareView;
@property (nonatomic ,strong) UIView *BGShareView;

@end

@implementation JMCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务详情";
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self upDateUserData];
}

-(void)initView{
    //    [self.view addSubview:self.taskDetailHeaderView];
    [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.shareView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.BGShareView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
        make.centerX.mas_equalTo(self.view);
    }];
    [self initTaskApplyForView];
    [self.BGShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_shareView.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenChoosePayView)];
    [self.BGShareView addGestureRecognizer:tap];
    
}

- (void)setRightBtnImageViewName:(NSString *)imageName  imageNameRight2:(NSString *)imageNameRight2 {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *colectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colectBtn.frame = CGRectMake(45, 0, 25, 25);
    if (self.configures.model.favorites_id) {
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
#pragma mark -- Data

-(void)getData{
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]fectchTaskInfo_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.configures.model = [JMCDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
//
//            
//            NSDictionary *dic = responsObject[@"data"];
//            //判断是否有被收藏过
//            if (![dic[@"favorites"] isEqual:[NSNull null]]) {
//                self.favorites_id = dic[@"favorites"][@"favorite_id"];
//                [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
//                
//            }
            [self getCommentInfo];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


-(void)getCommentInfo{
    [[JMHTTPManager sharedInstance]fectchCommentInfoWithTask_order_id:nil order_id:nil user_id:nil company_id:self.configures.model.user_company_id page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.configures.commentListArray = [JMCommentCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self initView];
            [self.tableView reloadData];
            [self hiddenHUD];
        }
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

//申请职位
-(void)sendResquest{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    
    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        [[JMHTTPManager sharedInstance]createTaskOrder_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            //            [self showAlertSimpleTips:@"提示" message:@"申请成功" btnTitle:@"好的"];
            [self showAlertVCSucceesSingleWithMessage:@"申请已发出" btnTitle:@"好的"];
            //创建自定义消息
            [self createChatToSendCustumMessageRequstWithForeign_key:self.task_id user_id:self.configures.model.user_id];
            //            [self setTaskMessage_receiverID:receiverId dic:nil title:@"任务提醒"];
            
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        [self showAlertWithTitle:@"提示" message:@"实名认证后才能申请兼职" leftTitle:@"返回" rightTitle:@"去实名认证"];
    }
}

#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n
{   //检测是否安装微信
    
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = self.configures.model.task_title;
    urlMessage.description = self.configures.model.myDescription;
    
    //    UIImageView *imgView = [[UIImageView alloc]init];
    //    [imgView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.company_logo_path]];
    //
    
    NSString *url;
    if (self.configures.model.images.count > 0) {
        for (int i = 0; i < self.configures.model.images.count; i++) {
            JMCDetailImageModel *imgModel = self.configures.model.images[0];
            url = imgModel.file_path;
        }
        
    }else if (self.configures.model.company_logo_path){
        url= self.configures.model.company_logo_path;
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
    webObj.webpageUrl = self.configures.model.share_url;
    
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
#pragma mark -- Action
-(void)right2Action{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self loginAlert];
        return;
    }
    [self showShareView];
    
}

-(void)rightAction:(UIButton *)sender{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self loginAlert];
        return;
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        [[JMHTTPManager sharedInstance]createLikeWith_type:nil Id:self.task_id mode:@"2" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            [self showAlertSimpleTips:@"提示" message:@"收藏成功" btnTitle:@"好的"];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        
        [[JMHTTPManager sharedInstance]deleteLikeWith_Id:self.configures.model.favorites_id  mode:@"2" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            [self showAlertSimpleTips:@"提示" message:@"已取消收藏" btnTitle:@"好的"];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
    }
    
}

- (IBAction)bottomLeftAction:(id)sender {
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self loginAlert];
        return;
    }
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        [self createChatRequstWithForeign_key:self.task_id user_id:self.configures.model.user_id];
        
    }else if ([userModel.card_status isEqualToString:Card_NOIdentify] || [userModel.card_status isEqualToString:Card_RefuseIdentify]){
        //是否通过实名认证
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"实名认证通过后才能发起聊天" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else if ([userModel.card_status isEqualToString:Card_WaitIdentify]){
        //审核中状态
        [self showAlertSimpleTips:@"提示" message:@"实名认证审核中，暂时无法发起聊天" btnTitle:@"好的"];
    }
}

-(void)loginAlert{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self loginOut];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
 

}

- (IBAction)bottomRightAction:(UIButton *)sender {
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self loginAlert];
        return;
    }
    NSString *isRead = kFetchMyDefault(@"isRead");
    if ([isRead isEqualToString:@"1"]) {
        //判断有是否符合申请条件
        [self applyForAction];
        
    }else{
        //服务提醒
        [self showApplyForView];
    }
    
}

//判断有是否符合申请任务条件
-(void)applyForAction{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];

    if ([userModel.ability_count isEqualToString:@"0"]) {
        //是否有任务简历
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你还没有发布任务简历" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"发布任务简历" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
            vc.viewType = JMPostPartTimeResumeViewAdd;
            [self.navigationController pushViewController:vc animated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else if ([userModel.card_status isEqualToString:Card_NOIdentify] || [userModel.card_status isEqualToString:Card_RefuseIdentify]){
        //是否通过实名认证
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"实名认证通过后才能申请任务" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else if ([userModel.card_status isEqualToString:Card_WaitIdentify]){
        //审核中状态
        [self showAlertSimpleTips:@"提示" message:@"实名认证审核中，暂时无法申请任务" btnTitle:@"好的"];
    }else{
        [self sendResquest];
    
    }
}

-(void)showShareView{
    [self.shareView setHidden:NO];
    [self.BGShareView setHidden:NO];
    
    [UIView animateWithDuration:0.18 animations:^{
        self.shareView.frame =CGRectMake(0, self.view.frame.size.height-205, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
        
        
    }];
    
}


-(void)hiddenChoosePayView{
    [self.shareView setHidden:YES];
    [self.BGShareView setHidden:YES];
    
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
#pragma mark - myDelegate

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


-(void)isReadProtocol:(BOOL)isRead{
    if (isRead) {
        //不再提醒
        kSaveMyDefault(@"isRead", @"1");
        
    }else{
        kSaveMyDefault(@"isRead", @"0");
        
    }
    
}

-(void)applyForViewDeleteAction{
    [self hiddenApplyForView];
    
}

-(void)applyForViewComfirmAction{
    [self hiddenApplyForView];
    [self applyForAction];
    
}

-(void)playVideoActionWithUrl:(NSString *)url{
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:url];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    [[JMVideoPlayManager sharedInstance] play];
}


#pragma mark - UITableViewDataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        return  5;
//    }else if(section == 1) {
//        return  5;
//    }
//    return 5;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
//        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor redColor];
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.configures numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self.configures heightForRowsInSection:indexPath];;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.titleView;
    }else if (section == 2) {
        NSMutableArray *imgArr = [NSMutableArray array];
        for (JMCDetailImageModel *imgModel in self.configures.model.images) {
            if ([imgModel.status isEqualToString:@"2"]) {
                [imgArr addObject:imgModel];
            }
        }
        if (imgArr.count > 0) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
            lab.text = @"     图片介绍";
            lab.font = [UIFont boldSystemFontOfSize:16];
            lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            lab.backgroundColor = [UIColor whiteColor];
            return lab;
        }else{
            return [UIView new];
        }
    }else if (section == 3) {
        if (self.configures.model.latitude.length > 0 && self.configures.model.longitude.length > 0) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
            lab.font = [UIFont boldSystemFontOfSize:16];
            lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            lab.backgroundColor = [UIColor whiteColor];
            lab.text = @"     公司地址";
            return lab;
            
        }else{
            return [UIView new];
        }
  
    }else if (section == 4) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        lab.backgroundColor = [UIColor whiteColor];
        lab.text = @"     信誉评价";
        
        return lab;
    }
//    else if (section == 2) {
//        return self.titleView;
//
//    }
    return [UIView new];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }else if (section == 2) {
        if (self.configures.model.images.count > 0) {
            return 44;
        }else{
            return 1;
        }
    }else if (section == 3) {
        if (self.configures.model.latitude.length > 0 && self.configures.model.longitude.length > 0) {
            return 44;
        }else{
            return 1;
            
        }
        
    }else if (section == 4) {
        return 44;
        
    }
    return 0;

}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return 10;
//    }
//    return 0;
//}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        JMTaskDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMTaskDetailHeaderTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setModel:self.configures.model];
        return cell;
        
    }else if (indexPath.section == 1){
        //任务描述/产品描述
        if (indexPath.row == 0) {
            JMCDetailTaskDecriTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailTaskDecriTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.configures.model];
            return cell;
            
        }else if (indexPath.row == 1) {
            if ([self.configures.model.payment_method isEqualToString:@"1"]) {

                JMCDetailProduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailProduceTableViewCellIdentifier forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setData:self.configures.model];
                return cell;
            }else {
                JMCDetailTaskDecri2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailTaskDecri2TableViewCellIdentifier forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setModel:self.configures.model];
                return cell;
            }
        }else if (indexPath.row == 2) {
             JMCDetailVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailVideoTableViewCellIdentifier forIndexPath:indexPath];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.configures.model];
//            cell.backgroundColor = [UIColor redColor];
            //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
        }
    
    }else if (indexPath.section == 2) {
        //图片
        JMCDetailImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailImageTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableArray *imgArr = [NSMutableArray array];
        for (JMCDetailImageModel *imgModel in self.configures.model.images) {
            if ([imgModel.status isEqualToString:@"2"]) {
                
                [imgArr addObject:imgModel];
            }
        }
        JMCDetailImageModel *imgModel = imgArr[indexPath.row];
        [cell setUrl:imgModel.file_path];
        
        //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
        return cell;
    }else if (indexPath.section == 3) {
        //公司地址
        JMMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMapTableViewCellIdentifier forIndexPath:indexPath];
//        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.address = self.configures.model.address;
        [cell setModel:self.configures.model];
        //            cell.backgroundColor = [UIColor redColor];
        //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
        return cell;
    }else if (indexPath.section == 4) {
        //评论
        if (self.configures.commentListArray.count > 0) {
            JMCDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailCommentTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            JMCommentCellData *data = self.configures.commentListArray[indexPath.row];
            [cell setData:data];
            //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
            
        }else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nilCell"];
            
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"nilCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"  暂无评论";
            cell.textLabel.font = kFont(14);
            cell.textLabel.textColor = TEXT_GRAY_COLOR;
            return cell;

        }
    }

    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSLog(@"asd");
        JMCompanyDetailViewController *vc = [[JMCompanyDetailViewController alloc]init];
        vc.company_id = self.configures.model.user_company_id;
        vc.address = self.configures.model.address;
        vc.latitude = self.configures.model.latitude;
        vc.longitude = self.configures.model.longitude;
        [self.navigationController pushViewController:vc animated:YES];
    }

}


-(void)showPageContentView{
    switch (_index) {
        case 0:
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        case 1:
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        default:
            break;
    }

}

#pragma mark - lazy
-(JMTaskDetailHeaderView *)taskDetailHeaderView{
    if (!_taskDetailHeaderView) {
        _taskDetailHeaderView = [[JMTaskDetailHeaderView alloc]init];
    }
    return _taskDetailHeaderView;
    
}

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"任务描述", @"信誉评价"]];
        __weak JMCDetailViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf showPageContentView];
        };
    }
    
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 5;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
                _tableView.sectionFooterHeight = 5;
        [_tableView registerNib:[UINib nibWithNibName:@"JMTaskDetailHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMTaskDetailHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecriTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailTaskDecriTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecri2TableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailTaskDecri2TableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailVideoTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailVideoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailImageTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailImageTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailCommentTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailCommentTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailProduceTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailProduceTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMapTableViewCell" bundle:nil] forCellReuseIdentifier:JMMapTableViewCellIdentifier];
        
    }
    return _tableView;
}

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

-(JMCDetailCellConfigures *)configures{
    if (!_configures) {
        _configures = [[JMCDetailCellConfigures alloc]init];
    }
    return _configures;
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
-(UIView *)BGShareView{
    if (!_BGShareView) {
        _BGShareView = [[UIView alloc]init];
        _BGShareView.backgroundColor = [UIColor blackColor];
        _BGShareView.alpha = 0.5;
        _BGShareView.hidden = YES;
    }
    return  _BGShareView;
    
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
