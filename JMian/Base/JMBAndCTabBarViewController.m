//
//  JMBAndCTabBarViewController.m
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBAndCTabBarViewController.h"
#import "JMCompanyHomeViewController.h"
#import "JMPostJobHomeViewController.h"
#import "NavigationViewController.h"
//#import "JMMessageViewController.h"
#import "JMMineViewController.h"
#import "JMHTTPManager+MessageList.h"
#import "JMMessageListModel.h"
#import "JMAllMessageTableViewCellData.h"
#import "DimensMacros.h"
#import "JMDiscoverHomeViewController.h"
#import "JMAssignmentSquareViewController.h"
#import "UITabBar+XSDExt.h"
//#import "JMAllMessageTableViewController.h"
#import "JMMessageListViewController.h"
#import "JMBMineViewController.h"
#import "HomeViewController.h"
#import "iVersion.h"
#import "JMVersionDetailsView.h"

@interface JMBAndCTabBarViewController ()<iVersionDelegate>
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, assign)int unReadNum;
//@property (nonatomic ,strong)JMMessageViewController *message;
@property (nonatomic ,strong)JMMessageListViewController *message;
@property (nonatomic ,strong)JMMineViewController *Cmine;

@property (nonatomic ,strong)JMBMineViewController *Bmine;
@property(nonatomic,strong)UIView *taskBadgeView;
@property(nonatomic,strong)JMVersionDetailsView *versionDetailsView;

@end

@implementation JMBAndCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [iVersion sharedInstance].delegate = self;

    [self getMsgList];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        //B端
        JMCompanyHomeViewController *companyHome = [[JMCompanyHomeViewController alloc]init];
        [self addChildVc:companyHome title:@"全职" image:@"home" selectedImage:@"pitch_on_home" ];
        
        self.message = [[JMMessageListViewController alloc] init];
        [self addChildVc:self.message title:@"消息" image:@"home_ message" selectedImage:@"home_ message_pitch_on"];
        
        JMAssignmentSquareViewController *square = [[JMAssignmentSquareViewController alloc]init];
        [self addChildVc:square title:@"任务广场" image:@"mission" selectedImage:@"garden_pich_on"];
        
        JMDiscoverHomeViewController *discover = [[JMDiscoverHomeViewController alloc]init];
        [self addChildVc:discover title:@"发现" image:@"discovery" selectedImage:@"discovery_pitch_on"];
        
        self.Bmine = [[JMBMineViewController alloc] init];
        [self addChildVc:self.Bmine title:@"我的" image:@"home_me" selectedImage:@"home_me_pitch_on" ];
        
    }else if ([userModel.type isEqualToString:C_Type_USER]) {
        HomeViewController *home = [[HomeViewController alloc] init];
        [self addChildVc:home title:@"全职" image:@"home" selectedImage:@"pitch_on_home"];
        
        self.message = [[JMMessageListViewController alloc] init];
        [self addChildVc:self.message title:@"消息" image:@"home_ message" selectedImage:@"home_ message_pitch_on"];
        JMAssignmentSquareViewController *square = [[JMAssignmentSquareViewController alloc]init];
//        if (_viewType == JMBAndCTabBarViewTypeLogin) {
//            square.isLogin = YES;
//        }
        [self addChildVc:square title:@"任务广场" image:@"mission" selectedImage:@"garden_pich_on"];
       
        JMDiscoverHomeViewController *discover = [[JMDiscoverHomeViewController alloc]init];
        [self addChildVc:discover title:@"发现" image:@"discovery" selectedImage:@"discovery_pitch_on"];
        
        self.Cmine = [[JMMineViewController alloc] init];
        [self addChildVc:self.Cmine title:@"我的" image:@"home_me" selectedImage:@"home_me_pitch_on" ];
        
    }
    [self setSelectedIndex:2];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewMessage:) name:TUIKitNotification_TIMMessageListener object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskNotification:) name:Notification_TaskListener object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderNotification:) name:Notification_OrderListener object:nil];


}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//- (void)iVersionDidDetectNewVersion:(NSString *)version details:(NSString *)versionDetails{
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *nowVersionStr = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    BOOL isNeedUpDate = [self compareVersion:version toVersion:nowVersionStr];
//    if (isNeedUpDate) {
//        NSLog(@"需要更新");
//        NSLog(@"versionDetails:%@ %@",version,versionDetails);
//        [self.view addSubview:self.versionDetailsView];
//
//        //        [[UIApplication sharedApplication].keyWindow addSubview:self.versionDetailsView];
//    }
//    
//}

