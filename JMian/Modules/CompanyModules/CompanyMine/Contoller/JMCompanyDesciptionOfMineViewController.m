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

-(void)doneClicked{
    [_decriptionTextView.contentTextView resignFirstResponder];
}



#pragma mark - UITextDelegate



-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 229);
        _decriptionTextView.delegate = self;
        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
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
