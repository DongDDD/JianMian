//
//  JMJobDescriptionViewController.m
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMJobDescriptionViewController.h"
#import "JMTitlesView.h"
#import "JMPartTimeJobResumeFooterView.h"
#import "JMHTTPManager+FectchTplLIst.h"
#import "JMTPLModel.h"
#import "IQKeyboardManager.h"

@interface JMJobDescriptionViewController ()<UITextViewDelegate,JMPartTimeJobResumeFooterViewDelegate>

@property (nonatomic, strong) JMTitlesView *titleView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic , strong) UITextView *textView;

@property (nonatomic, strong)UIView *placeholderView;
@property (strong, nonatomic)JMPartTimeJobResumeFooterView *decriptionTextView;
@property (copy, nonatomic)NSString *decriStr;
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, assign)NSInteger TPLIndex;

@end

@implementation JMJobDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"职位描述";
    [self setRightBtnTextName:@"保存"];
    
    [self.decriptionTextView setContent:_jobDescriptionStr];
    [self.view addSubview:self.decriptionTextView];
    [self.decriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(10);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide).offset(-300);
    }];
    [self.view addSubview:self.titleView];
    self.view.backgroundColor = BG_COLOR;
    [self getData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;


}
#pragma mark - myAction

-(void)rightAction{
    [_decriptionTextView.contentTextView resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(sendTextView_textData:)]) {
        [self.delegate sendTextView_textData:_decriStr];
    }
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)changeTPLAction:(id)sender {
    JMTPLModel *model = self.dataArray[self.TPLIndex];
    [self.decriptionTextView setContent:model.myTemplate];
    _decriStr = model.myTemplate;
    if (_TPLIndex < self.dataArray.count-1) {
        _TPLIndex += 1;
    }else{
        _TPLIndex = 0;
    }
}

-(void)doneClicked{
    [_decriptionTextView.contentTextView resignFirstResponder];
}

-(void)titleAction{
    if (_index == 0) {
        [self.decriptionTextView setContent:@""];
    }else if (_index == 1) {
        JMTPLModel *model = self.dataArray[self.TPLIndex];

        [self.decriptionTextView setContent:model.myTemplate];

    }

}


#pragma mark - data

-(void)getData{
    [[JMHTTPManager sharedInstance]getTplList_type:@"2" foreign_key:_foreign_key status:nil page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.dataArray = [JMTPLModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

#pragma mark - MyDelegate
-(void)sendContent:(NSString *)content{
    _decriStr = content;
    
}

#pragma mark - UITextDelegate

//-(void)textViewDidBeginEditing:(UITextField *)textField{
//    [_placeholderView setHidden:YES];
//
//}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text containsString:@"\n"]) {
//        [textView resignFirstResponder];
//        return YES;
//    }
//    return NO;
//
//}
#pragma mark - lazy

-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, self.titleView.frame.origin.y+self.titleView.frame.size.height, SCREEN_WIDTH, 300);
        _decriptionTextView.delegate = self;
//        _decriptionTextView.contentTextView.keyboardType = UIReturnKeyDone;
        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeJobDescription];
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _decriptionTextView;
}
- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"清空文本", @"描述推荐"]];
        __weak JMJobDescriptionViewController *weakSelf = self;

        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf titleAction];
        };
    }
    
    return _titleView;
}



//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    //判断类型，如果不是UITextView类型，收起键盘
//    for (UIView* view in self.view.subviews) {
//        if ([view isKindOfClass:[UITextView class]]) {
//            UITextView* tv = (UITextView*)view;
//            [tv resignFirstResponder];
//        }
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
