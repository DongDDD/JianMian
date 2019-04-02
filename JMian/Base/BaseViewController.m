//
//  BaseViewController.m
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+addGradualLayer.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBackBtnImageViewName:@"icon_return" textName:@""];
  
}

-(void)setTitleViewImageViewName:(NSString *)imageName{
  
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    
}

- (void)setBackBtnImageViewName:(NSString *)imageName textName:(NSString *)textName{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 19)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 16, 21);
    [leftBtn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(leftBtn.frame.origin.x+leftBtn.frame.size.width+5, 0, 100,leftBtn.frame.size.height)];
    leftLab.text = textName;
    leftLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    leftLab.font = [UIFont systemFontOfSize:13];
    
    [bgView addSubview:leftLab];
    [bgView addSubview:leftBtn];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)setRightBtnImageViewName:(NSString *)imageNameCollect imageNameShare:(NSString *)imageNameShare{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 65, 19)];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *colectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colectBtn.frame = CGRectMake(30, 0, 25, 25);
    [colectBtn addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    [colectBtn setImage:[UIImage imageNamed:imageNameCollect] forState:UIControlStateNormal];
    [bgView addSubview:colectBtn];
    if (imageNameShare == nil) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.backgroundColor = [UIColor redColor];
        shareBtn.frame = CGRectMake(-10, 0, 25, 25);
        [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        [shareBtn setImage:[UIImage imageNamed:imageNameShare] forState:UIControlStateNormal];
        [bgView addSubview:shareBtn];
        
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.rightBarButtonItem = rightItem;
    


    
    
    
}




-(void)collectAction{
    
    
    
    
}


-(void)shareAction{
    
    
    
    
}

- (void)fanhui {
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //判断现在是第几层的navigationController控制器
    self.tabBarController.tabBar.hidden = self.navigationController.viewControllers.count > 1 ? YES : NO;

}
    @end
