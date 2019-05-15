//
//  JMCompanyTabBarViewController.m
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyTabBarViewController.h"
#import "JMCompanyHomeViewController.h"
#import "JMPostJobHomeViewController.h"
#import "NavigationViewController.h"
#import "JMMessageViewController.h"
#import "JMMineViewController.h"
#import "JMHTTPManager+MessageList.h"
#import "JMMessageListModel.h"
#import "JMAllMessageTableViewCellData.h"
#import "DimensMacros.h"

@interface JMCompanyTabBarViewController ()
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, assign)int unReadNum;
@property (nonatomic ,strong)JMMessageViewController *message;
@end

@implementation JMCompanyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //B端
    JMCompanyHomeViewController *companyHome = [[JMCompanyHomeViewController alloc]init];
    [self addChildVc:companyHome title:@"首页" image:@"home" selectedImage:@"pitch_on_home" ];
    
    JMPostJobHomeViewController *post = [[JMPostJobHomeViewController alloc]init];
    [self addChildVc:post title:@"发布" image:@"post_a_job" selectedImage:@"post_a_job_pitch_up" ];
    
    self.message = [[JMMessageViewController alloc] init];
    [self getMsgList];

    [self addChildVc:self.message title:@"消息" image:@"home_ message" selectedImage:@"home_ message_pitch_on" ];

    JMMineViewController *mine = [[JMMineViewController alloc] init];

    [self addChildVc:mine title:@"我的" image:@"home_me" selectedImage:@"home_me_pitch_on" ];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewMessage:) name:Notification_JMMMessageListener object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readMessage:) name:Notification_JMRefreshListener object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)readMessage:(NSNotification *)notification
{
    NSLog(@"readMessagereadMessagereadMessagereadMessagereadMessage");
}
- (void)onNewMessage:(NSNotification *)notification
{
    _unReadNum = 0;
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
    JMUserInfoModel *userInfomodel = [JMUserInfoManager getUserInfo];
    
//    _dataArray = [NSMutableArray array];
    //    15011331133
    TIMManager *manager = [TIMManager sharedInstance];
    NSArray *convs = [manager getConversationList];
    NSLog(@"腾讯云数据%@",convs);
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

                    JMAllMessageTableViewCellData *data = [[JMAllMessageTableViewCellData alloc] init];
                    data.unRead = [conv getUnReadMessageNum];
                    data.convId = [conv getReceiver];
//                    model.data = data;
//                    data.time = [self getDateDisplayString:msg.timestamp];
//                    data.subTitle = [self getLastDisplayString:conv];

                    model.data = data;
//                    [_dataArray addObject:model];

                    _unReadNum += [conv getUnReadMessageNum];
                }
                //                else{
                //                    JMAllMessageTableViewCellData *data = [[JMAllMessageTableViewCellData alloc] init];
                //                    model.data = data;
                //                    [_dataArray addObject:model];
                //
                //                }
            }else if(model.recipient_user_id == userInfomodel.user_id){
                //判断recipient是自己的话，拿sender_mark去跟腾讯云的ReceiverID配对接收者

                if ([model.sender_mark isEqualToString:[conv getReceiver]]) {

                    JMAllMessageTableViewCellData *data = [[JMAllMessageTableViewCellData alloc] init];
                    data.convId = [conv getReceiver];
                    data.unRead = [conv getUnReadMessageNum];
                    model.data = data;
//                    data.time = [self getDateDisplayString:msg.timestamp];
//                    data.subTitle = [self getLastDisplayString:conv];

                    model.data = data;
//                    [_dataArray addObject:model];
                    _unReadNum += [conv getUnReadMessageNum];


                }
                //                else{
                //                    JMAllMessageTableViewCellData *data = [[JMAllMessageTableViewCellData alloc] init];
                //                    model.data = data;
                //                    [_dataArray addObject:model];
                //
                //                }


            }


        }

    }

    NSLog(@"未读消息数量%d",_unReadNum);
    if (_unReadNum != 0) {
        self.message.unReadNum = _unReadNum;
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",self.message.unReadNum];
    }
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
