//
//  JMTabBarViewController.m
//  JMian
//
//  Created by chitat on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPersonTabBarViewController.h"
#import "JMMineViewController.h"
#import "DimensMacros.h"
#import "JMMessageViewController.h"
#import "NavigationViewController.h"
#import "HomeViewController.h"
#import "JMCompanyHomeViewController.h"
#import "JMPostJobHomeViewController.h"
#import "JMHTTPManager+MessageList.h"
#import "JMMessageListModel.h"
#import "JMAllMessageTableViewCellData.h"
#import "JMSquareViewController.h"
#import "JMDiscoverHomeViewController.h"
#import "JMAssignmentSquareViewController.h"


@interface JMPersonTabBarViewController () <MCTabBarControllerDelegate>
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, assign)int unReadNum;
@property (nonatomic ,strong)JMMessageViewController *message;

@end

@implementation JMPersonTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //选中时的颜色
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
//    self.mcTabbar.translucent = NO;
//
//    self.mcTabbar.position = MCTabBarCenterButtonPositionBulge;
//    self.mcTabbar.centerImage = [UIImage imageNamed:@"garden"];
//    self.mcTabbar.centerSelectedImage = [UIImage imageNamed:@"garden_pich_on"];
//    self.mcDelegate = self;
//
    [self getMsgList];
 
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"home" selectedImage:@"pitch_on_home"];
    
    
    self.message = [[JMMessageViewController alloc] init];
    
    [self addChildVc:self.message title:@"消息" image:@"home_ message" selectedImage:@"home_ message_pitch_on"];
    
    JMAssignmentSquareViewController *square = [[JMAssignmentSquareViewController alloc]init];
    [self addChildVc:square title:@"任务广场" image:@"mission" selectedImage:@"garden_pich_on"];

    JMDiscoverHomeViewController *discover = [[JMDiscoverHomeViewController alloc]init];
    [self addChildVc:discover title:@"发现" image:@"discovery" selectedImage:@"discovery_pitch_on"];

  
    JMMineViewController *mine = [[JMMineViewController alloc] init];
    
    [self addChildVc:mine title:@"我的" image:@"home_me" selectedImage:@"home_me_pitch_on"];
    [self setSelectedIndex:2];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewMessage:) name:Notification_JMMMessageListener object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)onNewMessage:(NSNotification *)notification
{
    [self getMsgList];
}

#pragma mark - 获取未读消息


-(void)getMsgList{
    
    [[JMHTTPManager sharedInstance]fecthMessageList_mode:@"array" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            
            self.modelArray = [JMMessageListModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self updateConversations]; //获取腾讯云数据
            
            //            [self.tableView reloadData];
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
    
}

- (void)updateConversations {
    
    //    _dataArray = [NSMutableArray array];
    //    15011331133
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
        _unReadNum += [conv getUnReadMessageNum];
//        for (JMMessageListModel *model in self.modelArray) {
//            if (model.sender_user_id == userInfomodel.user_id) {
//                //判断sender是不是自己,是自己的话，拿recipient_mark去跟腾讯云的ID配对接收者
//                if ([model.recipient_mark isEqualToString:[conv getReceiver]]) {
//
//                    _unReadNum += [conv getUnReadMessageNum];
//                }
//
//            }else if(model.recipient_user_id == userInfomodel.user_id){
//
//                if ([model.sender_mark isEqualToString:[conv getReceiver]]) {
//
//                    _unReadNum += [conv getUnReadMessageNum];
//
//                }
//
//            }
//
//        }
//        加上系统消息的未读
//        if ([[conv getReceiver] isEqualToString:@"dominator"]) {
//            _unReadNum += [conv getUnReadMessageNum];
//
//        }
    }
    
    NSLog(@"未读消息数量%d",_unReadNum);
    if (_unReadNum > 0) {
        self.message.unReadNum = _unReadNum;
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",self.message.unReadNum];
    }
}




- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置标题
    
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
//    [childVc.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
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

//// 使用MCTabBarController 自定义的 选中代理
//- (void)mcTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    if (tabBarController.selectedIndex == 2){
//        [self rotationAnimation];
//    }else {
//        [self.mcTabbar.centerBtn.layer removeAllAnimations];
//    }
//}
//
//
////旋转动画
//- (void)rotationAnimation{
//    if ([@"key" isEqualToString:[self.mcTabbar.centerBtn.layer animationKeys].firstObject]){
//        return;
//    }
//    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
//    rotationAnimation.duration = 3.0;
//    rotationAnimation.repeatCount = HUGE;
//    [self.mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
//}

@end
