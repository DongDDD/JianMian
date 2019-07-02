//
//  JMEducationExperienceViewController.m
//  JMian
//
//  Created by chitat on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMEducationExperienceViewController.h"
#import "JMHTTPManager+EducationExperience.h"
#import "STPickerDate.h"
#import "STPickerSingle.h"

//typedef enum _PickerState_Exp {
//    startWorkState,
//    endWorkstate
//} _PickerState_Exp;

@interface JMEducationExperienceViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,STPickerDateDelegate,STPickerSingleDelegate>
@property (weak, nonatomic) IBOutlet UITextField *schoolNameField;
@property (weak, nonatomic) IBOutlet UIButton *selectEducationBtn;
@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;
@property (weak, nonatomic) IBOutlet UITextField *majorField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) STPickerSingle *educationPickerSingle;
@property (nonatomic,strong) STPickerDate *pickerDataStart;
@property (nonatomic,strong) STPickerDate *pickerDataEnd;

@property (strong, nonatomic)NSString *startDate;
@property (strong, nonatomic)NSString *endDate;
//@property (nonatomic,assign) _PickerState_Exp pickerState;

@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerArray;
@property (nonatomic, copy) NSString *educationNum;


@end


@implementation JMEducationExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datePicker.backgroundColor = BG_COLOR;
    self.schoolNameField.delegate = self;
    self.majorField.delegate = self;
//    [self setPickerVIewUI];
    
