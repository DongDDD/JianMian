//
//  JMRefuseRefundViewController.m
//  JMian
//
//  Created by mac on 2020/2/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMRefuseRefundViewController.h"
#import "JMPartTimeJobResumeFooterView.h"
@interface JMRefuseRefundViewController ()
@property(nonatomic,strong)JMPartTimeJobResumeFooterView *otherCauseTextView;
@end

@implementation JMRefuseRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.otherCauseTextView];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Navigation

-(JMPartTimeJobResumeFooterView *)otherCauseTextView{
    if (_otherCauseTextView == nil) {
        _otherCauseTextView = [JMPartTimeJobResumeFooterView new];
        _otherCauseTextView.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 135);
        _otherCauseTextView.delegate = self;
//        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        _otherCauseTextView.placeHolder.text = @"请输入原因详情";
//        _otherCauseTextView.wordsLenghLabel.text = @"0/200";
        _otherCauseTextView.contentTextView.backgroundColor = BG_COLOR;
//        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeGroup];
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _otherCauseTextView;
}
/*

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
