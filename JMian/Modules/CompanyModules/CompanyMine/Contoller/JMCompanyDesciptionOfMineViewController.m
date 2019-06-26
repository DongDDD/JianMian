//
//  JMCompanyDesciptionOfMineViewController.m
//  JMian
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyDesciptionOfMineViewController.h"
#import "JMPartTimeJobResumeFooterView.h"

@interface JMCompanyDesciptionOfMineViewController() <UITextViewDelegate,JMPartTimeJobResumeFooterViewDelegate>

@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic, strong)UIView *placeholderView;
@property (nonatomic ,strong)UILabel *lab;
@property (strong, nonatomic)JMPartTimeJobResumeFooterView *decriptionTextView;

@end

@implementation JMCompanyDesciptionOfMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"公司简介";
//    [self setTextFieldUI];
    self.view.backgroundColor = BG_COLOR;
    [self setRightBtnTextName:@"保存"];
    [self.view addSubview:self.decriptionTextView];
}

-(void)rightAction{
    [self.decriptionTextView.contentTextView resignFirstResponder];
    [self.delegate sendTextView_textData:self.decriptionTextView.contentTextView.text];
    [self.navigationController popViewControllerAnimated:YES];


}

-(void)setComDesc:(NSString *)comDesc{

    [self.decriptionTextView setContent:comDesc];
    
}

//-(void)setTextFieldUI{
//    self.textView = [[UITextView alloc]init];
//    self.textView.text = self.comDesc;
//    self.textView.delegate = self;
//    self.textView.font = GlobalFont(14);
//
//    self.textView.returnKeyType = UIReturnKeyDone;//返回键类型
//    self.textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
//
//
//    [self.view addSubview:self.textView];
//
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left).offset(20);
//        make.right.mas_equalTo(self.view.mas_right).offset(-20);
//        make.top.mas_equalTo(self.view).offset(50);
//        make.bottom.mas_equalTo(self.view).offset(-110);
//    }];
//
//    UILabel *titLab = [[UILabel alloc]init];
//    titLab.text = @"公司简介";
//    titLab.font = [UIFont systemFontOfSize:12];
//    titLab.textColor = TITLE_COLOR;
//    [titLab sizeToFit];
//
//    [self.view addSubview:titLab];
//
//    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left).offset(20);
//        make.right.mas_equalTo(self.view.mas_right).offset(-20);
//        make.top.mas_equalTo(self.view).offset(20);
//
//    }];
////
//    if ([self.comDesc isEqualToString:@"请填写"]) {
//        self.lab = [[UILabel alloc]init];
//        self.lab.textColor = TEXT_GRAYmin_COLOR;
//        self.lab.font = GlobalFont(14);
//        self.lab.text = @"例如：\n 企业类型...\n 建立时间... \n从事哪方面的产品... \n以什么为重点... \n企业文化...";
//        self.lab.numberOfLines = 0;
//        [self.lab sizeToFit];
//        [self.view addSubview:self.lab];
//
//        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.view.mas_left).offset(20);
//            make.right.mas_equalTo(self.view.mas_right).offset(-20);
//            make.top.mas_equalTo(titLab.mas_bottom).offset(20);
//            //        make.height.mas_equalTo(33);
//        }];
//
//    }
//
//
//}


#pragma mark - UITextDelegate

//-(void)textViewDidBeginEditing:(UITextField *)textField{
//    [self.lab setHidden:YES];
//
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    //判断类型，如果不是UITextView类型，收起键盘
//    for (UIView* view in self.view.subviews) {
//        if ([view isKindOfClass:[UITextView class]]) {
//            UITextView* tv = (UITextView*)view;
//            [tv resignFirstResponder];
//        }
//    }
//}


-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 229);
        _decriptionTextView.delegate = self;
        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeCompanyInfoDescription];
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
