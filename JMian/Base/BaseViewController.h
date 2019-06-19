//
//  BaseViewController.h
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"


//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44
//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))





NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property(nonatomic,strong)NSString *rightString;

-(void)setIsHiddenBackBtn:(BOOL)isHiddenBackBtn;
//@property(nonatomic,assign)BOOL isHiddenBackBtn;
-(void)setIsHiddenRightBtn:(BOOL)isHiddenBackBtn;

-(void)setRightBtnTextName:(NSString *)rightLabName;

-(void)setTitleViewImageViewName:(NSString *)imageName;

- (void)setBackBtnImageViewName:(NSString *)imageName textName:(NSString *)textName;

- (void)setRightBtnImageViewName:(NSString *)imageName imageNameRight2:(NSString *)imageNameRight2;

- (void)fanhui;

-(void)rightAction;

-(void)right2Action;

@property (nonatomic, strong) MBProgressHUD *myProgressHUD;
-(void)showProgressHUD_view:(UIView *)view;
-(void)showHUD;
-(void)hiddenHUD;

// 将JSON串转化为字典或者数组
- (id)toArrayOrNSDictionary:(NSData *)jsonData;

//弹窗带图标
-(void)showAlertVCWithHeaderIcon:(NSString *)headerIcon
                         message:(NSString *)message
                       leftTitle:(NSString *)leftTitle
                      rightTitle:(NSString *)rightTitle;
-(void)iconAlertLeftAction;
-(void)iconAlertRightAction;
//弹窗不带图标
-(void)showAlertWithTitle:(NSString *)title
                  message:(NSString *)message
                leftTitle:(NSString *)leftTitle
               rightTitle:(NSString *)rightTitle;
-(void)alerLeftAction;
-(void)alertRightAction;
@end

NS_ASSUME_NONNULL_END
