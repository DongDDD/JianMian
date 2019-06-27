//
//  JMFeedBackChooseViewController.m
//  JMian
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMFeedBackChooseViewController.h"
#import "JMLabsChooseViewController.h"
#import "JMHTTPManager+InterView.h"
#import "JMMyTopViewNavView.h"
@interface JMFeedBackChooseViewController ()<JMLabsChooseViewControllerDelegate,JMMyTopViewNavViewDelegate>
@property (nonatomic, strong) JMMyTopViewNavView *navView;
@property (nonatomic, strong) JMLabsChooseViewController *labschooseVC;
@property (nonatomic, assign)NSInteger index1;
@property (nonatomic, assign)NSInteger index2;
@property (nonatomic, assign)NSInteger index3;


@end

@implementation JMFeedBackChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"面试反馈";
    [self setRightBtnTextName:@"提交"];
    [self initView];
    
}

-(void)initView{

    [self labschooseVC];

    
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.backgroundColor = MASTER_COLOR;
    saveBtn.layer.cornerRadius = 17.5;
    [saveBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(37);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.bottom.mas_equalTo(self.view).mas_offset(-20-Bottom_SafeHeight);
    }];
}

-(void)setViewType:(JMFeedBackChooseViewType)viewType{
    if (viewType == JMFeedBackChooseViewAppdelegate) {
        [self.view addSubview:self.navView];
        _navView.backgroundColor = [UIColor whiteColor];
        [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view);
            make.height.mas_equalTo(64);
            make.left.and.right.mas_equalTo(self.view);
            
        }];
    }
    
}


-(void)saveAction{
    [self rightAction];
    
    
}

-(void)rightAction{

    [self.navigationController popViewControllerAnimated:YES];
    NSString *str1 = [NSString stringWithFormat:@"%ld",(long)_index1];
    NSString *str2 = [NSString stringWithFormat:@"%ld",(long)_index2];
    NSString *str3 = [NSString stringWithFormat:@"%ld",(long)_index3];
    
    
    NSArray *labs = @[str1,str2,str3];
    [[JMHTTPManager sharedInstance]feedbackInterViewWith_interview_id:self.interview_id label_ids:labs successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"反馈提交成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
        if (_delegate && [_delegate respondsToSelector:@selector(didCommitActionWithInterview_id:)]) {
            [_delegate didCommitActionWithInterview_id:self.interview_id];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

- (void)OKAction {
    [super fanhui];
    NSString *str1 = [NSString stringWithFormat:@"%ld",(long)_index1];
    NSString *str2 = [NSString stringWithFormat:@"%ld",(long)_index2];
    NSString *str3 = [NSString stringWithFormat:@"%ld",(long)_index3];

    
    NSArray *labs = @[str1,str2,str3];
    [[JMHTTPManager sharedInstance]feedbackInterViewWith_interview_id:self.interview_id label_ids:labs successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}

-(void)backAction{
    if (_delegate && [_delegate respondsToSelector:@selector(didCommitActionWithInterview_id:)]) {
        [_delegate didCommitActionWithInterview_id:self.interview_id];
    }
}

- (void)didChooseLabsTitle_str:(nonnull NSString *)str index:(NSInteger)index {
 
    if ([str isEqualToString:@"面试过程"]) {
        _index1 = index;
    }else if ([str isEqualToString:@"岗位描述"]){
        _index2 = index;


    }else if ([str isEqualToString:@"我的意向"]){
        _index3 = index;


    }
//
    
}

- (void)resetAction {
    
}

- (void)sendKeyWord_education:(nonnull NSString *)education exprience:(nonnull NSString *)exprience {
    
}

#pragma mark - lazy

-(JMLabsChooseViewController *)labschooseVC{
    if (_labschooseVC == nil) {
        _labschooseVC = [[JMLabsChooseViewController alloc]init];
        _labschooseVC.delegate = self;
        _labschooseVC.labsChooseViewType = JMLabsChooseViewTypeFeedBack;
        [self addChildViewController:_labschooseVC];
        [self.view addSubview:_labschooseVC.view];
        if (_viewType == JMFeedBackChooseViewDefault) {
            [_labschooseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(self.view);
                make.left.and.right.mas_equalTo(self.view);
                make.bottom.mas_equalTo(self.view);
            }];
        }else if  (_viewType == JMFeedBackChooseViewDefault) {
            [_labschooseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(self.view).mas_offset(64);
                make.left.and.right.mas_equalTo(self.view);
                make.bottom.mas_equalTo(self.view);
            }];
        }
  
    }
    return  _labschooseVC;
    
}

-(JMMyTopViewNavView *)navView{
    if (_navView == nil) {
        _navView = [[JMMyTopViewNavView alloc]init];
        _navView.delegate = self;
        
    }
    return _navView;
    

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
