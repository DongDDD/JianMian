//
//  JMChatDetailPartTimeJobTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChatDetailPartTimeJobTableViewCell.h"
#import "DimensMacros.h"
@interface JMChatDetailPartTimeJobTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleNamelab;
@property (weak, nonatomic) IBOutlet UILabel *paymentLab;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UIButton *bottomRightBtn;

@property (nonatomic, strong)JMMessageListModel *myModel;
@end

@implementation JMChatDetailPartTimeJobTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:95/255.0 blue:133/255.0 alpha:0.1].CGColor;
        self.bgView.layer.shadowOffset = CGSizeMake(0,2);
        self.bgView.layer.shadowOpacity = 1;
        self.bgView.layer.shadowRadius = 5;
        self.bgView.layer.borderWidth = 0.5;
        self.bgView.layer.borderColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0].CGColor;
    }
    return self;
}
-(void)setMyConModel:(JMMessageListModel *)myConModel{
    _myModel = myConModel;
    self.titleNamelab.text = myConModel.work_task_title;
    self.paymentLab.text = [NSString stringWithFormat:@"%@%@",myConModel.work_payment_money,myConModel.work_unit];
    if ([myConModel.work_payment_method isEqualToString:@"3"]) {
        self.lab1.text = @"  完工结  ";
        
    }else if ([myConModel.work_payment_method isEqualToString:@"1"])
        self.lab1.text = @"  即时结 ";
    
}

- (IBAction)bottomRightAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(applyForAction_model:)]) {
        [_delegate applyForAction_model:_myModel];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
