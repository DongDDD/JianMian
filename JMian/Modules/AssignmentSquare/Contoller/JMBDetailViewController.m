//
//  JMBDetailViewController.m
//  JMian
//
//  Created by mac on 2019/9/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBDetailViewController.h"
#import "JMShareView.h"
#import "JMHTTPManager+FectchAbilityInfo.h"
#import "JMBDetailCellConfigures.h"
#import "JMHTTPManager+FectchCommentInfo.h"
#import "JMVideoPlayManager.h"
#import "JMBDetailVideoView.h"
#import "JMHTTPManager+CompanyLike.h"
#import "WXApi.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMMessageListModel.h"
#import "JMChatViewController.h"
#import "JMVideoChatView.h"

@interface JMBDetailViewController ()<UITableViewDelegate,UITableViewDataSource,JMBDetailVideoTableViewCellDelegate,JMBDetailVideoViewDelegate,JMShareViewDelegate,JMVideoChatViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) JMShareView *shareView;
@property (nonatomic ,strong) UIView *BGShareView;
@property (nonatomic, strong) JMBDetailVideoView *videoView;

@property (nonatomic ,strong) JMBDetailCellConfigures *configures;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) JMVideoChatView *videoChatView;

@end

@implementation JMBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.title = @"个人任务简历";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

-(void)initView{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.shareView];
    [self.view addSubview:self.BGShareView];
    [self.BGShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.shareView.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomView.mas_top);
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

#pragma mark - Action
-(void)right2Action{
    [self showShareView];
}

-(void)rightAction:(UIButton *)sender{
        sender.selected = !sender.selected;
        if (sender.selected) {
            [[JMHTTPManager sharedInstance]createLikeWith_type:nil Id:self.ability_id mode:@"2" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                
                [self showAlertSimpleTips:@"提示" message:@"收藏成功" btnTitle:@"好的"];
                
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
            }];
            
        }else{
            
            [[JMHTTPManager sharedInstance]deleteLikeWith_Id:self.configures.model.favorites_id  mode:@"2" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                
                [self showAlertSimpleTips:@"提示" message:@"取消收藏" btnTitle:@"好的"];
                
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
            }];
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
//    [UIView animateWithDuration:0.18 animations:^{
//        self.choosePayView.frame =CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
//
//
//    }];
    
}

- (IBAction)bottomLeftAction:(UIButton *)sender {
    [self createChatRequstWithForeign_key:self.ability_id user_id:self.configures.model.user_userId];
}

- (IBAction)bottomRightAction:(UIButton *)sender {
    [self gotoVideoChatViewWithForeign_key:self.ability_id recipient:self.configures.model.user_userId chatType:@"2"];
}

