//
//  JMDiscoverCollectionViewCell.m
//  JMian
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMDiscoverCollectionViewCell.h"
#import "DimensMacros.h"
@interface JMDiscoverCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImagView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

@property (nonatomic, strong) JMVideoListCellData *myData;
@end

@implementation JMDiscoverCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
  
        
    }
    return self;
}

-(void)setData:(JMVideoListCellData *)data{
    _myData = data;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        self.nameLab.text = data.user_nickname;
        [self.iconImagView sd_setImageWithURL:[NSURL URLWithString:data.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        self.infoLab.text = data.work_name;
    }else{
        
        
    }
    
 
}
- (IBAction)playAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickPlayAction_data:)]) {
        [_delegate didClickPlayAction_data:_myData];
    }
    
}

@end
