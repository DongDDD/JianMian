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
@property (weak, nonatomic) IBOutlet UILabel *allLab;
@property (weak, nonatomic) IBOutlet UILabel *dfhLab;
@property (weak, nonatomic) IBOutlet UILabel *shzLab;
@property (weak, nonatomic) IBOutlet UILabel *wfkLab;
@property (weak, nonatomic) IBOutlet UIView *dian;

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

-(void)setValueWithAll:(NSString *)all dfh:(NSString *)dfh shz:(NSString *)shz wfk:(NSString *)wfk{
    self.allLab.text = all;
    self.dfhLab.text = dfh;
    self.shzLab.text = shz;
    self.wfkLab.text = wfk;
    if (![wfk isEqualToString:@"0"]) {
        [self.dian setHidden:NO];
    }else{
        [self.dian setHidden:YES];

    }
    
    
}

- (IBAction)statusBtnAction:(UIButton *)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