-(void)gotoVideoChatViewWithForeign_key:(NSString *)foreign_key
                              recipient:(NSString *)recipient
                               chatType:(NSString *)chatType{
    _videoChatView = [[JMVideoChatView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    _videoChatView.delegate = self;
    _videoChatView.tag = 222;
    [_videoChatView createChatRequstWithForeign_key:foreign_key recipient:recipient chatType:chatType];
    //[_videoChatView setInterviewModel:nil];
    [self.view addSubview:_videoChatView];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - data

-(void)getData{
    [self showProgressHUD_view:self.view];
    self.HUDbackgroundView.alpha = 1;

    [[JMHTTPManager sharedInstance]fectchAbilityDetailInfo_Id:self.ability_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            
            self.configures.model = [JMBDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            //判断是否有被收藏过
            [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
            //标题
            //判断是否有视频
            if (self.configures.model.video_file_path.length > 0 && [self.configures.model.video_status isEqualToString:@"2"]) {
                
                self.tableView.tableHeaderView = self.videoView;
                [self.videoView setModel:self.configures.model];
                
            }else{
                self.tableView.tableHeaderView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
            }
            [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
            
//            NSMutableArray *imgArr = [NSMutableArray array];
//            for (JMBDetailImageModel *imgModel in self.configures.model.images) {
//                if ([imgModel.status isEqualToString:@"2"]) {
//                    [imgArr addObject:imgModel];
//                }
//            }
//            JMCDetailImageModel *imgModel;
//            for (JMBDetailImageModel *imgModel in imgArr) {
//                UIImageView *imageView = [[UIImageView alloc]init];
//
//                [imageView sd_setImageWithURL:[NSURL URLWithString:imgModel.file_path] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    CGFloat imgHeight = image.size.height * SCREEN_WIDTH / image.size.width;
////                    NSLog(@"宽：%f, 高：%f", image.size.width, self.height);
//                    NSLog(@"图片加载完了1");
//
//                }];
//
//            }
            [self getCommentInfo];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)getCommentInfo{
    [[JMHTTPManager sharedInstance]fectchCommentInfoWithTask_order_id:nil order_id:nil user_id:self.configures.model.user_userId company_id:nil page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.configures.commentListArray = [JMCommentCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
            [self hiddenHUD];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
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

#pragma mark - myDelegate
-(void)playVideoActionWithUrl:(NSString *)url{
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:url];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    [[JMVideoPlayManager sharedInstance] play];


}

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

//JMVideoChatViewDelegate 挂断
-(void)hangupAction_model:(JMInterViewModel *)model{
    
    [_videoChatView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO];
    
}

//-(void)didGetPicH{
//    [self.tableView reloadData];
//
//}

#pragma mark - UITableViewDataSource

//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
//        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor redColor];
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.configures numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self.configures heightForRowsInSection:indexPath];;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
        lab.text = @"     图片介绍";
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        lab.backgroundColor = [UIColor whiteColor];
        return lab;
        
    }if (section == 3) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
        lab.text = @"     接单记录";
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        lab.backgroundColor = [UIColor whiteColor];
        return lab;
        
    }
    return [UIView new];

}

//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
       return 44;
    }else if (section == 3) {
        return 44;
    }
    return 1;

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
            JMBDetailHeaderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMBDetailHeaderInfoTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.configures.model];

            //任务简历简介
            return cell;
   
    }else if (indexPath.section == 1) {
          //自我介绍
        JMCDetailTaskDecri2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailTaskDecri2TableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentDecri = self.configures.model.myDescription;
        return cell;
        
    }else if (indexPath.section == 2) {
        //图片
        NSMutableArray *imgArr = [NSMutableArray array];
        for (JMBDetailImageModel *imgModel in self.configures.model.images) {
            if ([imgModel.status isEqualToString:@"2"]) {
                
                [imgArr addObject:imgModel];
            }
        }
        //审核通过后的图片
        if (imgArr.count > 0 ) {
                JMCDetailImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailImageTableViewCellIdentifier forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                JMBDetailImageModel *imgModel = imgArr[indexPath.row];
                [cell setUrl:imgModel.file_path];
                return cell;
            
        }else{
            //没有图片或者没有审核通过的图片
            JMNoDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMNoDataTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
      
    }else if (indexPath.section == 3) {
        //接单记录
        if (self.configures.commentListArray.count > 0) {
            JMCDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailCommentTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            JMCommentCellData *data = self.configures.commentListArray[indexPath.row];
            [cell setData:data];
            //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
            
        }else{
            //无接单评价
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nilCell"];
            
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"nilCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.textLabel.text = @"  暂无评价";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = kFont(14);
            cell.textLabel.textColor = TEXT_GRAY_COLOR;
            return cell;
        }
    }
    
    return nil;
}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        NSLog(@"asd");
//        JMCompanyDetailViewController *vc = [[JMCompanyDetailViewController alloc]init];
//        vc.company_id = self.configures.model.user_company_id;
//        vc.address = self.configures.model.address;
//        vc.latitude = self.configures.model.latitude;
//        vc.longitude = self.configures.model.longitude;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//
//}

#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n
{   //检测是否安装微信
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = self.configures.model.user_nickname;
    urlMessage.description = self.configures.model.type_label_name ;
    
    UIImage *image = [self handleImageWithURLStr:self.configures.model.user_avatar];
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
    object.path = [NSString stringWithFormat:@"pages/ability_info/ability_info?id=%@",self.ability_id];
    //缩略图,压缩图片,不超过 32 KB
    UIImage *image = [self handleImageWithURLStr:self.configures.model.user_avatar];
    NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
    object.hdImageData = thumbData;
    object.withShareTicket = @"";
    object.miniProgramType = WXMiniProgramTypeRelease;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.configures.model.user_nickname;
    message.description = @"";
    message.thumbData = thumbData;  //兼容旧版本节点的图片，小于32KB，新版本优先
    //使用WXMiniProgramObject的hdImageData属性
    message.mediaObject = object;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;  //目前只支持会话
    [WXApi sendReq:req];
    
}


//压缩处理
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
#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 5;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
        _tableView.sectionFooterHeight = 5;
//        [_tableView registerNib:[UINib nibWithNibName:@"JMBDetailVideoTableViewCell" bundle:nil] forCellReuseIdentifier:JMBDetailVideoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMBDetailHeaderInfoTableViewCell" bundle:nil] forCellReuseIdentifier:JMBDetailHeaderInfoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecri2TableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailTaskDecri2TableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailImageTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailImageTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailCommentTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailCommentTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMNoDataTableViewCell" bundle:nil] forCellReuseIdentifier:JMNoDataTableViewCellIdentifier];


        
    }
    return _tableView;
}

-(JMBDetailCellConfigures *)configures{
    if (!_configures) {
        _configures = [[JMBDetailCellConfigures alloc]init];
    }
    return _configures;
}

-(JMBDetailVideoView *)videoView{
    if (!_videoView) {
        _videoView = [[JMBDetailVideoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
        _videoView.delegate = self;
    }
    return _videoView;
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
