//
//  JMTaskDetailHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskDetailHeaderTableViewCell.h"
#import "DimensMacros.h"
#import "JMGradeView.h"

NSString *const JMTaskDetailHeaderTableViewCellIdentifier = @"JMTaskDetailHeaderTableViewCellIdentifier";

@interface JMTaskDetailHeaderTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (nonatomic, strong)JMGradeView *gradeView;
@property (weak, nonatomic) IBOutlet UILabel *suTitleLab;

@end

@implementation JMTaskDetailHeaderTableViewCell

-(void)prepareForReuse{
    [super prepareForReuse];
    [self.gradeView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMCDetailModel *)model{
    [self.headerIcon sd_setImageWithURL:[NSURL URLWithString:model.company_logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.titleLab.text = model.company_company_name;
    
    [self addSubview:self.gradeView];
    _gradeView.gradeStr = model.company_reputation;
    [_gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.suTitleLab.mas_right);
        make.centerY.mas_equalTo(self.suTitleLab);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(18);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(JMGradeView *)gradeView{
    if (_gradeView == nil) {
        _gradeView =  [[JMGradeView alloc]init];
    }
    return _gradeView;
}
@end