- (BOOL)compareVersion:(NSString *)version1 toVersion:(NSString *)version2
{
    NSArray *list1 = [version1 componentsSeparatedByString:@"."];
    NSArray *list2 = [version2 componentsSeparatedByString:@"."];
    for (int i = 0; i < list1.count || i < list2.count; i++)
    {
        NSInteger a = 0, b = 0;
        if (i < list1.count) {
            a = [list1[i] integerValue];
        }
        if (i < list2.count) {
            b = [list2[i] integerValue];
        }
        if (a > b) {
            return YES;//version1大于version2
        } else if (a < b) {
            return NO;//version1小于version2
        }
    }
    return NO;//version1等于version2
    
}

- (void)onNewMessage:(NSNotification *)notification
{
    
    [self getMsgList];
}

- (void)orderNotification:(NSNotification *)notification
{
    //B端
//    if (self.Bmine.BUserCenterHeaderSubView.taskBadgeView.hidden == NO) {
//        self.Bmine.tabBarItem.badgeValue = @"2";
//
//    }else{
//        self.Bmine.tabBarItem.badgeValue = @"1";
//
//    }
    [self.Bmine.BUserCenterHeaderSubView.orderBadgeView setHidden:NO];
    //C端
//    if (self.Cmine.personalCenterHeaderView.taskBadgeView.hidden == NO) {
//        self.Cmine.tabBarItem.badgeValue = @"2";
//
//    }else{
//        self.Cmine.tabBarItem.badgeValue = @"1";
//
//    }
    [self.Cmine.personalCenterHeaderView.orderBadgeView setHidden:NO];
}

- (void)taskNotification:(NSNotification *)notification
{
    //B端
//    if (self.Bmine.BUserCenterHeaderSubView.orderBadgeView.hidden == NO) {
//        self.Bmine.tabBarItem.badgeValue = @"2";
//
//    }else{
//        self.Bmine.tabBarItem.badgeValue = @"1";
//
//    }
    [self.Bmine.BUserCenterHeaderSubView.taskBadgeView setHidden:NO];
    //C端
//    if (self.Cmine.personalCenterHeaderView.orderBadgeView.hidden == NO) {
//        self.Cmine.tabBarItem.badgeValue = @"2";
//        
//    }else{
//        self.Cmine.tabBarItem.badgeValue = @"1";
//        
//    }
    [self.Cmine.personalCenterHeaderView.taskBadgeView setHidden:NO];
}



#pragma mark - 获取未读消息


-(void)getMsgList{
    
    [[JMHTTPManager sharedInstance]fecthMessageList_mode:@"array" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            
            self.modelArray = [JMMessageListModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self updateConversations]; //获取腾讯云数据
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
    
}

- (void)updateConversations {
    JMUserInfoModel *userInfomodel = [JMUserInfoManager getUserInfo];

    TIMManager *manager = [TIMManager sharedInstance];
    NSArray *convs = [manager getConversationList];
    NSLog(@"腾讯云数据%@",convs);
    _unReadNum = 0;
    for (TIMConversation *conv in convs) {
        if([conv getType] == TIM_SYSTEM){
            continue;
        }
        TIMMessage *msg = [conv getLastMsg];
        NSLog(@"%@",msg);
        for (JMMessageListModel *model in self.modelArray) {
            if (model.sender_user_id == userInfomodel.user_id) {
                //判断sender是不是自己,是自己的话，拿recipient_mark去跟腾讯云的ID配对接收者
                if ([model.recipient_mark isEqualToString:[conv getReceiver]]) {
                    _unReadNum += [conv getUnReadMessageNum];
                }

            }else if(model.recipient_user_id == userInfomodel.user_id){
                //判断recipient是自己的话，拿sender_mark去跟腾讯云的ReceiverID配对接收者

                if ([model.sender_mark isEqualToString:[conv getReceiver]]) {

                    _unReadNum += [conv getUnReadMessageNum];


                }
                
                //服务器系统消息
            }
            
            
        }
        
        if ([[conv getReceiver] isEqualToString:@"dominator"]) {
            _unReadNum += [conv getUnReadMessageNum];
            
        }
    }

    NSLog(@"未读消息数量%d",_unReadNum);
    if (_unReadNum > 0) {
        if (_unReadNum > 99) {
            self.message.tabBarItem.badgeValue = @"99+";

        }else{
            self.message.unReadNum = _unReadNum;
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",self.message.unReadNum];
         
        }
    }else{
        self.message.tabBarItem.badgeValue = nil;
    }
    NSLog(@"红点数量%@",self.message.tabBarItem.badgeValue);

    
}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{

    //设置标题
//    childVc.view
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    //需要设置照片的模式，用照片原图，默认是蓝色的
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //创建修改字体颜色的字典，同时可以设置字体的内边距；
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = UIColorFromHEX(0x797979);
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    //不要忘记添加到父控制器上
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}


-(JMVersionDetailsView *)versionDetailsView{
    if (_versionDetailsView == nil) {
        _versionDetailsView = [[JMVersionDetailsView alloc]init];
        _versionDetailsView.backgroundColor = [UIColor redColor];
        _versionDetailsView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }
    return _versionDetailsView;
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
