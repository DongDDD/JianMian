//
//  BaseViewController.h
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <AFNetworking.h>
#import "DimensMacros.h"
#import <Masonry.h>

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

-(void)setRightBtnTextName:(NSString *)rightLabName;

-(void)setTitleViewImageViewName:(NSString *)imageName;

- (void)setBackBtnImageViewName:(NSString *)imageName textName:(NSString *)textName;

- (void)setRightBtnImageViewName:(NSString *)imageName imageNameRight2:(NSString *)imageNameRight2;

-(void)rightAction;

-(void)right2Action;
@end

NS_ASSUME_NONNULL_END
