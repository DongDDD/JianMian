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
#import "LoginViewController.h"
#import "NavigationViewController.h"
#import "JMJudgeViewController.h"


@interface BaseViewController ()
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong)UIToolbar *myToolbar;
@property (nonatomic, strong)JMNoDataView *noDataView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
//
//    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBackBtnImageViewName:@"icon_return_nav" textName:@""];
    [_progressHUD showAnimated:YES whileExecutingBlock:^{
        NSLog(@"%@",@"do somethings....");
   
    } completionBlock:^{
    
    }];
 
}

-(void)setIsHiddenBackBtn:(BOOL)isHiddenBackBtn
{
    if (isHiddenBackBtn) {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }else{
        self.navigationItem.hidesBackButton = NO;

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
    
    self.navigationItem.titleView = titleText;
    
}

-(void)setTitle:(NSString *)title color:(UIColor *)color{
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 80, 50)];
    
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.textColor = color;
    
    [titleText setFont:[UIFont systemFontOfSize:16.0]];
    
    [titleText setText:title];
    
    self.navigationItem.titleView = titleText;
    
}


- (void)setBackBtnImageViewName:(NSString *)imageName textName:(NSString *)textName{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 19)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(-40 , -5, 120, 28);
//    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(leftBtn.frame.origin.x+leftBtn.frame.size.width-40, 0, 100,leftBtn.frame.size.height)];
    leftLab.text = textName;
    leftLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    leftLab.font = [UIFont systemFontOfSize:13];
    
    [bgView addSubview:leftLab];
    [bgView addSubview:leftBtn];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)setRightBtnImageViewName:(NSString *)imageName textName:(NSString *)textName{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 19)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(-40 , 0, 120, 28);
    //    leftBtn.backgroundColor = [UIColor redColor];
    [rightBtn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(rightBtn.frame.origin.x+rightBtn.frame.size.width-40, 0, 100,rightBtn.frame.size.height)];
    leftLab.text = textName;
    leftLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    leftLab.font = [UIFont systemFontOfSize:13];
    
    [bgView addSubview:leftLab];
    [bgView addSubview:rightBtn];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)setRightBtnTextName:(NSString *)rightLabName{
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 28);
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:rightLabName forState:UIControlStateNormal];
    [rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


- (void)setRightBtnImageViewName:(NSString *)imageName  imageNameRight2:(NSString *)imageNameRight2 {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 28)];

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

-(void)youkeStatus{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self loginOut];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
}

-(void)moreAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self logout];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"切换身份" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self changeIdentify];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

