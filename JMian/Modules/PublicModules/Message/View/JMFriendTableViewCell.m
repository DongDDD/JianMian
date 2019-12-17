//
//  JMFriendTableViewCell.m
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMFriendTableViewCell.h"
#import "DimensMacros.h"
@interface JMFriendTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *headerIconImg;
@property(nonatomic,strong)JMFriendListModel *myModel;

@end

@implementation JMFriendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMFriendListModel *)model{
    _myModel = model;
    [self.headerIconImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.titleLab.text = model.nickname;
    self.subTitleLab.text = model.agency_company_name;

}

- (IBAction)addAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(addFriendActionWithModel:)]) {
        [_delegate addFriendActionWithModel:_myModel];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
