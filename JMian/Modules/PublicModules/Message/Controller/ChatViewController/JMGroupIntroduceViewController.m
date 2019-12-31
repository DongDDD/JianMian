//
//  JMGroupIntroduceViewController.m
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMGroupIntroduceViewController.h"

@interface JMGroupIntroduceViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JMGroupIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView setText:self.groupIntroduce];
    if (_isMeOwner) {
        [self setRightBtnTextName:@"保存"];
    }else{
        [self.textView setEditable:NO];
    }
    // Do any additional setup after loading the view from its nib.
}


-(void)rightAction{
    [self.textView resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(groupIntroduceController:didModiyContent:)]) {
        [_delegate groupIntroduceController:self didModiyContent:self.textView.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
