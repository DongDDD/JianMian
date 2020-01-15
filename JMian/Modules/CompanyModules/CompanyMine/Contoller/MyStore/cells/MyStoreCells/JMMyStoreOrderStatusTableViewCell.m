//
//  JMMyStoreOrderStatusTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMMyStoreOrderStatusTableViewCell.h"
#import "JMMyStoreOrderStatusCollectionViewCell.h"
NSString *const JMMyStoreOrderStatusTableViewCellIdentifier = @"JMMyStoreOrderStatusTableViewCellIdentifierIdentifier";

@interface JMMyStoreOrderStatusTableViewCell ()
@property (strong, nonatomic) NSArray *topTitleArr,*bottomTitleArr;
@property (weak, nonatomic) IBOutlet UIImageView *BGImageView;

@end

@implementation JMMyStoreOrderStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topTitleArr = @[@"1000",@"100",@"10",@"1"];
    self.bottomTitleArr = @[@"全部订单",@"未付款",@"待发货",@"退款中"];
    self.BGImageView.layer.shadowColor = [UIColor colorWithRed:20/255.0 green:31/255.0 blue:87/255.0 alpha:0.1].CGColor;
     self.BGImageView.layer.shadowOffset = CGSizeMake(0,1);
     self.BGImageView.layer.shadowOpacity = 1;
     self.BGImageView.layer.shadowRadius = 6;
     self.BGImageView.layer.cornerRadius = 5;

    // Initialization code
}

- (IBAction)statusBtnAction:(UIButton *)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
