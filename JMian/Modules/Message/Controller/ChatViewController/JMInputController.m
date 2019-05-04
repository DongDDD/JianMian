//
//  JMInputController.m
//  JMian
//
//  Created by mac on 2019/5/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMInputController.h"
#import "DimensMacros.h"

@interface JMInputController ()

@end

@implementation JMInputController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];;
//    _status = Input_Status_Input;
    
    _textView = [[JMInputTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TTextView_Height)];
//    _textView.delegate = self;
    [self.view addSubview:_textView];
}


- (JMMoreView *)moreView
{
    if(!_moreView){
        _moreView = [[JMMoreView alloc] initWithFrame:CGRectMake(0, _textView.frame.origin.y + _textView.frame.size.height, self.faceView.frame.size.width, 0)];
//        _moreView.delegate = self;
    }
    return _moreView;
}


- (void)showMoreAnimation
{
    [self.view addSubview:self.moreView];
    
    self.moreView.hidden = NO;
    CGRect frame = self.moreView.frame;
    frame.origin.y = SCREEN_HEIGHT;
    self.moreView.frame = frame;
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect newFrame = ws.moreView.frame;
        newFrame.origin.y = ws.textView.frame.origin.y + ws.textView.frame.size.height;
        ws.moreView.frame = newFrame;
    } completion:nil];
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
