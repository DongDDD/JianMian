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

@interface JMMyDescriptionViewController ()<JMLabsScreenViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *myDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (nonatomic, strong) JMLabsScreenView *labsScreenView;

@end

@implementation JMMyDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myDescriptionTextView.delegate = self;
    self.myDescriptionTextView.text = self.myDescription;
    [self setRightBtnTextName:@"保存"];
    [self.view addSubview:self.labsScreenView];
}

- (void)updateVita {
    [[JMHTTPManager sharedInstance] updateVitaWith_work_status:nil education:nil work_start_date:nil description:self.myDescriptionTextView.text video_path:nil image_paths:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
       
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

- (IBAction)saveBtn:(id)sender {
}

- (void)rightAction {
    if (self.myDescriptionTextView.text.length > 5) {
        [self updateVita];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"描述太短啦"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
    }
}

- (void)setMyDescription:(NSString *)myDescription {
    _myDescription = myDescription;
    [self.myDescriptionTextView setText:myDescription];
}

-(JMLabsScreenView *)labsScreenView{
    if (_labsScreenView == nil) {
        _labsScreenView = [[JMLabsScreenView alloc]initWithFrame:CGRectMake(0, self.footView.frame.origin.y-30, SCREEN_WIDTH, 300)];
        _labsScreenView.backgroundColor = [UIColor whiteColor];
        NSArray *labs = @[@"超强管理能力",@"协调沟通能力强",@"责任心强",@"团队意识强",@"动手能力强",@"工作经验丰富",@"有相关技能证书",@"我英语贼6"];
        [_labsScreenView createLabUI_title:@"" labsArray:labs];
        _labsScreenView.delegate = self;

    }
    return  _labsScreenView;
    
}

- (void)didChooseLabsTitle_str:(nonnull NSString *)str index:(NSInteger)index {
    NSString *text = [NSString stringWithFormat:@"%@%@",self.myDescriptionTextView.text,str];
//    _myDescription = text;
    [self setMyDescription:text];

}


@end
