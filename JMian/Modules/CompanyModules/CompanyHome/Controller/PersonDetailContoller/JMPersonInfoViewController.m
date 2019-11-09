//
//  JMPersonInfoViewController.m
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPersonInfoViewController.h"
//数据对接 布局
#import "JMPersonInfoConfigures.h"
#import "JMHTTPManager+Vita.h"
#import "JMMyShareView.h"
//聊天模块
#import "JMChatViewController.h"
#import "JMHTTPManager+CreateConversation.h"
//面试
#import "THDatePickerView.h"
#import "JMHTTPManager+InterView.h"
//视频播放
#import "JMPlayerViewController.h"
#import "JMVideoPlayManager.h"
//////
#import "JMHTTPManager+CompanyLike.h"
#import "JMHTTPManager+Login.h"
#import "WXApi.h"
#import "JMMessageListModel.h"
//发送提醒（小红点）
#import "JMSendCustumMsg.h"

//VIP
#import "JMVIPViewController.h"
@interface JMPersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource,THDatePickerViewDelegate,JMMyShareViewDelegate,JMPersonVideoTableViewCellDelegate,JMPersonContactTableViewCellDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JMPersonInfoConfigures *configures;
@property (copy, nonatomic) NSString *favorite_id;
@property (strong, nonatomic) JMMyShareView *myShareView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
//时间选择
@property (weak, nonatomic) THDatePickerView *dateView;
@property (strong, nonatomic) UIButton *BgBtn;

@end

@implementation JMPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人详情";
    [self getUserInfo];
    [self initView];
    [self getData];
    [self initDatePickerView];

}

-(void)initView{

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.myShareView];
    [self.myShareView setHidden:YES];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
    }];
    [self.myShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.left.and.right.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.top.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];

}

//时间选择器
-(void)initDatePickerView
{
    self.BgBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    self.BgBtn.backgroundColor = [UIColor blackColor];
    self.BgBtn.hidden = YES;
    self.BgBtn.alpha = 0.3;
    [[UIApplication sharedApplication].keyWindow addSubview:self.BgBtn];
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.tableView.frame.size.width, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    //    dateView.isSlide = NO;
    //    dateView.date = @"2017-03-23 12:43";
    //    dateView.minuteInterval = 1;
    [[UIApplication sharedApplication].keyWindow addSubview:dateView];
    self.dateView = dateView;
    
}

