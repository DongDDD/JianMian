//
//  JMMyDescriptionViewController.m
//  JMian
//
//  Created by chitat on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyDescriptionViewController.h"
#import "JMHTTPManager+Vita.h"
#import "JMLabsScreenView.h"
#import "DimensMacros.h"
#import "JMPartTimeJobResumeFooterView.h"

@interface JMMyDescriptionViewController ()<UITextViewDelegate,JMLabsScreenViewDelegate>
@property (nonatomic, strong) JMLabsScreenView *labsScreenView;
@property (strong, nonatomic)JMPartTimeJobResumeFooterView *decriptionTextView;

@end

@implementation JMMyDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"我的优势";
//    self.myDescriptionTextView.delegate = self;
//    self.myDescriptionTextView.text = self.myDescription;
    self.view.backgroundColor = BG_COLOR;
    [self setRightBtnTextName:@"保存"];
    [self.view addSubview:self.decriptionTextView];
    [self.view addSubview:self.labsScreenView];
}

- (void)updateVita {
    [self.decriptionTextView.contentTextView resignFirstResponder];
    [[JMHTTPManager sharedInstance] updateVitaWith_work_status:nil education:nil work_start_date:nil description:self.decriptionTextView.contentTextView.text video_path:nil video_cover:nil  image_paths:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
       
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}


- (void)rightAction {
    if (self.decriptionTextView.contentTextView.text.length > 5) {
        [self updateVita];
    }else{
        [self showAlertSimpleTips:@"提示" message:@"描述太短啦" btnTitle:@"好的"];
        
    }
}

-(void)doneClicked{
    [_decriptionTextView.contentTextView resignFirstResponder];
}

-(void)setMyDescription:(NSString *)myDescription {
    [self.decriptionTextView setContent:myDescription];
    [self.decriptionTextView.placeHolder setHidden:YES];
}

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text containsString:@"\n"]) {
//        [textView resignFirstResponder];
//        return YES;
//    }
//    return NO;
//
//}

-(JMLabsScreenView *)labsScreenView{
    if (_labsScreenView == nil) {
        _labsScreenView = [[JMLabsScreenView alloc]initWithFrame:CGRectMake(0, self.decriptionTextView.frame.origin.y+self.decriptionTextView.frame.size.height + 10, SCREEN_WIDTH, 300)];
        _labsScreenView.viewType = JMLabsScreenViewMyAdvantage;
        _labsScreenView.backgroundColor = [UIColor whiteColor];
        NSArray *labs = @[@"超强管理能力",@"协调沟通能力强",@"责任心强",@"团队意识强",@"动手能力强",@"工作经验丰富",@"有相关技能证书",@"我英语贼6"];
        [_labsScreenView createLabUI_title:@"" labsArray:labs];
        _labsScreenView.delegate = self;

    }
    return  _labsScreenView;
    
}

- (void)didChooseLabsTitle_str:(nonnull NSString *)str index:(NSInteger)index {
    NSString *text = [NSString stringWithFormat:@"%@%@",self.decriptionTextView.contentTextView.text,str];
//    _myDescription = text;
//    [self setMyDescription:text];
    if (text.length < 150) {
        
        [self.decriptionTextView setContent:text];
    }else{
        [self showAlertSimpleTips:@"提示" message:@"不能大于150字" btnTitle:@"好的"];
    }

//    [self.decriptionTextView.contentTextView setText:text];
    [self.decriptionTextView.placeHolder setHidden:YES];

}

-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
//        _decriptionTextView.contentTextView.delegate = self;
        _decriptionTextView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 229);
        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeMyAdvantage];
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _decriptionTextView;
}

@end
