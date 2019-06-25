//
//  JMSquareHeaderView.m
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMSquareHeaderView.h"
@interface JMSquareHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *incomeLab;
@property (weak, nonatomic) IBOutlet UILabel *taskProcessingLab;
@property (weak, nonatomic) IBOutlet UILabel *taskCompletedLab;


@end

@implementation JMSquareHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
//        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeTap1Action)];
//        [self.incomeLab addGestureRecognizer:tap1];
//        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeTap2Action)];
//        [self.taskProcessingLab addGestureRecognizer:tap2];
//        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeTap3Action)];
//        [self.taskCompletedLab addGestureRecognizer:tap3];
   
    }
    return self;
}

-(void)setUserModel:(JMUserInfoModel *)userModel{

    self.incomeLab.text = [self calculateByadding:userModel.available_amount_c secondNumber:userModel.unusable_amount_c];
    self.taskProcessingLab.text = [NSString stringWithFormat:@"进行中的任务：%@",userModel.task_processing_count];
    self.taskCompletedLab.text = [NSString stringWithFormat:@"已完成的任务：%@",userModel.task_completed_count];

//  self.incomeLab.text =

}

//-(void)incomeTap1Action{
//
//    if (_delegate && [_delegate respondsToSelector:@selector(didClickIncomeAction)]) {
//        [_delegate didClickIncomeAction];
//    }
//
//}
//-(void)incomeTap2Action{
//
//    if (_delegate && [_delegate respondsToSelector:@selector(didClickTaskProcessingAction)]) {
//        [_delegate didClickTaskProcessingAction];
//    }
//
//}
//-(void)incomeTap3Action{
//
//    if (_delegate && [_delegate respondsToSelector:@selector(didClickTaskCompletedAction)]) {
//        [_delegate didClickTaskCompletedAction];
//    }
//
//}
- (IBAction)incomeAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickIncomeAction)]) {
        [_delegate didClickIncomeAction];
    }
}
- (IBAction)taskProcessingAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickTaskProcessingAction)]) {
        [_delegate didClickTaskProcessingAction];
    }
}
- (IBAction)taskCompletedAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickTaskCompletedAction)]) {
        [_delegate didClickTaskCompletedAction];
    }
}


#pragma mark ----两个数相加-----------

-(NSString *)calculateByadding:(NSString *)number1 secondNumber:(NSString *)number2
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *addingNum = [num1 decimalNumberByAdding:num2];
    return [addingNum stringValue];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
