//
//  JMPostNewJobViewController.m
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostNewJobViewController.h"
#import "JMJobDescriptionViewController.h"
#import "JMWelfareViewController.h"
#import "JMManageInterviewViewController.h"
#import "JMHTTPManager+Work.h"
#import "PositionDesiredViewController.h"



@interface JMPostNewJobViewController ()<UIPickerViewDelegate,UIScrollViewDelegate,JMWelfareDelegate,PositionDesiredDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *workNameBtn;
@property (weak, nonatomic) IBOutlet UIView *pickerBGView;
@property (weak, nonatomic) IBOutlet UIButton *workPropertyBtn;
@property (weak, nonatomic) IBOutlet UIButton *expriencesBtn;
@property (weak, nonatomic) IBOutlet UIButton *educationBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *salaryBtn;
@property (weak, nonatomic) IBOutlet UIButton *welfareBtn;
@property (weak, nonatomic) IBOutlet UIButton *workLocationBtn;
@property (weak, nonatomic) IBOutlet UIButton *jobDescriptionBtn;
@property (nonatomic, strong)NSArray *pickerArray;

@property (nonatomic,strong)UIButton *selectedBtn;
@property (nonatomic,copy)NSString *pickerStr;



@end

@implementation JMPostNewJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setTitle:@"发布新职位"];
    self.pickerView.delegate = self;
    self.scrollView.delegate = self;
    
    [self setRightBtnTextName:@"发布"];
   
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 点击事件

-(void)rightAction{
    
//    [JMHTTPManager sharedInstance]postCreateWorkWith_city_id:<#(nonnull NSNumber *)#> work_label_id:<#(nonnull NSNumber *)#> work_name:<#(nonnull NSString *)#> education:<#(nonnull NSNumber *)#> work_experience_min:<#(nonnull NSNumber *)#> work_experience_max:<#(nonnull NSNumber *)#> experience_max:<#(nonnull NSNumber *)#> salary_min:<#(nonnull NSNumber *)#> salary_max:<#(nonnull NSNumber *)#> description:<#(nonnull NSString *)#> address:<#(nonnull NSString *)#> longitude:<#(nonnull NSString *)#> latitude:<#(nonnull NSString *)#> status:<#(nonnull NSNumber *)#> label_ids:<#(nonnull NSArray *)#> SuccessBlock:<#^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject)successBlock#> failureBlock:<#^(JMHTTPRequest * _Nonnull request, id  _Nonnull error)failureBlock#>
    
    
    JMManageInterviewViewController *vc = [[JMManageInterviewViewController alloc]init];
    
    
    [self.navigationController pushViewController:vc animated:YES];

    NSLog(@"发布");

}

- (IBAction)workNameAction:(UIButton *)sender {
    PositionDesiredViewController *vc = [[PositionDesiredViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)sendPositoinData:(NSString *)labStr labIDStr:(NSString *)labIDStr{
    [self.workNameBtn setTitle:labStr forState:UIControlStateNormal];
    [self.workNameBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
}

- (IBAction)workPorpertyAction:(UIButton *)sender {
    self.pickerArray = [NSArray arrayWithObjects:@"兼职",@"全职",@"实习",nil];
    [self.pickerView reloadAllComponents];
    _selectedBtn = sender;
    [self.pickerBGView setHidden:NO];
}

- (IBAction)workExpriencesAction:(UIButton *)sender {
    self.pickerArray = [NSArray arrayWithObjects:@"1～3年",@"3～5年",@"5～10年",nil];
    [self.pickerView reloadAllComponents];
    _selectedBtn = sender;

    [self.pickerBGView setHidden:NO];

}

- (IBAction)educationAction:(UIButton *)sender {
    self.pickerArray = [NSArray arrayWithObjects:@"初中/中专",@"高中",@"大专",@"本科",@"研究生",@"博士",nil];
    [self.pickerView reloadAllComponents];
    _selectedBtn = sender;

    [self.pickerBGView setHidden:NO];

}

- (IBAction)salaryAction:(UIButton *)sender {
    self.pickerArray = [NSArray arrayWithObjects:@"3000~5000",@"5000~8000",@"8000~10000",@"10000~20000",nil];
    [self.pickerView reloadAllComponents];
    _selectedBtn = sender;

    [self.pickerBGView setHidden:NO];

}

- (IBAction)welFareAction:(UIButton *)sender{
    
    
    JMWelfareViewController *vc = [[JMWelfareViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)sendBtnLabData:(NSMutableArray *)btns{
    NSMutableArray *strArray = [[NSMutableArray alloc]init];
    for (int i=0; i<btns.count; i++) {
        UIButton *btn = btns[i];
        [strArray addObject:btn.titleLabel.text];
//        btn.titleLabel.text;
    }
    
    NSString *str = [strArray componentsJoinedByString:@","];
    [self.welfareBtn setTitle:str forState:UIControlStateNormal];
    [self.welfareBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
//    NSLog(@"%@",str);

}

- (IBAction)workLocationAction:(UIButton *)sender {
    
    
}

- (IBAction)jobDescriptionAction:(UIButton *)sender {
    
    JMJobDescriptionViewController *vc = [[JMJobDescriptionViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)pickerOKAction:(UIButton *)sender {
    [self.pickerBGView setHidden:YES];
    
}
- (IBAction)pickerViewDeleteAction:(id)sender {
    [self.pickerBGView setHidden:YES];
}


#pragma mark - pickerView delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (_selectedBtn.tag) {
        case 1:
            [self.workPropertyBtn setTitle:self.pickerArray[row] forState:UIControlStateNormal];
            [self.workPropertyBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            break;
       
        case 2:
            [self.expriencesBtn setTitle:self.pickerArray[row] forState:UIControlStateNormal];
            [self.expriencesBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];

            break;
      
        case 3:
            [self.educationBtn setTitle:self.pickerArray[row] forState:UIControlStateNormal];
            [self.educationBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];

            break;
        
        case 4:
            [self.salaryBtn setTitle:self.pickerArray[row] forState:UIControlStateNormal];
            [self.salaryBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];

            break;

        default:
            break;
    }


}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    return [self.pickerArray count];
    
}
//
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [self.pickerArray objectAtIndex:row];
    
    return str;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.pickerBGView setHidden:YES];

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
