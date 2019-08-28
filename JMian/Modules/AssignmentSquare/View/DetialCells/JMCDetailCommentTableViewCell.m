//
//  JMCDetailCommentTableViewCell.m
//  JMian
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailCommentTableViewCell.h"
#import "DimensMacros.h"
#import "JMGradeView.h"
NSString *const JMCDetailCommentTableViewCellIdentifier = @"JMCDetailCommentTableViewCellIdentifier";

@interface JMCDetailCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerAvart;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (nonatomic, strong)JMGradeView *gradeView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *reputation;

@end

@implementation JMCDetailCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)prepareForReuse{
    [super prepareForReuse];
    [self.gradeView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

-(void)setData:(JMCommentCellData *)data{
    [self.headerAvart sd_setImageWithURL:[NSURL URLWithString:data.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.titleLab.text = data.user_nickname;
    self.subTitleLab.text = [NSString stringWithFormat:@"任务：%@",data.task_title];
    [self.textView setText:data.myDescription];
    
    [self addSubview:self.gradeView];
    self.gradeView.gradeStr = data.user_reputation;
    [self.gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right);
        make.centerY.mas_equalTo(self.titleLab);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(18);
    }];
    self.reputation.text = [NSString stringWithFormat:@"%@分",data.reputation];
//    self.subTitleLab.text = data.u

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
