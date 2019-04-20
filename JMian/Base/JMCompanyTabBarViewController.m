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

@interface JMCompanyTabBarViewController ()

@end

@implementation JMCompanyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //B端
    JMCompanyHomeViewController *companyHome = [[JMCompanyHomeViewController alloc]init];
    [self addChildVc:companyHome title:@"首页" image:@"home" selectedImage:@"pitch_on_home"];
    
    JMPostJobHomeViewController *post = [[JMPostJobHomeViewController alloc]init];
    [self addChildVc:post title:@"发布" image:@"post_a_job" selectedImage:@"post_a_job_pitch_up"];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