//    [self setIsHiddenBackBtn:YES];

    NSArray *educationArr = [NSArray arrayWithObjects:@"不限",@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
    switch (self.viewType) {
        case JMEducationExperienceViewTypeAdd:
            self.title = @"新增教育经历";
            [self setRightBtnTextName:@"保存"];
            [self.startTimeBtn setTitleColor:TEXT_GRAYmin_COLOR forState:UIControlStateNormal];
            [self.endTimeBtn setTitleColor:TEXT_GRAYmin_COLOR forState:UIControlStateNormal];
            [self.selectEducationBtn setTitleColor:TEXT_GRAYmin_COLOR forState:UIControlStateNormal];

            break;
        case JMEducationExperienceViewTypeEdit:
            self.title = @"编辑教育经历";
            self.educationNum = self.model.education;
            self.schoolNameField.text = self.model.school_name;
            self.majorField.text = self.model.major;
            [self.startTimeBtn setTitle:self.model.s_date forState:UIControlStateNormal];
            [self.endTimeBtn setTitle:self.model.e_date forState:UIControlStateNormal];
            [self.selectEducationBtn setTitle:educationArr[[self.model.education intValue]] forState:UIControlStateNormal];
            [self.startTimeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            [self.endTimeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            [self.selectEducationBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            [self setRightBtnTextName:@"删除"];
            break;
    }
}

//-(void)setPickerVIewUI{
//    self.pickerView = [[UIPickerView alloc]init];
//    self.pickerView.backgroundColor = BG_COLOR;
//    self.pickerView.delegate = self;
//
//    self.pickerView.dataSource = self;
//
//    [self.view addSubview:self.pickerView];
//
//    self.pickerView.hidden = YES;
//
//    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(self.view);
//        make.height.mas_equalTo(180);
//        make.bottom.mas_equalTo(self.view.mas_bottom);
//    }];
//
//    self.pickerArray = [NSArray arrayWithObjects:@"不限",@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
//
//}
#pragma mark - PickerViewDelegate
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle row:(NSInteger)row{
    //    _isChange = YES;
    if (pickerSingle == _educationPickerSingle) {
        [self.selectEducationBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.selectEducationBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.educationNum =  [self getEducationNumWithEducationStr:selectedTitle];
    }
    
    
    
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    if (pickerDate == _pickerDataStart) {
        NSString *title = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
        [self.startTimeBtn setTitle:title forState:UIControlStateNormal];
        [self.startTimeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.startDate = title;
    }else if (pickerDate == _pickerDataEnd) {
        NSString *title = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
        [self.endTimeBtn setTitle:title forState:UIControlStateNormal];
        [self.endTimeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.endDate = title;
        
    }
    
    
}
//返回有几列

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    [self.schoolNameField resignFirstResponder];
    [self.majorField resignFirstResponder];
    return [self.pickerArray count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [self.pickerArray objectAtIndex:row];
    
    return str;
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [self.selectEducationBtn setTitle:[self.pickerArray objectAtIndex:row] forState:UIControlStateNormal];
    [self.selectEducationBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    NSString *eduStr = [NSString stringWithFormat:@"%ld",row+1];
    self.educationNum = eduStr;

}

#pragma mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

    
#pragma mark - Action
    
- (void)deleteExperience {
    [self showAlertWithTitle:@"提醒⚠️" message:@"删除后数据将不可恢复" leftTitle:@"返回" rightTitle:@"确认删除"];
}

-(void)alertRightAction{
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
//    self.pickerArray = [NSArray arrayWithObjects:@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
//
//    [self.pickerView setHidden:NO];
//    [self.datePicker setHidden:YES];
//
//    [self.pickerView reloadAllComponents];
    [self.view addSubview:self.educationPickerSingle];
    [self.educationPickerSingle show];
}

- (IBAction)clickStartTimeBtn:(id)sender {
//    self.pickerView.hidden = YES;
//    self.datePicker.hidden = NO;
//    self.pickerState = startWorkState;
    [self.view addSubview:self.pickerDataStart];
    [self.pickerDataStart show];
}
- (IBAction)clickEndTimeBtn:(id)sender {
//    self.pickerView.hidden = YES;
//    self.datePicker.hidden = NO;
////    self.pickerState = endWorkstate;
    [self.view addSubview:self.pickerDataEnd];
    [self.pickerDataEnd show];
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

//- (IBAction)datePickerValueChanged:(id)sender {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    // 格式化日期格式
//    formatter.dateFormat = @"yyyy-MM-dd";
//    NSString *date = [formatter stringFromDate:self.datePicker.date];
//    // 显示时间
//    if (self.pickerState == startWorkState) {
//
//        [self.startTimeBtn setTitle:date forState:UIControlStateNormal];
//        [self.startTimeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
//        self.startDate  = [formatter dateFromString:date];
//
//    }else if(self.pickerState == endWorkstate){
//
//        [self.endTimeBtn setTitle:date forState:UIControlStateNormal];
//        [self.endTimeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
//        self.endDate = [formatter dateFromString:date];
//
//    }
//
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.datePicker setHidden:YES];
    self.pickerView.hidden = YES;
//    [self.majorField resignFirstResponder];
//    [self.schoolNameField resignFirstResponder];

}

-(STPickerSingle *)educationPickerSingle{
    if (_educationPickerSingle == nil) {
        _educationPickerSingle = [[STPickerSingle alloc]init];
        _educationPickerSingle.delegate = self;
        _educationPickerSingle.title = @"最高学历";
        _educationPickerSingle.widthPickerComponent = SCREEN_WIDTH;
        _educationPickerSingle.arrayData = [NSMutableArray arrayWithObjects:                                            @"初中及以下",
                                            @"中专/中技",
                                            @"高中",
                                            @"大专",
                                            @"本科",
                                            @"硕士",
                                            @"博士",
                                            nil];
    }
    return _educationPickerSingle;
}

-(STPickerDate *)pickerDataStart{
    if (_pickerDataStart == nil) {
        _pickerDataStart = [[STPickerDate alloc]init];
        _pickerDataStart.delegate = self;
        _pickerDataStart.yearLeast = 1950;
        _pickerDataStart.yearSum = 2018;
        _pickerDataStart.heightPickerComponent = 28;
        
    }
    return _pickerDataStart;
}

-(STPickerDate *)pickerDataEnd{
    if (_pickerDataEnd == nil) {
        _pickerDataEnd = [[STPickerDate alloc]init];
        _pickerDataEnd.delegate = self;
        _pickerDataEnd.yearLeast = 1950;
        _pickerDataEnd.yearSum = 2020;
        _pickerDataEnd.heightPickerComponent = 28;
        
    }
    return _pickerDataEnd;
}
@end
