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
@interface JMFeedBackChooseViewController ()<JMLabsChooseViewControllerDelegate>
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
    [self labschooseVC];
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
        [_labschooseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
    }
    return  _labschooseVC;
    
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
