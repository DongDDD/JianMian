//
//  BaseViewController.h
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"
typedef NS_ENUM(NSInteger, JMJLoginViewType) {
    JMLoginViewTypeNextStep,
    JMJLoginViewTypeMemory,
};

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

@property(nonatomic,assign)JMJLoginViewType loginViewType;
-(void)setIsHiddenBackBtn:(BOOL)isHiddenBackBtn;
//@property(nonatomic,assign)BOOL isHiddenBackBtn;
-(void)setIsHiddenRightBtn:(BOOL)isHiddenBackBtn;

@property(nonatomic,assign)BOOL _isHideBackBtn;
-(void)setRightBtnTextName:(NSString *)rightLabName;

-(void)setTitleViewImageViewName:(NSString *)imageName;

- (void)setBackBtnImageViewName:(NSString *)imageName textName:(NSString *)textName;

- (void)setRightBtnImageViewName:(NSString *)imageName imageNameRight2:(NSString *)imageNameRight2;

-(void)youkeStatus;//判断游客模式

- (void)fanhui;

-(void)rightAction;

-(void)right2Action;

@property (nonatomic, strong) MBProgressHUD *myProgressHUD;
-(void)showProgressHUD_view:(UIView *)view;
-(void)showHUD;
-(void)hiddenHUD;
-(void)loginOut;//退出登录
// 将JSON串转化为字典或者数组
- (id)toArrayOrNSDictionary:(NSData *)jsonData;

//弹窗带图标
-(void)showAlertVCWithHeaderIcon:(NSString *)headerIcon
                         message:(NSString *)message
                       leftTitle:(NSString *)leftTitle
                      rightTitle:(NSString *)rightTitle;
-(void)showAlertOneBtnVCWithHeaderIcon:(NSString *)headerIcon
                               message:(NSString *)message
                              btnTitle:(NSString *)btnTitle;
-(void)iconAlertLeftAction;
-(void)iconAlertRightAction;
//弹窗不带图标
-(void)showAlertWithTitle:(NSString *)title
                  message:(NSString *)message
                leftTitle:(NSString *)leftTitle
               rightTitle:(NSString *)rightTitle;
//简单弹框提示
-(void)showAlertSimpleTips:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle;
//操作成功提示
-(void)showAlertVCSucceesSingleWithMessage:(NSString *)message
                                  btnTitle:(NSString *)btnTitle;
-(void)alerLeftAction;
-(void)alertRightAction;
-(void)alertSucceesAction;
//工资K数据转换 “000”
-(NSMutableArray *)setSalaryRangeWithSalaryStr:(NSString *)salaryStr;
//工资000数据转换 “k”
-(NSString *)getSalaryKWithStr:(NSString *)str;
-(NSString *)getSalaryKtransformStrWithMin:(id)min max:(id)max;
//学历数据转化
-(NSString *)getEducationStrWithEducation:(NSString *)education;
-(NSString *)getEducationNumWithEducationStr:(NSString *)educationStr;
//求职状态数据转化
-(NSString *)getJobStatusWithStatusStr:(NSString *)statusStr;
//键盘工具栏
- (UIToolbar *)myToolbar;
//没数据提示
-(JMNoDataView *)noDataView;
//加减乘除
-(NSString *)calculateByMultiplying:(NSString *)number1 secondNumber:(NSString *)number2;
-(NSString *)calculateByadding:(NSString *)number1 secondNumber:(NSString *)number2;
-(NSString *)calculateBySubtractingMinuend:(NSString *)number1 subtractorNumber:(NSString *)number2;
//时间比较
-(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
//时间戳转化成时间字符串
- (NSString *)timeStampConversionNSString:(NSString *)timeStamp;
//字符串转化成NSDate
- (NSDate *)dateFromString:(NSString *)dateStr;
@end

NS_ASSUME_NONNULL_END
