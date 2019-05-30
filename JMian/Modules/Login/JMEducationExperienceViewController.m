//
//  JMEducationExperienceViewController.m
//  JMian
//
//  Created by chitat on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMEducationExperienceViewController.h"
#import "JMHTTPManager+EducationExperience.h"

typedef enum _PickerState_Exp {
    startWorkState,
    endWorkstate
} _PickerState_Exp;

@interface JMEducationExperienceViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *schoolNameField;
@property (weak, nonatomic) IBOutlet UIButton *selectEducationBtn;
@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;
@property (weak, nonatomic) IBOutlet UITextField *majorField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic)NSDate *startDate;
@property (strong, nonatomic)NSDate *endDate;
@property (nonatomic,assign) _PickerState_Exp pickerState;

@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerArray;
@property (nonatomic, copy) NSString *educationNum;


@end


@implementation JMEducationExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datePicker.backgroundColor = BG_COLOR;
    [self setPickerVIewUI];
    
//    [self setIsHiddenBackBtn:YES];

    NSArray *educationArr = [NSArray arrayWithObjects:@"不限",@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
    switch (self.viewType) {
        case JMEducationExperienceViewTypeAdd:
            self.title = @"新增教育经历";
            [self setRightBtnTextName:@"保存"];
            break;
        case JMEducationExperienceViewTypeEdit:
            self.title = @"编辑教育经历";
            self.educationNum = self.model.education;
            self.schoolNameField.text = self.model.school_name;
            self.majorField.text = self.model.major;
            [self.startTimeBtn setTitle:self.model.s_date forState:UIControlStateNormal];
            [self.endTimeBtn setTitle:self.model.e_date forState:UIControlStateNormal];
            [self.selectEducationBtn setTitle:educationArr[[self.model.education intValue]] forState:UIControlStateNormal];
            [self setRightBtnTextName:@"删除"];
            break;
    }
}

-(void)setPickerVIewUI{
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.backgroundColor = BG_COLOR;
    self.pickerView.delegate = self;
    
    self.pickerView.dataSource = self;
    
    [self.view addSubview:self.pickerView];
    
    self.pickerView.hidden = YES;
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(180);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    self.pickerArray = [NSArray arrayWithObjects:@"不限",@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
    
}
#pragma mark - PickerViewDelegate

//返回有几列

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    return [self.pickerArray count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [self.pickerArray objectAtIndex:row];
    
    return str;
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [self.selectEducationBtn setTitle:[self.pickerArray objectAtIndex:row] forState:UIControlStateNormal];
    [self.selectEducationBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    NSString *eduStr = [NSString stringWithFormat:@"%ld",row];
    self.educationNum = eduStr;

}
    
    
#pragma mark - Action
    
- (void)deleteExperience {
    [[JMHTTPManager sharedInstance] deleteEducationExperienceWith_experienceId:self.model.education_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

- (void)updateExperience {
    [[JMHTTPManager sharedInstance] updateEducationExperienceWithEducationId:self.model.education_id education:[NSString stringWithFormat:@"%@", self.educationNum] s_date:self.startDate e_date:self.endDate major:self.majorField.text description:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [self.navigationController popViewControllerAnimated:YES];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

- (void)createExperience {
    [[JMHTTPManager sharedInstance] createEducationExperienceWithSchool_name:self.schoolNameField.text education:[NSString stringWithFormat:@"%@", self.educationNum] s_date:self.startDate e_date:self.endDate major:self.majorField.text description:nil user_step:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

- (void)rightAction {
    switch (self.viewType) {
        case JMEducationExperienceViewTypeAdd:
            [self createExperience];
            break;
        case JMEducationExperienceViewTypeEdit:
            [self deleteExperience];
            break;
    }
}
- (IBAction)selectEducation:(id)sender {
    self.pickerArray = [NSArray arrayWithObjects:@"不限",@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
    
    [self.pickerView setHidden:NO];
    [self.datePicker setHidden:YES];
    
    [self.pickerView reloadAllComponents];
}

- (IBAction)clickStartTimeBtn:(id)sender {
    self.pickerView.hidden = YES;
    self.datePicker.hidden = NO;
    self.pickerState = startWorkState;
}
- (IBAction)clickEndTimeBtn:(id)sender {
    self.pickerView.hidden = YES;
    self.datePicker.hidden = NO;
    self.pickerState = endWorkstate;
}

- (IBAction)clickSaveBtn:(id)sender {
    switch (self.viewType) {
        case JMEducationExperienceViewTypeAdd:
            [self createExperience];
            break;
        case JMEducationExperienceViewTypeEdit:
            [self updateExperience];
            break;
    }
}

- (IBAction)datePickerValueChanged:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 格式化日期格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *date = [formatter stringFromDate:self.datePicker.date];
    // 显示时间
    if (self.pickerState == startWorkState) {
        
        [self.startTimeBtn setTitle:date forState:UIControlStateNormal];
        [self.startTimeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.startDate  = [formatter dateFromString:date];
        
    }else if(self.pickerState == endWorkstate){
        
        [self.endTimeBtn setTitle:date forState:UIControlStateNormal];
        [self.endTimeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.endDate = [formatter dateFromString:date];
        
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.datePicker setHidden:YES];
    self.pickerView.hidden = YES;
    [self.majorField resignFirstResponder];
    [self.schoolNameField resignFirstResponder];

}

@end
