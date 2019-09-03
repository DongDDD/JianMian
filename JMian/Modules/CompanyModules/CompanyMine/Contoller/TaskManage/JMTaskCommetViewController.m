//
//  JMTaskCommetViewController.m
//  JMian
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskCommetViewController.h"
#import "JMPartTimeJobResumeFooterView.h"
#import "JMHTTPManager+CreateTaskComment.h"
#import "DimensMacros.h"

@interface JMTaskCommetViewController ()<JMPartTimeJobResumeFooterViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLab;
@property (weak, nonatomic) IBOutlet UILabel *labs;
@property (strong, nonatomic)JMPartTimeJobResumeFooterView *decriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *starLevelLab;
@property (nonatomic, copy)NSString *comDesc;
@end

@implementation JMTaskCommetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightBtnTextName:@"提交"];
    [self.scrollView addSubview:self.decriptionTextView];
    self.iconImgView.layer.cornerRadius = self.iconImgView.frame.size.width/2;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        
        NSURL *url = [NSURL URLWithString:self.data.user_avatar];
        [self.iconImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        
        self.nameLab.text = self.data.user_nickname;
        self.cityNameLab.text =[NSString stringWithFormat:@" %@   ",self.data.snapshot_cityName];
        //职位标签
        NSMutableArray *industryNameArray = [NSMutableArray array];
        for (JMTaskOrderIndustryModel *IndustryData in self.data.industry) {
            [industryNameArray addObject:IndustryData.name];
        }
        NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
        self.labs.text = [NSString stringWithFormat:@" %@   ",industryStr];
        
    }else{
        NSURL *url = [NSURL URLWithString:self.data.snapshot_companyLogo_path];
         [self.iconImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        self.nameLab.text = self.data.task_title;
        self.cityNameLab.text = self.data.snapshot_companyName;
        self.cityNameLab.textColor = MASTER_COLOR;
        self.cityNameLab.layer.borderWidth = 0;
        
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)rightAction{
    [self.decriptionTextView.contentTextView resignFirstResponder];
    [self createTaskCommentRequestWithTask_order_id:self.data.task_order_id reputation:Comment_VeryGood commentDescription:_comDesc];

}

- (void)sendContent:(nonnull NSString *)content {
    self.comDesc = content;
}

//创建评价
-(void)createTaskCommentRequestWithTask_order_id:(NSString *)task_order_id reputation:(NSString *)reputation commentDescription:(NSString *)commentDescription{
    [[JMHTTPManager sharedInstance]createTaskCommentWithForeign_key:task_order_id reputation:reputation commentDescription:commentDescription successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (_delegate && [_delegate respondsToSelector:@selector(didComment)]) {
            [_delegate didComment];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)doneClicked{
    [_decriptionTextView.contentTextView resignFirstResponder];
}

#pragma mark - Getter

- (JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, self.starLevelLab.frame.origin.y+self.starLevelLab.frame.size.height+16, SCREEN_WIDTH, 229);
        _decriptionTextView.delegate = self;
        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeCommentDesc];
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
