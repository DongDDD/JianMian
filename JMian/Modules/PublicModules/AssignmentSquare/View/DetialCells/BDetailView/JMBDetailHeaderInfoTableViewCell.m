//
//  JMBDetailHeaderInfoTableViewCell.m
//  JMian
//
//  Created by mac on 2019/9/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBDetailHeaderInfoTableViewCell.h"
#import "DimensMacros.h"
#import "JMGradeView.h"

NSString *const JMBDetailHeaderInfoTableViewCellIdentifier = @"JMBDetailHeaderInfoTableViewCellIdentifier";
@interface JMBDetailHeaderInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UILabel *industry1;
@property (weak, nonatomic) IBOutlet UILabel *industry2;
@property (weak, nonatomic) IBOutlet UILabel *industry3;
@property (nonatomic, strong)JMGradeView *gradeView;
@property (nonatomic, copy)NSString *header_url;

@end

@implementation JMBDetailHeaderInfoTableViewCell
-(void)prepareForReuse{
    [super prepareForReuse];
    [self.gradeView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconAction)];
    [self.iconImg addGestureRecognizer:tap];
    _iconImg.userInteractionEnabled = YES;
}

-(void)setModel:(JMBDetailModel *)model{
    _header_url = model.user_avatar;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.nameLab.text = model.user_nickname;
    
    NSMutableArray *industryNameArray = [NSMutableArray array];
    for (JMBDetailIndustryModel *IndustryData in model.industry) {
        [industryNameArray addObject:IndustryData.name];
    }
//    NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
    if (industryNameArray.count == 1) {
        self.industry1.text = [NSString stringWithFormat:@"  %@  ",industryNameArray[0]]; [self.industry1 setHidden:NO];
        [self.industry2 setHidden:YES];
        [self.industry3 setHidden:YES];
    }else if (industryNameArray.count == 2) {
        self.industry1.text =[NSString stringWithFormat:@"  %@  ",industryNameArray[0]];  [self.industry1 setHidden:NO];
        self.industry2.text = [NSString stringWithFormat:@"  %@  ",industryNameArray[1]];  [self.industry2 setHidden:NO];
        [self.industry3 setHidden:YES];

    }else if (industryNameArray.count == 3) {
        self.industry1.text = [NSString stringWithFormat:@"  %@  ",industryNameArray[0]];;
        self.industry2.text = [NSString stringWithFormat:@"  %@  ",industryNameArray[1]];;
        self.industry3.text = [NSString stringWithFormat:@"  %@  ",industryNameArray[2]];;
        [self.industry1 setHidden:NO];
        [self.industry2 setHidden:NO];
        [self.industry3 setHidden:NO];
    }else{
        [self.industry1 setHidden:YES];
        [self.industry2 setHidden:YES];
        [self.industry3 setHidden:YES];
    }
    
    if (model.city_cityName) {
        self.cityLab.text = model.city_cityName;
    }else{
        self.cityLab.text = @"不限";

    }
    
    [self addSubview:self.gradeView];
    _gradeView.gradeStr = model.user_reputation;
    [_gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_right);
        make.centerY.mas_equalTo(self.nameLab);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(18);
    }];
//    self.labs.text = [NSString stringWithFormat:@" %@   ",industryStr];
}

-(void)tapIconAction{

    if (_delegate && [_delegate respondsToSelector:@selector(clickHeaderActionWithImageView:)]) {
        [_delegate clickHeaderActionWithImageView:self.iconImg];
    }
    
}

-(JMGradeView *)gradeView{
    if (_gradeView == nil) {
        _gradeView =  [[JMGradeView alloc]init];
    }
    return _gradeView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
