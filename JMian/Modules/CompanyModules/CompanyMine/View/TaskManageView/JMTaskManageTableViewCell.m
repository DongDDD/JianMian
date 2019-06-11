//
//  JMTaskManageTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskManageTableViewCell.h"
@interface JMTaskManageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *headerLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UIImageView *headerRightImgView;
@property (weak, nonatomic) IBOutlet UILabel *infoLab1;
@property (weak, nonatomic) IBOutlet UILabel *infoLab2;
@property (weak, nonatomic) IBOutlet UILabel *infoLab3;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation JMTaskManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTaskCellView_viewType:(JMTaskManageTableViewCellType)viewType data:(JMTaskManageCellData *)data{
    switch (viewType) {
        case JMTaskManageTableViewCellTypeNoPass:
            
            break;
        case JMTaskManageTableViewCellTypeDoing:
            
            break;
        case JMTaskManageTableViewCellTypeFinish:
            
            break;
            
        default:
            break;
    }
    
    
}

-(void)setNoPassStatusButtons_data:(JMTaskManageCellData *)data{
    [self.leftBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    switch (0) {
        case 0:
            [self.rightBtn setTitle:@"通过并发送产品链接" forState:UIControlStateNormal];
            
            break;
        case 1:
            [self.rightBtn setTitle:@"通过" forState:UIControlStateNormal];

            break;
        default:
            break;
    }

    
}
-(void)setDoingStatusButtons_data:(JMTaskManageCellData *)data{
    [self.leftBtn setTitle:@"和他聊聊" forState:UIControlStateNormal];
    switch (0) {
        case 0:
            [self.rightBtn setTitle:@"结束任务" forState:UIControlStateNormal];
            
            break;
        case 1:
            [self.rightBtn setTitle:@"任务完成&支付尾款" forState:UIControlStateNormal];
            
            break;
        default:
            break;
    }
    
}
-(void)setFinishStatusButtons_data:(JMTaskManageCellData *)data{
    
    [self.leftBtn setTitle:@"和他聊聊" forState:UIControlStateNormal];
    switch (0) {
        case 0:
            [self.rightBtn setTitle:@"结束任务" forState:UIControlStateNormal];
            self.headerRightImgView.image = [UIImage imageNamed:@"stale_dated"];
            break;
        case 1:
            [self.rightBtn setTitle:@"任务完成&支付尾款" forState:UIControlStateNormal];
            self.headerRightImgView.image = [UIImage imageNamed:@"Timeout"];

            break;
        default:
            break;
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