- (void)setRightBtnImageViewName:(NSString *)imageName  imageNameRight2:(NSString *)imageNameRight2 {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *colectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colectBtn.frame = CGRectMake(45, 0, 25, 25);
    if (self.configures.model.favorites_favorite_id) {
        self.favorite_id = self.configures.model.favorites_favorite_id;
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

#pragma mark - 获取数据
-(void)getData{
    [self showProgressHUD_view:self.view];
    self.HUDbackgroundView.alpha = 1;

    
    
    [[JMHTTPManager sharedInstance] fetchJobInfoWithId:_user_job_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.configures.model = [JMVitaDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            [self.tableView reloadData];
            [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
            [self hiddenHUD];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

-(void)getUserInfo{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

#pragma mark - Action

-(void)right2Action{
    [self.myShareView setHidden:NO];


}
-(void)rightAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [[JMHTTPManager sharedInstance]createLikeWith_type:nil Id:self.configures.model.user_job_id  mode:@"1" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
            if ([responsObject objectForKey:@"data"]) {
                self.favorite_id = [responsObject objectForKey:@"data"][@"favorite_id"];
                
            }
             
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        if (self.favorite_id.length > 0) {
            [[JMHTTPManager sharedInstance]deleteLikeWith_Id:self.favorite_id mode:@"1"  SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已取消收藏"
                                                              delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [alert show];
                
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
            }];
            
        }
    }
    
}

- (IBAction)bottomLeftAction:(id)sender {
    [[JMHTTPManager sharedInstance]createChat_type:@"1" recipient:self.configures.model.user_id foreign_key:self.configures.model.work_label_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        JMChatViewController *vc = [[JMChatViewController alloc]init];
        
        vc.myConvModel = messageListModel;
        [self.navigationController pushViewController:vc animated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

- (IBAction)bottomRightAction:(id)sender {
    self.BgBtn.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [self.dateView show];
    }];
    
}


#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n
{   //检测是否安装微信
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = self.configures.model.user_nickname;
    urlMessage.description = self.configures.model.vita_description ;
    
    
    
    UIImage *image = [self getImageFromURL:self.configures.model.user_avatar];   //缩略图,压缩图片,不超过 32 KB
    NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
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
    object.path = [NSString stringWithFormat:@"pages/person/person?id=%@",self.user_job_id];
    UIImage *image = [self getImageFromURL:self.configures.model.user_avatar];   //缩略图,压缩图片,不超过 32 KB
    NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
    //缩略图,压缩图片,不超过 32 KB
    //    UIImage *image = [self handleImageWithURLStr:url];
    //    NSData *thumbData = UIImageJPEGRepresentation(image, 0.1);
    
    object.hdImageData = thumbData;
    object.withShareTicket = @"";
    object.miniProgramType = WXMiniProgramTypeRelease;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.configures.model.user_nickname;
    //    message.description = self.configures.model.myDescription;
    message.thumbData = nil;  //兼容旧版本节点的图片，小于32KB，新版本优先
    //使用WXMiniProgramObject的hdImageData属性
    message.mediaObject = object;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;  //目前只支持会话
    [WXApi sendReq:req];
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}
#pragma mark - myDelegate

-(void)myShareWechat1{
    [self.myShareView setHidden:YES];
    //分享朋友列表
    [self shareMiniProgram];

}

-(void)myShareWechat2{
    [self.myShareView setHidden:YES];
    //分享朋友圈
     [self wxShare:1];
}

-(void)myShareDeleteAction{
    [self.myShareView setHidden:YES];

}

/**
 时间选择取消
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    self.BgBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    //    self.timerLbl.text = timer;
    
    self.BgBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
    
    
    //同时创建会话
    [[JMHTTPManager sharedInstance]createChat_type:@"1" recipient:self.configures.model.user_id foreign_key:self.configures.model.work_label_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        //发送消息推送
        [[JMHTTPManager sharedInstance]createInterViewWith_user_job_id:self.configures.model.user_job_id time:timer successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邀请成功"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
            NSString *receiver_id = [NSString stringWithFormat:@"%@a",self.configures.model.user_id];
            [JMSendCustumMsg setCustumMessage_receiverID:receiver_id dic:nil title:@"[面试邀请]"];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
    
    
    
}

//播放视频
-(void)playVideoAction
{
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:self.configures.model.video_file_path];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    [[JMVideoPlayManager sharedInstance] play];
    
}


-(void)vipAction{
    JMVIPViewController *vc = [[JMVIPViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.configures numberOfRowsInSection:section];
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self.configures heightForRowsInSection:indexPath];;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        if (self.configures.model.experiences.count > 0) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 80)];
            lab.text = @"     工作经历";
            lab.font = [UIFont boldSystemFontOfSize:20];
            lab.textColor = UIColorFromHEX(0x1A1A1A);;
            lab.backgroundColor = [UIColor whiteColor];
            return lab;
            
        }
        
    }if (section == 5) {
        if (self.configures.model.education.count > 0) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 80)];
            lab.text = @"     教育经历";
            lab.font = [UIFont boldSystemFontOfSize:20];
            lab.textColor = UIColorFromHEX(0x1A1A1A);;
            lab.backgroundColor = [UIColor whiteColor];
            return lab;
            
        }
        
    }if (section == 6) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 80)];
        lab.text = @"    联系方式";
        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.textColor = UIColorFromHEX(0x1A1A1A);;
        lab.backgroundColor = [UIColor whiteColor];
        return lab;
        
    }
    return [UIView new];
    
}

//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        //工作经历
        if (self.configures.model.experiences.count > 0) {
            return 80;
        }
    }else if (section == 5) {
        //教育经历
          if (self.configures.model.education.count > 0) {
              return 80;
          }
    }else if (section == 6) {
        return 80;
    }
    return 0;
    
}

#pragma mark - UITableViewDelegate
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //个人简介
        JMPersonHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPersonHeaderTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.configures.model];
        return cell;
        
    }else if (indexPath.section == 1) {
        //个人视频
        JMPersonVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPersonVideoTableViewCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.configures.model];
        return cell;
    
    }else if (indexPath.section == 2) {
        //求职意向
        JMPersonIntensionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPersonIntensionTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.configures.model];
        return cell;
        
    }else if (indexPath.section == 3) {
        //工作经历
        JMPersonWorkExpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPersonWorkExpTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        JMExperiencesModel *expModel = self.configures.model.experiences[indexPath.row];
        [cell setModel:expModel];
        return cell;
        
    }else if (indexPath.section == 4) {
        //自我介绍
        JMPesonDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPesonDescTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.configures.model];
        return cell;
        
    }else if (indexPath.section == 5) {
        //教育经历
        JMPesonEducationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPesonEducationTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        JMEducationModel *model = self.configures.model.education[indexPath.row];
        [cell setModel:model];
        return cell;
        
    }else if (indexPath.section == 6) {
        //联系方式
        JMPersonContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPersonContactTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell setModel:self.configures.model];
        return cell;
        
    }
    return nil;

}

#pragma mark - lazy

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
        [_tableView registerNib:[UINib nibWithNibName:@"JMPersonHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMPersonHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPersonVideoTableViewCell" bundle:nil] forCellReuseIdentifier:JMPersonVideoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPersonIntensionTableViewCell" bundle:nil] forCellReuseIdentifier:JMPersonIntensionTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPersonWorkExpTableViewCell" bundle:nil] forCellReuseIdentifier:JMPersonWorkExpTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPesonDescTableViewCell" bundle:nil] forCellReuseIdentifier:JMPesonDescTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPesonEducationTableViewCell" bundle:nil] forCellReuseIdentifier:JMPesonEducationTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPersonContactTableViewCell" bundle:nil] forCellReuseIdentifier:JMPersonContactTableViewCellIdentifier];

        
    }
    return _tableView;
}

-(JMPersonInfoConfigures *)configures{
    if (_configures == nil) {
        _configures = [[JMPersonInfoConfigures alloc]init];
    }
    return _configures;
}

-(JMMyShareView *)myShareView{
    if (!_myShareView) {
        _myShareView = [[JMMyShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _myShareView.delegate = self;
        
    }
    return _myShareView;
    
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
