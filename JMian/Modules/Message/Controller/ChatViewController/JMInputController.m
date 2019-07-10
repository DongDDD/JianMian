//
//  JMInputController.m
//  JMian
//
//  Created by mac on 2019/5/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMInputController.h"
#import "DimensMacros.h"
#import "Masonry.h"
#import "JMHTTPManager+FectchGreetList.h"
#import "JMMyCustumWindowView.h"

typedef NS_ENUM(NSUInteger, InputStatus) {
    Input_Status_Input,
    Input_Status_Input_Face,
    Input_Status_Input_More,
    Input_Status_Input_Keyboard,
    Input_Status_Input_Greet,
};


@interface JMInputController ()<JMInputTextViewDelegate,JMGreetViewDelegate,JMMyCustumWindowViewDelegate>
@property (nonatomic, assign) InputStatus status;
@property (nonatomic, strong) JMMyCustumWindowView *myCustumWindowView;
@property (nonatomic, strong) UIView *windowViewBGView;


@end

@implementation JMInputController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if(_status == Input_Status_Input_Face){
//        [self hideFaceAnimation];
    }
    else if(_status == Input_Status_Input_More){
        [self hideMoreAnimation];
    }
    else{
        //[self hideFaceAnimation:NO];
        //[self hideMoreAnimation:NO];
    }
    _status = Input_Status_Input_Keyboard;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
        [_delegate inputController:self didChangeHeight:keyboardFrame.size.height + _inputTextView.frame.size.height + Bottom_SafeHeight];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
        [_delegate inputController:self didChangeHeight:_inputTextView.frame.size.height];
    }
}


- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    _status = Input_Status_Input;
    
    _inputTextView = [[JMInputTextView alloc] init];
    _inputTextView.delegate = self;
    [self.view addSubview:_inputTextView];
    
    [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(TTextView_Height);
        make.top.mas_equalTo(self.view);
    }];
    
}

- (void)textViewDidTouchGreet:(JMInputTextView *)textView;
{
    if(_status == Input_Status_Input_Greet){
        return;
    }
    if(_status == Input_Status_Input_More){
        [self hideMoreAnimation];
    }
    
    [_inputTextView.textView resignFirstResponder];
    [self showGreetAnimation];
    _status = Input_Status_Input_Greet;
    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
        [_delegate inputController:self didChangeHeight:_inputTextView.frame.size.height + self.greeView.frame.size.height + Bottom_SafeHeight];
    }
    
    
}

-(void)textView:(JMInputTextView *)textView didSendMessage:(NSString *)text
{
    
    [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

    JMMessageCellData *data = [[JMMessageCellData alloc] init];
    
    data.content = text;
    data.isSelf = YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didSendMessage:)]){
        [_delegate inputController:self didSendMessage:data];
    }
    
}



//- (void)textViewDidTouchFace:(JMInputTextView *)textView
//{
//    if(_status == Input_Status_Input_More){
//        [self hideMoreAnimation];
//    }
//
//    if(_status == Input_Status_Input_Greet){
//        [self hideGreetAnimation];
//    }
////    if(_status == Input_Status_Input_Face){
////    [self showFaceAnimation];
////    }
//    [_inputTextView.textView resignFirstResponder];
//    _status = Input_Status_Input_Face;
////    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didSendMessage:)]){
////        [_delegate inputController:self didSendMessage:textView.textView.text];
////    }
//
//}
#pragma mark -  mydelegate

- (void)textViewDidTouchMore:(JMInputTextView *)textView
{
//    if([[TUIKit sharedInstance] getConfig].moreMenus.count == 0){
//        return;
//    }
    
    if(_status == Input_Status_Input_More){
        return;
    }
    
    if(_status == Input_Status_Input_Greet){
        [self hideGreetAnimation];
    }
    [_inputTextView.textView resignFirstResponder];
    [self showMoreAnimation];
    _status = Input_Status_Input_More;
    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
        [_delegate inputController:self didChangeHeight:_inputTextView.frame.size.height + self.moreView.frame.size.height + Bottom_SafeHeight];
    }
}

