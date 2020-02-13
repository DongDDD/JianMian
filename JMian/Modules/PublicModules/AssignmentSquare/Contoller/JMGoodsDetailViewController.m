//
//  JMGoodsDetailViewController.m
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsDetailViewController.h"
#import "JMGoodsDetailConfigures.h"
#import "JMHTTPManager+GetGoodsInfo.h"
#import "JMHTTPManager+GetGoodsList.h"
#import <WebKit/WebKit.h>
#import "DimensMacros.h"
#import "JMVideoPlayManager.h"
#import "JMCreatChatAction.h"
#import "JMHTTPManager+CreateTaskOrder.h"
#import "JMTaskApplyForView.h"
#import "JMPostPartTimeResumeViewController.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMSendCustumMsg.h"
#import "WXApi.h"
#import "JMPublicShareView.h"


@interface JMGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,JMGoodsDescTableViewCellDelegate,WKNavigationDelegate,JMCDetailVideoTableViewCellDelegate,JMPublicShareViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JMGoodsDetailConfigures *configures;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) UIView *windowViewBGView;
@property (nonatomic, strong) JMTaskApplyForView *taskApplyForView;
@property (nonatomic, strong) JMPublicShareView *shareView;
@property (weak, nonatomic) IBOutlet UILabel *haveApplyfor;

@end

@implementation JMGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    if (_viewType == JMGoodsDetailSnapshootType) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];
        [self.shareView hide];
        [self.bottomView setHidden:YES];
        [self setRightBtnImageViewName:@"jobDetailShare" imageNameRight2:@""];
          [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view);
        }];
    }else if (_viewType == JMGoodsDetailDefaultType) {
        self.haveApplyfor.text =  [NSString stringWithFormat:@"%@人已报名",self.effective_count];
        
    }

//    self.webView = [[WKWebView alloc] init];
//    // 加载网页
//
//    self.webView.scrollView.scrollEnabled = NO;
//    self.webView.scrollView.bounces = NO;
//    self.webView.scrollView.showsVerticalScrollIndicator = NO;
//    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//
    // 将webView添加到界面
    [self getData];

//    self.webView.delegate = self;

    // Do any additional setup after loading the view from its nib.
}



//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    //HTML5的高度
//    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
//    //HTML5的宽度
//    NSString *htmlWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"];
//   //宽高比
//    float i = [htmlWidth floatValue]/[htmlHeight floatValue];
////    CGFloat h = [htmlHeight floatValue];
//    float height = SCREEN_WIDTH/i;
//
//    CGRect frame = webView.frame;
//
//     CGSize size = [webView sizeThatFits:CGSizeZero];
//
//     frame.size = size;
//
//     webView.frame = frame;
//    self.configures.webViewHeight = frame.size.height;
//    NSString *output = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementByIdx_x_x_x("foo").offsetHeight;"];
//
//    NSLog(@"height: %@", output);
//    [self.tableView reloadData];
//    //webview控件的最终高度
//
//}

-(void)rightAction{
    [self.shareView show];
}

- (IBAction)bottomLeftAction:(UIButton *)sender {
              [JMCreatChatAction createC2CTypeChatRequstWithChat_type:@"2" foreign_key:self.task_id user_id:self.configures.model.shop_user_id sender_mark:@"" recipient_mark:@""];
}


- (IBAction)bottomRightAction:(UIButton *)sender {
    NSString *isRead = kFetchMyDefault(@"isRead");
          if ([isRead isEqualToString:@"1"]) {
              //判断有是否符合申请条件
              [self applyForAction];
          }else{
              //服务提醒
              [self showApplyForView];
          }
    
}


-(void)showApplyForView{
    [self.taskApplyForView setHidden:NO];
    [self.windowViewBGView setHidden:NO];
    
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

    else{
        [self sendResquest];
    
    }
}

#pragma mark - data

