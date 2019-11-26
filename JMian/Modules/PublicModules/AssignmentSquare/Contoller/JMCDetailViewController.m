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
#import "JMHTTPManager+UpdateTask.h"
#import "JMBUserPostSaleJobViewController.h"
#import "JMBUserPostPartTimeJobViewController.h"
#import "JMHTTPManager+DeleteTask.h"


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
@property (weak, nonatomic) IBOutlet UIButton *bottomLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomRightBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomH;
@property (weak, nonatomic) IBOutlet UILabel *haveApply;

@end

@implementation JMCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务详情";

//    self.bottomH.constant = 50+SafeAreaBottomHeight;

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
    [self upDateUserData];
}

-(void)initView{
    //    [self.view addSubview:self.taskDetailHeaderView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.BGShareView];
    [self.view addSubview:self.shareView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
        make.centerX.mas_equalTo(self.view);
    }];
    [self initTaskApplyForView];
//    [self.BGShareView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.view);
//        make.left.and.right.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.view);
//    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenChoosePayView)];
    [self.BGShareView addGestureRecognizer:tap];

}

//预览状态分享按钮
//- (void)setRightBtnImageViewName:(NSString *)imageName{
//
//    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 19)];
//
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(-20 , 0, 120, 28);
//    //    leftBtn.backgroundColor = [UIColor redColor];
//    [rightBtn addTarget:self action:@selector(right2Action) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//
//    [bgView addSubview:rightBtn];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
//    self.navigationItem.rightBarButtonItem = rightItem;
//
//}

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
            self.haveApply.text = [NSString stringWithFormat:@"%@人已报名", self.configures.model.effective_count];
                [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
//
//            }
            if (_viewType == JMCDetailPreviewType) {
                [self initView];
                [self setRightBtnImageViewName:@"jobDetailShare" imageNameRight2:@"Bdelete"];
                [self.tableView reloadData];

            }else  if (_viewType == JMCDetailDefaultType) {
                [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
                [self getCommentInfo];
            
            }
            
            if (_viewType == JMCDetailPreviewType) {
                if ([self.configures.model.status isEqualToString:Position_Online]) {
                    [self.bottomLeftBtn setTitle:@"任务下线" forState:UIControlStateNormal];
                    [self.bottomRightBtn setTitle:@"编辑更新" forState:UIControlStateNormal];
                    
                }else if (([self.configures.model.status isEqualToString:Position_Downline])) {
                    [self.bottomLeftBtn setTitle:@"编辑更新" forState:UIControlStateNormal];
                    [self.bottomRightBtn setTitle:@"重新发布" forState:UIControlStateNormal];
                    
                }
            }else if (_viewType == JMCDetailDefaultType) {
                [self.bottomLeftBtn setTitle:@"咨询雇主" forState:UIControlStateNormal];
                [self.bottomRightBtn setTitle:@"立即申请" forState:UIControlStateNormal];
            }
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
    
    [[JMHTTPManager sharedInstance]createChat_type:@"2" recipient:user_id foreign_key:foreign_key sender_mark:@"" recipient_mark:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        
        
        JMChatViewController *vc = [[JMChatViewController alloc]init];
        
        vc.myConvModel = messageListModel;
        [self.navigationController pushViewController:vc animated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

//申请任务后的创建聊天，用来发送自定义消息
-(void)createChatToSendCustumMessageRequstWithForeign_key:(NSString *)foreign_key user_id:(NSString *)user_id{
    
    [[JMHTTPManager sharedInstance]createChat_type:@"2" recipient:user_id foreign_key:foreign_key sender_mark:@"" recipient_mark:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        //        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        //
        NSString *receiverId = [NSString stringWithFormat:@"%@b",_user_id];
        [self setTaskMessage_receiverID:receiverId dic:nil title:@"[任务申请]"];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

//申请职位
-(void)sendResquest{
//    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    
//    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        [[JMHTTPManager sharedInstance]createTaskOrder_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            //            [self showAlertSimpleTips:@"提示" message:@"申请成功" btnTitle:@"好的"];
            [self showAlertVCSucceesSingleWithMessage:@"申请已发出" btnTitle:@"好的"];
            //创建自定义消息
            [self createChatToSendCustumMessageRequstWithForeign_key:self.task_id user_id:self.configures.model.user_id];
            //            [self setTaskMessage_receiverID:receiverId dic:nil title:@"任务提醒"];
            
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
//    }else{
//        [self showAlertWithTitle:@"提示" message:@"实名认证后才能申请兼职" leftTitle:@"返回" rightTitle:@"去实名认证"];
//    }
}

//更新任务上下线
-(void)updateTaskStatusRequestWithStatus:(NSString *)status{
    [[JMHTTPManager sharedInstance]updateTaskWithId:self.task_id payment_method:nil unit:nil payment_money:nil front_money:nil quantity_max:nil myDescription:nil industry_arr:nil city_id:nil longitude:nil latitude:nil address:nil goods_title:nil goods_price:nil goods_desc:nil video_path:nil video_cover:nil image_arr:nil is_invoice:nil invoice_title:nil invoice_tax_number:nil invoice_email:nil status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        NSString *title;
        if ([status isEqualToString:Position_Downline]) {
            title  = @"已下线";
        }else if ([status isEqualToString:Position_Online]) {
            title  = @"已上线";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)deleteTaskRequest{
    [[JMHTTPManager sharedInstance]deleteTask_Id:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n" message:@"删除成功" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.navigationController.viewControllers.count >=2) {
                UIViewController *listViewController =self.navigationController.viewControllers[1];
                [self.navigationController popToViewController:listViewController animated:YES];
            }
            
        }]];
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"purchase_succeeds"];
        [alert.view addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(alert.view).mas_offset(23);
            make.centerX.mas_equalTo(alert.view);
            make.size.mas_equalTo(CGSizeMake(75, 64));
            
        }];
        [self presentViewController:alert animated:YES completion:nil];
        
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

-(void)shareMiniProgram {
    WXMiniProgramObject *object = [WXMiniProgramObject object];
    object.webpageUrl = self.configures.model.share_url;
    object.userName = MiniProgramUserName;
    object.path = [NSString stringWithFormat:@"pages/ability_work/ability_work?id=%@",self.configures.model.task_id];
    
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
    
    object.hdImageData = thumbData;
    object.withShareTicket = @"";
    object.miniProgramType = WXMiniProgramTypeRelease;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.configures.model.task_title;
    message.description = self.configures.model.myDescription;
    message.thumbData = nil;  //兼容旧版本节点的图片，小于32KB，新版本优先
    //使用WXMiniProgramObject的hdImageData属性
    message.mediaObject = object;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;  //目前只支持会话
    [WXApi sendReq:req];

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
    if (_viewType == JMCDetailPreviewType) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除吗，删除后数据将不可恢复！" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"确认删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self deleteTaskRequest];

        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
          
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if (_viewType == JMCDetailDefaultType) {
        [self showShareView];
    
    }
    
}

-(void)rightAction:(UIButton *)sender{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self loginAlert];
        return;
    }
    if (_viewType == JMCDetailPreviewType) {
        [self showShareView];
    }else if (_viewType == JMCDetailDefaultType) {
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
    
}

- (IBAction)bottomLeftAction:(id)sender {
    if (_viewType == JMCDetailPreviewType) {
        if ([self.configures.model.status isEqualToString:Position_Online]) {
            //下线
            [self updateTaskStatusRequestWithStatus:Position_Downline];
            
        }else if ([self.configures.model.status isEqualToString:Position_Downline]) {
            //编辑
            NSString *task_id;
            NSString *payment_method;
            payment_method = self.configures.model.payment_method;
            task_id = self.configures.model.task_id;
            if ([payment_method isEqualToString: @"1"]) {
                //网络销售
                [self gotoBUserPostPositionVC_task_id:task_id];
                
            }else{
                //其他兼职
                [self gotoBUserPostPartTimeJobVC_task_id:task_id];
                
            }

        }
    }else if (_viewType == JMCDetailDefaultType) {
        NSString *str = kFetchMyDefault(@"youke");
        if ([str isEqualToString:@"1"]) {
            [self loginAlert];
            return;
        }
//        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
//        if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
            [self createChatRequstWithForeign_key:self.task_id user_id:self.configures.model.user_id];
            
//        }else if ([userModel.card_status isEqualToString:Card_NOIdentify] || [userModel.card_status isEqualToString:Card_RefuseIdentify]){
//            //是否通过实名认证
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"实名认证通过后才能发起聊天" preferredStyle: UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            }]];
//            [alert addAction:[UIAlertAction actionWithTitle:@"去实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc]init];
//                [self.navigationController pushViewController:vc animated:YES];
//            }]];
//
//            [self presentViewController:alert animated:YES completion:nil];
//        }else if ([userModel.card_status isEqualToString:Card_WaitIdentify]){
//            //审核中状态
//            [self showAlertSimpleTips:@"提示" message:@"实名认证审核中，暂时无法发起聊天" btnTitle:@"好的"];
//        }
    
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
    if (_viewType == JMCDetailPreviewType) {
        if ([self.configures.model.status isEqualToString:Position_Online]) {
            //上线状态
            NSString *task_id;
            NSString *payment_method;
            payment_method = self.configures.model.payment_method;
            task_id = self.configures.model.task_id;
            if ([payment_method isEqualToString: @"1"]) {
                //网络销售
                [self gotoBUserPostPositionVC_task_id:task_id];
            }else{
                //其他兼职
                [self gotoBUserPostPartTimeJobVC_task_id:task_id];
            }
            
        }else if ([self.configures.model.status isEqualToString:Position_Downline]) {
            //下线状态
            [self updateTaskStatusRequestWithStatus:Position_Online];
            
        }
    }else if (_viewType == JMCDetailDefaultType) {
        //游客状态
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
        
    }
//    else if ([userModel.card_status isEqualToString:Card_NOIdentify] || [userModel.card_status isEqualToString:Card_RefuseIdentify]){
//        //是否通过实名认证
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"实名认证通过后才能申请任务" preferredStyle: UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"去实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }]];
//
//        [self presentViewController:alert animated:YES completion:nil];
//    }else if ([userModel.card_status isEqualToString:Card_WaitIdentify]){
//        //审核中状态
//        [self showAlertSimpleTips:@"提示" message:@"实名认证审核中，暂时无法申请任务" btnTitle:@"好的"];
//    }
    else{
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

//B端发布网络销售任务
-(void)gotoBUserPostPositionVC_task_id:(NSString *)task_id{
    JMBUserPostSaleJobViewController *vc = [[JMBUserPostSaleJobViewController alloc]init];
    vc.viewType = JMBUserPostSaleJobViewTypeEdit;
    vc.task_id = task_id;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

//B端发布普通任务
-(void)gotoBUserPostPartTimeJobVC_task_id:(NSString *)task_id{
    JMBUserPostPartTimeJobViewController *vc = [[JMBUserPostPartTimeJobViewController alloc]init];
    vc.viewType = JMBUserPostPartTimeJobTypeEdit;
    vc.task_id = task_id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - myDelegate

-(void)shareViewCancelAction{
    [self hiddenChoosePayView];
}

-(void)shareViewLeftAction{
//    [self wxShare:0];
    [self hiddenChoosePayView];
    [self shareMiniProgram];
    
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
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:url videoID:@"666"];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [JMVideoPlayManager sharedInstance].viewType = JMVideoPlayManagerTypeDefault;
    [self presentViewController:playVC animated:YES completion:nil];
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
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
        lab.text = @"     图片介绍";
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        lab.backgroundColor = [UIColor whiteColor];
        return lab;
        
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
        //图片
        return 44;
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
        if (self.configures.model.images.count > 0) {
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
            return cell;
            
        }else{
            //没有图片
            JMNoDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMNoDataTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
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
            if (_viewType == JMCDetailPreviewType) {
                cell.textLabel.text = @"  预览模式不显示评论";

            }else if (_viewType == JMCDetailDefaultType){
                cell.textLabel.text = @"  暂无评价";

            }
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
//        vc.address = self.configures.model.address;
//        vc.latitude = self.configures.model.latitude;
//        vc.longitude = self.configures.model.longitude;
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
        [_tableView registerNib:[UINib nibWithNibName:@"JMNoDataTableViewCell" bundle:nil] forCellReuseIdentifier:JMNoDataTableViewCellIdentifier];

        
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
        _BGShareView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
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
