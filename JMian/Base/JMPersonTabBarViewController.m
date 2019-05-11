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


@interface JMPersonTabBarViewController ()

@end

@implementation JMPersonTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"home" selectedImage:@"pitch_on_home"];
    
    
    JMMessageViewController *message = [[JMMessageViewController alloc] init];
    
    
    [self addChildVc:message title:@"消息" image:@"home_ message" selectedImage:@"home_ message_pitch_on"];
    
    JMMineViewController *mine = [[JMMineViewController alloc] init];
    
    [self addChildVc:mine title:@"我的" image:@"home_me" selectedImage:@"home_me_pitch_on"];
    
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置标题
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


@end
