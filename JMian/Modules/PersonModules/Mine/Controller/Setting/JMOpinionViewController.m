//
//  JMOpinionViewController.m
//  JMian
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMOpinionViewController.h"
#import "JMPartTimeJobResumeFooterView.h"

@interface JMOpinionViewController ()<JMPartTimeJobResumeFooterViewDelegate>
@property (strong, nonatomic)JMPartTimeJobResumeFooterView *decriptionTextView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (copy, nonatomic)NSString *decriStr;
@end

@implementation JMOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈意见";
    [self setRightBtnTextName:@"提交"];
    [self.view addSubview:self.decriptionTextView];
    [self.view addSubview:self.bottomView];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
}
-(void)rightAction{
    [self.navigationController popViewControllerAnimated:NO];
    
}
#pragma mark - MyDelegate

-(void)sendContent:(NSString *)content{
    _decriStr = content;
    
    
}

-(void)doneClicked{
    [_decriptionTextView.contentTextView resignFirstResponder];
}

-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
        _decriptionTextView.delegate = self;
        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeSetting];
        //        _decriptionTextView.contentTextView.delegate = self;

    }
    return _decriptionTextView;
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
