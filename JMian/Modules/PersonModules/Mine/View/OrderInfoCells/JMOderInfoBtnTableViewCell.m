//
//  JMOderInfoBtnTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOderInfoBtnTableViewCell.h"
NSString *const JMOderInfoBtnTableViewCellIdentifier = @"JMOderInfoBtnTableViewCellIdentifier";
@interface JMOderInfoBtnTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;//确认申请
@property (weak, nonatomic) IBOutlet UIButton *btn0;//再次申请
@property (weak, nonatomic) IBOutlet UIButton *btn1;//拒绝申请
@property (weak, nonatomic) IBOutlet UIButton *btn2;//联系买家
@property (weak, nonatomic) IBOutlet UIButton *btn3;//客服介入
@property (weak, nonatomic) IBOutlet UIButton *btn4;//申请退款
@property (weak, nonatomic) IBOutlet UIButton *btn5;//确认退款
@property (weak, nonatomic) IBOutlet UIButton *btn6;//去发货
@property (weak, nonatomic) IBOutlet UIButton *btn7;//确认收货
@property (weak, nonatomic) IBOutlet UIButton *btn8;//售后中
@property (weak, nonatomic) IBOutlet UIButton *btn9;//申请售后
@property (weak, nonatomic) IBOutlet UIButton *btn10;//撤销申请

@end

@implementation JMOderInfoBtnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setViewType:(JMOderInfoBtnTableViewCelllType)viewType{
    switch (self.viewType) {
        case JMOderInfoBtnTypeTradeSuccessfully:
           [self.btn2 setHidden:NO];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)btnAction:(UIButton *)sender {
    NSString *btnTitle;
    switch (sender.tag) {
        case 100:
            btnTitle = @"再次申请";
            break;
        case 101:
            btnTitle = @"拒绝申请";
            break;
        case 102:
            btnTitle = @"联系买家";
            break;
        case 103:
            btnTitle = @"客服介入";
            break;
        case 104:
            btnTitle = @"申请退款";
            break;
        case 105:
            btnTitle = @"确认退款";
            break;
        case 106:
            btnTitle = @"去发货";
            break;
        case 107:
            btnTitle = @"售后中";
            break;
        case 108:
            btnTitle = @"申请售后";
            break;
        case 109:
            btnTitle = @"撤销申请";
            break;
        case 110:
            btnTitle = @"联系买家";
            break;
        case 111:
            btnTitle = @"联系买家";
            break;
        default:
            break;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickBtnWithBtnTtitle:)]) {
        [_delegate didClickBtnWithBtnTtitle:btnTitle];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
