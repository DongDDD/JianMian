//
//  JMStroreNotificationViewController.m
//  JMian
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMStroreNotificationViewController.h"
#import "JMPartTimeJobResumeFooterView.h"

@interface JMStroreNotificationViewController ()<JMPartTimeJobResumeFooterViewDelegate>
@property(nonatomic,strong)JMPartTimeJobResumeFooterView *decriptionTextView;
@end

@implementation JMStroreNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告";
    [self setRightBtnTextName:@"完成"];
    [self.view addSubview:self.decriptionTextView];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - textFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)sendContent:(NSString *)content{
//    _groupIntroduce = content;
}

#pragma mark - Delegate

-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(10, 20, SCREEN_WIDTH-20, 300);
        _decriptionTextView.delegate = self;
//        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        _decriptionTextView.placeHolder.text = @"请输入店铺公告";
        _decriptionTextView.wordsLenghLabel.text = @"0/500";
        _decriptionTextView.contentTextView.backgroundColor = BG_COLOR;
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
