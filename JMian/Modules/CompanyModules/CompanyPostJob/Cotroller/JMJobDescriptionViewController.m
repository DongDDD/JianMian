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

@interface JMJobDescriptionViewController ()<UITextViewDelegate,JMPartTimeJobResumeFooterViewDelegate>

@property (nonatomic, strong) JMTitlesView *titleView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic , strong) UITextView *textView;

@property (nonatomic, strong)UIView *placeholderView;
@property (strong, nonatomic)JMPartTimeJobResumeFooterView *decriptionTextView;
@property (copy, nonatomic)NSString *decriStr;


@end

@implementation JMJobDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"职位描述"];
    [self setRightBtnTextName:@"保存"];
    
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.decriptionTextView];
    self.view.backgroundColor = BG_COLOR;
//    [self setTextFieldUI];
    
}

-(void)rightAction{
    [_decriptionTextView.contentTextView resignFirstResponder];
    [self.delegate sendTextView_textData:_decriStr];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)setTextFieldUI{
    self.textView = [[UITextView alloc]init];
    self.textView.delegate = self;
    self.textView.font = GlobalFont(14);
    
    self.textView.returnKeyType = UIReturnKeyDone;//返回键类型
    self.textView.keyboardType = UIKeyboardTypeDefault;//键盘类型


    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(30);
        make.bottom.mas_equalTo(self.view).offset(-110);
    }];
    
    _placeholderView = [[UIView alloc]init];
    [self.view addSubview:_placeholderView];
    [_placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(20);
        //        make.height.mas_equalTo(33);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.textColor = TEXT_GRAYmin_COLOR;
    lab.font = GlobalFont(14);
    lab.text = @"填写岗位职责、任职要求等（3000字以内），清晰的 描述有助于更好的展开招聘，例如：";
    lab.numberOfLines = 0;
    [lab sizeToFit];
    [_placeholderView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(20);
//        make.height.mas_equalTo(33);
    }];
    
    UILabel *lab2 = [[UILabel alloc]init];
    lab2.textColor = TEXT_GRAYmin_COLOR;
    lab2.font = GlobalFont(14);
    lab2.text = @"岗位职责 \n1, ... \n2, ... \n3, ... \n任职要求 \n1, ... \n2, ... \n3, ...";
    lab2.numberOfLines = 0;
    [lab2 sizeToFit];
    [_placeholderView addSubview:lab2];

    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(lab.mas_bottom).offset(20);
        //        make.height.mas_equalTo(33);
    }];
    
    UILabel *textNumLab = [[UILabel alloc]init];
    textNumLab.text = @"0";
    textNumLab.textColor = MASTER_COLOR;
    textNumLab.font = GlobalFont(13);
    textNumLab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:textNumLab];
    
    [textNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-61);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-83);
        //        make.height.mas_equalTo(33);
    }];
    
    UILabel *maxNumLab = [[UILabel alloc]init];
    maxNumLab.text = @"/3000";
    maxNumLab.textColor = TEXT_GRAYmin_COLOR;
    maxNumLab.font = GlobalFont(13);
    [self.view addSubview:maxNumLab];
    
    [maxNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textNumLab.mas_right).offset(1);
        make.top.mas_equalTo(textNumLab.mas_top);
        //        make.height.mas_equalTo(33);
    }];
    
}


- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"清空文本", @"描述推荐"]];
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
        };
    }
    
    return _titleView;
}
#pragma mark - MyDelegate

-(void)sendContent:(NSString *)content{
    _decriStr = content;
    

}

#pragma mark - UITextDelegate

-(void)textViewDidBeginEditing:(UITextField *)textField{
    [_placeholderView setHidden:YES];

}

-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, self.titleView.frame.origin.y+self.titleView.frame.size.height, SCREEN_WIDTH, 229);
        _decriptionTextView.delegate = self;
        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeJobDecription];
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _decriptionTextView;
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
