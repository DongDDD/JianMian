//
//  BaseViewController.m
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+addGradualLayer.h"
#import "JMHTTPManager+Login.h"
@interface BaseViewController ()
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) UIView *HUDbackgroundView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
//    self.navigationController.navigationBar.translucent = NO;
//
//    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBackBtnImageViewName:@"icon_return_nav" textName:@""];
  
}

-(void)setIsHiddenBackBtn:(BOOL)isHiddenBackBtn
{
    if (isHiddenBackBtn) {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
    
}

-(void)setIsHiddenRightBtn:(BOOL)isHiddenBackBtn
{
    if (isHiddenBackBtn) {
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }else{
        self.navigationItem.hidesBackButton = NO;

    }
    
}


-(void)setTitleViewImageViewName:(NSString *)imageName{
  
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    
}


-(void)setTitle:(NSString *)title{
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 80, 50)];
    
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.textColor = TITLE_COLOR;
    
    [titleText setFont:[UIFont systemFontOfSize:16.0]];
    
    [titleText setText:title];
    
    self.navigationItem.titleView=titleText;
    
    
}


- (void)setBackBtnImageViewName:(NSString *)imageName textName:(NSString *)textName{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 19)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 21);
    [leftBtn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(leftBtn.frame.origin.x+leftBtn.frame.size.width-5, 0, 100,leftBtn.frame.size.height)];
    leftLab.text = textName;
    leftLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    leftLab.font = [UIFont systemFontOfSize:13];
    
    [bgView addSubview:leftLab];
    [bgView addSubview:leftBtn];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)setRightBtnTextName:(NSString *)rightLabName{
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:rightLabName forState:UIControlStateNormal];
    [rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


- (void)setRightBtnImageViewName:(NSString *)imageName  imageNameRight2:(NSString *)imageNameRight2 {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *colectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colectBtn.frame = CGRectMake(45, 0, 25, 25);
    [colectBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [colectBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
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




-(void)rightAction{
    
    
    
    
}


-(void)right2Action{
    
    
    
    
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

-(void)showHUD{
    [_myProgressHUD setHidden:NO];
    [_HUDbackgroundView setHidden:NO];

}

-(void)hiddenHUD{
    [self.myProgressHUD setHidden:YES];
    [_HUDbackgroundView setHidden:YES];

    
}


-(void)showProgressHUD_view:(UIView *)view{
    _HUDbackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _HUDbackgroundView.backgroundColor = [UIColor whiteColor];
//    [view addSubview:_HUDbackgroundView];
    _myProgressHUD = [[MBProgressHUD alloc] initWithView:view];
//    _progressHUD.progress = 0.6;
    //        _progressHUD.dimBackground = NO; //设置有遮罩
//    _progressHUD.label.text = @"加载中..."; //设置进度框中的提示文字
    _myProgressHUD.alpha = 0.5;//设置遮罩透明度 = 1;
    _myProgressHUD.dimBackground = NO; //设置有遮罩
    [_myProgressHUD showAnimated:YES]; //显示进度框
    [view addSubview:_myProgressHUD];
    
}

-(void)showAlertVCWithHeaderIcon:(NSString *)headerIcon
                         message:(NSString *)message
                       leftTitle:(NSString *)leftTitle
                      rightTitle:(NSString *)rightTitle

{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n" message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self iconAlertLeftAction];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self iconAlertRightAction];
    }]];
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:headerIcon];
    [alert.view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(alert.view).mas_offset(23);
        make.centerX.mas_equalTo(alert.view);
        make.size.mas_equalTo(CGSizeMake(75, 64));
        
    }];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self alerLeftAction];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self alertRightAction];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)showAlertSimpleTips:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
 
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)iconAlertLeftAction{
    
}

-(void)iconAlertRightAction{
    
    
}

-(void)alerLeftAction{
    
}

-(void)alertRightAction{
    
    
}



- (id)toArrayOrNSDictionary:(NSData *)jsonData{
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}
//-(MBProgressHUD *)progressHUD{
//    if (!_progressHUD) {
//        _progressHUD = [[MBProgressHUD alloc] init];
//        _progressHUD.progress = 0.6;
////        _progressHUD.dimBackground = NO; //设置有遮罩
//        _progressHUD.label.text = @"加载中..."; //设置进度框中的提示文字
////        _progressHUD.alpha = 1;//设置遮罩透明度 = 1;
//        _progressHUD.dimBackground = YES; //设置有遮罩
//        [_progressHUD showAnimated:YES]; //显示进度框
//    }
//    return _progressHUD;
//}

    @end
