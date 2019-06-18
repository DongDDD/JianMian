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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incomeTapAction)];
        [self.incomeLab addGestureRecognizer:tap];
     
        
    }
    return self;
}

-(void)setUserModel:(JMUserInfoModel *)userModel{
    NSInteger A = [userModel.available_amount_c integerValue];
    NSInteger B = [userModel.unusable_amount_c integerValue];
    NSInteger C = A + B;
    NSString *income = [NSString stringWithFormat:@"%ld",(long)C];
    self.incomeLab.text = income;
    self.taskCompletedLab.text = [NSString stringWithFormat:@"进行中的任务：%@",userModel.task_completed_count];
    self.taskProcessingLab.text = [NSString stringWithFormat:@"已完成的任务：%@",userModel.task_processing_count];
    
//  self.incomeLab.text =

}

-(void)incomeTapAction{

    if (_delegate && [_delegate respondsToSelector:@selector(didClickIncomeAction)]) {
        [_delegate didClickIncomeAction];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