-(void)getData{
    [[JMHTTPManager sharedInstance]getGoodsInfoWithGoods_id:self.goods_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.configures.model = [JMGoodsInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [self getGoodsListWithShop_id:self.configures.model.shop_id];
//                [self.webView loadHTMLString:self.configures.model.goods_description baseURL:nil];
//             self getGoodsListWithShop_id:self.configures.model
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

-(void)getGoodsListWithShop_id:(NSString *)shop_id{
    [[JMHTTPManager sharedInstance]getGoodsListWithShop_id:shop_id status:@"" keyword:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

        if (responsObject[@"data"]) {
            NSArray *arr = [JMGoodsData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            NSMutableArray *goodsList = [NSMutableArray array];
            for (JMGoodsData *data in arr) {
                if (data.goods_id != self.goods_id) {
                    [goodsList addObject:data];
                }
            }
            self.configures.goodsListArray = goodsList.copy;
            [self.tableView reloadData];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

//申请职位
-(void)sendResquest{

        [[JMHTTPManager sharedInstance]createTaskOrder_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            //            [self showAlertSimpleTips:@"提示" message:@"申请成功" btnTitle:@"好的"];
            [self showAlertVCSucceesSingleWithMessage:@"申请已发出" btnTitle:@"好的"];
            //创建自定义消息
            [self createChatToSendCustumMessageRequstWithForeign_key:self.task_id user_id:self.configures.model.shop_user_id];
            //            [self setTaskMessage_receiverID:receiverId dic:nil title:@"任务提醒"];
            
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
}

//申请任务后的创建聊天，用来发送自定义消息
-(void)createChatToSendCustumMessageRequstWithForeign_key:(NSString *)foreign_key user_id:(NSString *)user_id{
    
    [[JMHTTPManager sharedInstance]createChat_type:@"2" recipient:user_id foreign_key:foreign_key sender_mark:@"" recipient_mark:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        //        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        //
        NSString *receiverId = [NSString stringWithFormat:@"%@b",self.configures.model.shop_user_id];
        [JMSendCustumMsg setCustumMessage_receiverID:receiverId dic:nil title:@"[任务申请]"];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark - delegate
//-(void)getGoodsH:(CGFloat)H {
////    if (self.configures.webViewHeight != H) {
////        self.configures.webViewHeight = H;
////        [self.tableView reloadData];
////
////    }
//}

-(void)playVideoActionWithUrl:(NSString *)url{
     [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:url videoID:@""];
      [[JMVideoPlayManager sharedInstance] play];
      AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
      [JMVideoPlayManager sharedInstance].viewType = JMVideoPlayManagerTypeDefault;
      [self presentViewController:playVC animated:YES completion:nil];

}

-(void)didClickShareActoinWithTag:(NSInteger)tag{
    if (tag == 1000) {
         [self wxShare:0];
        [self.shareView hide];

    }else if (tag == 1001) {
        [self.shareView hide];
        [self wxShare:1];
    }

}

#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n
{   //检测是否安装微信
    
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = self.configures.model.title;
    urlMessage.description = self.configures.model.goods_description;
    
    //    UIImageView *imgView = [[UIImageView alloc]init];
    //    [imgView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.company_logo_path]];
    //
    
    NSString *url;
    if (self.configures.model.images.count > 0) {
        for (int i = 0; i < self.configures.model.images.count; i++) {
            JMGoodsInfoImageModel *imgModel = self.configures.model.images[0];
            url = imgModel.file_path;
        }
        
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
    NSString *shareUrl = [NSString stringWithFormat:@"http://www.jianmian.com/static/shop/#/shop_info?id=%@&task_order_id=%@",self.configures.model.goods_id,self.task_order_id];

    webObj.webpageUrl = shareUrl;
    
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

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (self.configures.webViewHeight == 0) {
        [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            // 计算webView高度
            self.configures.webViewHeight = [result doubleValue]/2.5;
            // 刷新tableView
            [self.tableView reloadData];
        }];
         
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 判断webView所在的cell是否可见，如果可见就layout
    NSArray *cells = self.tableView.visibleCells;
    for (UITableViewCell *cell in cells) {
        if ([cell isKindOfClass:[JMGoodsDescTableViewCell class]]) {
            JMGoodsDescTableViewCell *webCell = (JMGoodsDescTableViewCell *)cell;
            
            [webCell.webView setNeedsLayout];
        }
    }
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.configures numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.configures heightForRowsInSection:indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.configures heightForFooterInSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.configures heightForHeaderInSection:section];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == JMGoodsDetailCellTypeSDC) {
        JMScrollviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMScrollviewTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableArray *imagesURLStrings = [NSMutableArray array];
        for (JMGoodsInfoImageModel *model in self.configures.model.images) {
            NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_ImageSTRING,model.file_path];
            [imagesURLStrings addObject:url];
        }
        if (imagesURLStrings.count > 0) {
            [cell setImagesArr:imagesURLStrings];

        }
        return cell;
    }
    else if (indexPath.section == JMGoodsDetailCellTypeTitle){
        JMGoodsDetialTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMGoodsDetialTitleTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.configures.model];
//        [cell setModel:self.configures.model];
        return cell;
    }
    else if (indexPath.section == JMGoodsDetailCellTypeVideo){
        JMCDetailVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailVideoTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell setGoodInfoModel:self.configures.model];
        //        [cell setModel:self.configures.model];
        return cell;
    }
    else if (indexPath.section == JMGoodsDetailCellTypeDesc){
        JMGoodsDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMGoodsDescTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.webView.navigationDelegate = self;
        [cell setDescStr:self.configures.model.goods_description];
        [cell.webView loadHTMLString:self.configures.model.goods_description baseURL:nil];

//        [cell setModel:self.configures.model];
        return cell;
    }
//    else if (indexPath.section == JMGoodsDetailCellTypeImages){
//        JMCDetailImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailImageTableViewCellIdentifier forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        //        [cell setModel:self.configures.model];
//        return cell;
//    }
    else if (indexPath.section == JMGoodsDetailCellTypeMicrotitle){
        JMGoodsDetailMicrotitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMGoodsDetailMicrotitleTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //            [cell setModel:self.configures.model];
        return cell;
    }
    else if (indexPath.section == JMGoodsDetailCellTypeStoreGoods){
        JMCSaleTypeDetailGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCSaleTypeDetailGoodsTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setGoodsArray:self.configures.goodsListArray];
        return cell;
    }
    
    return nil;
}

#pragma mark - lazy

-(JMGoodsDetailConfigures *)configures{
    if (!_configures) {
        _configures = [[JMGoodsDetailConfigures alloc]init];
    }
    return _configures;
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
        [_tableView registerNib:[UINib nibWithNibName:@"JMScrollviewTableViewCell" bundle:nil] forCellReuseIdentifier:JMScrollviewTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMGoodsDetialTitleTableViewCell" bundle:nil] forCellReuseIdentifier:JMGoodsDetialTitleTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecri2TableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailDecri2TableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMGoodsDescTableViewCell" bundle:nil] forCellReuseIdentifier:JMGoodsDescTableViewCellIdentifier];

        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailVideoTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailVideoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailImageTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailImageTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCSaleTypeDetailGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:JMCSaleTypeDetailGoodsTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMGoodsDetailMicrotitleTableViewCell" bundle:nil] forCellReuseIdentifier:JMGoodsDetailMicrotitleTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCSaleTypeDetailGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:JMCSaleTypeDetailGoodsTableViewCellIdentifier];


        
    }
    return _tableView;
}

-(JMPublicShareView *)shareView{
    if (!_shareView) {
        _shareView = [[JMPublicShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _shareView.delegate = self;
    }
    return _shareView;

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
