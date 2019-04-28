//
//  JMChooseTimeViewController.m
//  JMian
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChooseTimeViewController.h"

@interface JMChooseTimeViewController ()<UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property(nonatomic,strong)NSArray *monthArray;
@property(nonatomic,strong)NSArray *dayArray;
@property(nonatomic,strong)NSArray *am_pm_Array;
@property(nonatomic,strong)NSArray *hourArray;
@property(nonatomic,strong)NSArray *minuteArray;

@property(nonatomic,strong)NSMutableArray *interviewTimeArray;


@end

@implementation JMChooseTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;

    
    self.pickerView.delegate = self;
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    

}
- (IBAction)deleteAction:(UIButton *)sender {
    [self.delegate deleteInteviewTimeViewAction];
 

}

- (IBAction)OKAction:(UIButton *)sender {
//    NSString *text = [self.interviewTimeArray componentsJoinedByString:@"-"];
    NSString *timeStr = [NSString stringWithFormat:@"2020-%@-%@ %@:%@",self.interviewTimeArray[0],self.interviewTimeArray[1],self.interviewTimeArray[2],self.interviewTimeArray[3]];
    [self.delegate OKInteviewTimeViewAction:timeStr];

}


//返回有几列

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 5;
    
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (component == 0) {
        return [self.monthArray count];
        
    }else if (component == 1){
    
        return [self.dayArray count];

    
    }else if (component == 2){
        
        
        return [self.am_pm_Array count];

    }else if (component == 3){
        
        
        return [self.hourArray count];

    }else if (component == 4){
        
        return [self.minuteArray count];

        
    }
    return [self.monthArray count];

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
       
        [self.interviewTimeArray addObject:[self.monthArray objectAtIndex:row]];
        return [self.monthArray objectAtIndex:row];
  
    }else if (component == 1){
        
        [self.interviewTimeArray addObject:[self.dayArray objectAtIndex:row]];
        return [self.dayArray objectAtIndex:row];
        
    }else if (component == 2){
        
        return [self.am_pm_Array objectAtIndex:row];

    }else if (component == 3){
        
        [self.interviewTimeArray addObject:[self.hourArray objectAtIndex:row]];
        return [self.hourArray objectAtIndex:row];

    }else if (component == 4){
        
        [self.interviewTimeArray addObject:[self.minuteArray objectAtIndex:row]];
        return [self.minuteArray objectAtIndex:row];
   
    }
    return [self.monthArray objectAtIndex:row];
 
    
}


-(NSArray *)monthArray{
    if (!_monthArray) {
        _monthArray = [NSArray array];
        _monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    }

    return _monthArray;
}

-(NSArray *)dayArray{
    if (!_dayArray) {
        _dayArray = @[@"12",@"21"];
    }
    
    return _dayArray;
}


-(NSArray *)am_pm_Array{
    if (!_am_pm_Array) {
        _am_pm_Array = @[@"上午",@"下午"];
    }
    
    return _am_pm_Array;
}


-(NSArray *)hourArray{
    if (!_hourArray) {
        _hourArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    }
    
    return _hourArray;
}

-(NSArray *)minuteArray{
    if (!_minuteArray) {
        _minuteArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"50",@"8",@"9",@"10",@"11",@"60"];
    }
    
    return _minuteArray;
    
}

-(NSMutableArray *)interviewTimeArray{
    if (!_interviewTimeArray) {
        _interviewTimeArray = [NSMutableArray array];
    }
    
    return _interviewTimeArray;

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
