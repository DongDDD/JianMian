//
//  JMGroupIntroduceViewController.m
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMGroupIntroduceViewController.h"
#import "JMPartTimeJobResumeFooterView.h"

@interface JMGroupIntroduceViewController ()<JMPartTimeJobResumeFooterViewDelegate>

@property (nonatomic,strong)JMPartTimeJobResumeFooterView *decriptionTextView;
@end

@implementation JMGroupIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.textView setText:self.groupIntroduce];
    [self.view addSubview:self.decriptionTextView];
    self.view.backgroundColor = BG_COLOR;
    [self.decriptionTextView setContent:_groupIntroduce];
    

    if (_isMeOwner) {
        [self setRightBtnTextName:@"保存"];
    }else{
        [self.decriptionTextView.contentTextView setEditable:NO];
    }
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - textFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)sendContent:(NSString *)content{
    _groupIntroduce = content;
}

-(void)rightAction{
    [_decriptionTextView.contentTextView resignFirstResponder];

    if (_delegate && [_delegate respondsToSelector:@selector(groupIntroduceController:didModiyContent:)]) {
        [_delegate groupIntroduceController:self didModiyContent:_groupIntroduce];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 300);
        _decriptionTextView.delegate = self;
//        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        _decriptionTextView.placeHolder.text = @"请输入群公告";
        _decriptionTextView.wordsLenghLabel.text = @"0/500";
//        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeGroup];
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