-(void)changeIdentify{
    [[JMHTTPManager sharedInstance]userChangeWithType:@"" step:@""  successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        kSaveMyDefault(@"usersig", userInfo.usersig);
        NSLog(@"usersig-----:%@",userInfo.usersig);
        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        [[TIMManager sharedInstance] logout:^() {
            NSLog(@"logout succ");
        } fail:^(int code, NSString * err) {
            NSLog(@"logout fail: code=%d err=%@", code, err);
        }];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)logout{
    [[JMHTTPManager sharedInstance] logoutWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        kRemoveMyDefault(@"token");
        kRemoveMyDefault(@"usersig");
        //token为空执行
        
        [[TIMManager sharedInstance] logout:^() {
            NSLog(@"logout succ");
        } fail:^(int code, NSString * err) {
            NSLog(@"logout fail: code=%d err=%@", code, err);
        }];
        LoginViewController *login = [[LoginViewController alloc] init];
        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
        [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
    
}


-(void)loginOut{
    [[JMHTTPManager sharedInstance] logoutWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        kRemoveMyDefault(@"token");
        kRemoveMyDefault(@"usersig");
        kRemoveMyDefault(@"youke");

        //token为空执行
        
        [[TIMManager sharedInstance] logout:^() {
            NSLog(@"logout succ");
        } fail:^(int code, NSString * err) {
            NSLog(@"logout fail: code=%d err=%@", code, err);
        }];
        LoginViewController *login = [[LoginViewController alloc] init];
        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
        [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
}
//更新用户信息
-(void)upDateUserData{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];

        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
#pragma mark - 弹窗

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
    _HUDbackgroundView.alpha = 0;
    [view addSubview:_HUDbackgroundView];
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


-(void)showAlertOneBtnVCWithHeaderIcon:(NSString *)headerIcon
                         message:(NSString *)message
                       btnTitle:(NSString *)btnTitle
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n" message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self iconAlertLeftAction];
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

-(void)showAlertVCSucceesSingleWithMessage:(NSString *)message
                       btnTitle:(NSString *)btnTitle
{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n" message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self alertSucceesAction];
    }]];
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"purchase_succeeds"];
    [alert.view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(alert.view).mas_offset(23);
        make.centerX.mas_equalTo(alert.view);
        make.size.mas_equalTo(CGSizeMake(75, 64));
        
    }];
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

-(void)alertSucceesAction{
    
    
}
#pragma mark - 数据处理

-(NSMutableArray *)setSalaryRangeWithSalaryStr:(NSString *)salaryStr{
    NSArray *array = [salaryStr componentsSeparatedByString:@"-"]; //从字符 - 中分隔成2个元素的数组
    
    NSString *minStr = array[0];
    NSString *maxStr = array[1];
    
    //    NSInteger minNum = [minStr integerValue];
    //    NSInteger maxNum = [maxStr integerValue];
    //
    
    NSString *string1 = [minStr stringByReplacingOccurrencesOfString:@"k"withString:@"000"];
//    self.salaryMin = string1;
    NSString *string2 = [maxStr stringByReplacingOccurrencesOfString:@"k"withString:@"000"];
//
    
    NSMutableArray *arrayMinMax = [NSMutableArray arrayWithObjects:string1,string2,nil];
    
    return arrayMinMax;
    
}

-(NSString *)getSalaryKWithStr:(NSString *)str{
    NSInteger salaryInt = [str integerValue];
    NSInteger salaryInt2 = salaryInt/1000;
    NSString *salaryStr = [NSString stringWithFormat:@"%ldk",(long)salaryInt2];
    return salaryStr;
}

//工资数据转化，除以1000，转化成k
-(NSString *)getSalaryKtransformStrWithMin:(id)min max:(id)max{
    NSInteger myint = [min integerValue];
    NSInteger intMin = myint/1000;
    
    NSInteger myint2 = [max integerValue];
    NSInteger intMax = myint2/1000;
    
    NSString *salaryStr;
    salaryStr = [NSString stringWithFormat:@"%dk~%dk",  (int)intMin, (int)intMax];
    
    return salaryStr;
}

//学历数据转化 数字 转 文字
-(NSString *)getEducationStrWithEducation:(NSString *)education{
    NSInteger myInt = [education integerValue];
    
    switch (myInt) {
        case 0:
            return @"不限";
            break;
        case 1:
            return @"初中";
            break;
        case 2:
            return @"中专";
            break;
        case 3:
            return @"高中";
            break;
        case 4:
            return @"大专";
            break;
        case 5:
            return @"本科";
            break;
        case 6:
            return @"硕士";
            break;
        case 7:
            return @"博士";
            break;
            
        default:
            break;
    }
    return @"不限";
    
}
//学历数据转化 文字 转 数字

-(NSString *)getEducationNumWithEducationStr:(NSString *)educationStr{
    
    
    if ([educationStr isEqualToString:@"初中"]) {
        return @"1";

    }else if ([educationStr isEqualToString:@"中专"]){
        return @"2";
        
    }else if ([educationStr isEqualToString:@"高中"]){
        return @"3";
        
    }else if ([educationStr isEqualToString:@"大专"]){
        return @"4";
        
    }else if ([educationStr isEqualToString:@"本科"]){
        return @"5";
        
    }else if ([educationStr isEqualToString:@"硕士"]){
        return @"6";
        
    }else if ([educationStr isEqualToString:@"博士"]){
        return @"7";
                
    }

    return @"0";
    
}

//求职状态数据转化 文字 转 数字

-(NSString *)getJobStatusWithStatusStr:(NSString *)statusStr{
    
    
    if ([statusStr isEqualToString:@"应届生"]) {
        return @"4";
        
    }else if ([statusStr isEqualToString:@"在职"]){
        return @"1";
        
    }else if ([statusStr isEqualToString:@"离职"]){
        return @"2";
        
    }
    
    return @"0";
    
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
#pragma mark ----时间

- (NSDate *)dateFromString:(NSString *)dateStr{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    // 注意的是下面给格式的时候,里面一定要和字符串里面的统一
    // 比如:   dateStr为2017-07-24 17:38:27   那么必须设置成yyyy-MM-dd HH:mm:ss, 如果你设置成yyyy--MM--dd HH:mm:ss, 那么date就是null, 这是需要注意的
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate * date = [formatter dateFromString:dateStr];
    return date;
    
}

- (NSString *)timeStampConversionNSString:(NSString *)timeStamp
{
    //将对象类型的时间转换为NSDate类型
    
    double time = [timeStamp doubleValue];
    
    NSDate *myDate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //设置时间格式
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //将时间转换为字符串
    
    NSString *timeStr=[formatter stringFromDate:myDate];
    
    return timeStr;
}

-(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    NSLog(@"两者时间是同一个时间");
    return 0;
    
}

#pragma mark ----加减乘除------------ number1 - number2
//相乘
-(NSString *)calculateByMultiplying:(NSString *)number1 secondNumber:(NSString *)number2
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *multiplyingNum = [num1 decimalNumberByMultiplyingBy:num2];
    return [multiplyingNum stringValue];
    
}

//相减
-(NSString *)calculateBySubtractingMinuend:(NSString *)number1 subtractorNumber:(NSString *)number2
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *addingNum = [num1 decimalNumberBySubtracting:num2];
    return [addingNum stringValue];
    
}


//相加
-(NSString *)calculateByadding:(NSString *)number1 secondNumber:(NSString *)number2
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *addingNum = [num1 decimalNumberByAdding:num2];
    return [addingNum stringValue];
}

- (BOOL)validateWithStartTime:(NSString *)startTime withExpireTime:(NSString *)expireTime {
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm"];
    
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

#pragma mark ----常用工具UI

- (UIToolbar *)myToolbar
{
    if (_myToolbar == nil) {
        CGRect tempFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
        _myToolbar = [[UIToolbar alloc] initWithFrame:tempFrame];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStyleDone target:self
                                                                      action:@selector(doneClicked)];
        _myToolbar.items = @[doneButton];
    }
    
    return _myToolbar;
}

-(JMNoDataView *)noDataView{
    if (_noDataView==nil) {
        _noDataView = [[JMNoDataView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT)];
        _noDataView.backgroundColor = BG_COLOR;
    }
    return _noDataView;
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