-(void)didChooseGreetWithStr:(NSString *)str{
    [_inputTextView.textView setText:str];
}

//添加常用语
-(void)addGreetAction{
    self.myCustumWindowView.titleLab.text = @"新增常用语";
    [[UIApplication sharedApplication].keyWindow addSubview:self.windowViewBGView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.myCustumWindowView];
    [_myCustumWindowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(220);
        make.centerY.mas_equalTo([UIApplication sharedApplication].keyWindow).mas_offset(-100);
    }];
    
    
//    [_inputTextView.textView resignFirstResponder];
//    [[JMHTTPManager sharedInstance]createGreet_text:_inputTextView.textView.text mode:@"1" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//        NSLog(@"添加成功！");
//        [_greeView.tableView reloadData];
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
    
}

-(void)windowLeftAction{
    
    [self.myCustumWindowView removeFromSuperview];
    [self.windowViewBGView removeFromSuperview];

}

-(void)windowRightAction{
    
    [self.myCustumWindowView removeFromSuperview];
    [self.windowViewBGView removeFromSuperview];
    [self.myCustumWindowView.contentTextView resignFirstResponder];
    [[JMHTTPManager sharedInstance]createGreet_text:self.myCustumWindowView.contentTextView.text mode:@"1" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        NSLog(@"添加成功！");
        [_greeView getGreetList];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
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
        newFrame.origin.y = ws.inputTextView.frame.origin.y + ws.inputTextView.frame.size.height;
        ws.moreView.frame = newFrame;
    } completion:nil];
}

- (void)showGreetAnimation
{
    [self.view addSubview:self.greeView];
    
    self.greeView.hidden = NO;
    CGRect frame = self.greeView.frame;
    frame.origin.y = SCREEN_HEIGHT;
    self.greeView.frame = frame;
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect newFrame = ws.greeView.frame;
        newFrame.origin.y = ws.inputTextView.frame.origin.y + ws.inputTextView.frame.size.height;
        ws.greeView.frame = newFrame;
    } completion:nil];
}


-(void)hideGreetAnimation{

    self.greeView.hidden = YES;

}

-(void)hideMoreAnimation{
    
    self.moreView.hidden = YES;
    
}

- (void)reset
{
    if(_status == Input_Status_Input){
        return;
    }
    
    else if(_status == Input_Status_Input_More){
        [self hideMoreAnimation];
    }
    
    else if(_status == Input_Status_Input_Greet){
        [self hideGreetAnimation];
    }
    
    [_moreView setHidden:YES];
    _status = Input_Status_Input;
    [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(inputController:didChangeHeight:)]){
        [_delegate inputController:self didChangeHeight:_inputTextView.frame.size.height + Bottom_SafeHeight];
    }
}



- (JMMoreView *)moreView
{
    if(!_moreView){
        _moreView = [[JMMoreView alloc] initWithFrame:CGRectMake(0, _inputTextView.frame.origin.y + _inputTextView.frame.size.height, _inputTextView.frame.size.width, JMMoreView_Height)];
//        _moreView.delegate = self;
    }
    return _moreView;
}

- (JMGreetView *)greeView
{
    if(!_greeView){
        _greeView = [[JMGreetView alloc] initWithFrame:CGRectMake(0, _inputTextView.frame.origin.y + _inputTextView.frame.size.height, _inputTextView.frame.size.width, JMGreetView_Height)];
        _greeView.delegate = self;
        
    }
    return _greeView;
}

-(JMMyCustumWindowView *)myCustumWindowView{
    if (!_myCustumWindowView) {
        _myCustumWindowView = [[JMMyCustumWindowView alloc]init];
        _myCustumWindowView.layer.cornerRadius = 10;
        _myCustumWindowView.delegate = self;
    }
    return _myCustumWindowView;
}

-(UIView *)windowViewBGView{
    if (!_windowViewBGView) {
        _windowViewBGView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _windowViewBGView.backgroundColor = [UIColor blackColor];
        _windowViewBGView.alpha = 0.3;
    }
    return _windowViewBGView;
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
