//
//  JMBUserSquareTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserSquareTableViewCell.h"
#import "DimensMacros.h"
#import "JMGradeView.h"
@interface JMBUserSquareTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerIconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *jobLabs;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, strong)JMGradeView *gradeView;
@property (nonatomic, strong)JMAbilityCellData *myModel;

@end

@implementation JMBUserSquareTableViewCell

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
-(void)setModel:(JMAbilityCellData *)model{
    _myModel = model;
    
    NSMutableArray *industryNameArray = [NSMutableArray array];
    for (JMIndustryModel *data in model.industry) {
        [industryNameArray addObject:data.name];
    }
    NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
    self.titleLab.text = industryStr;
    self.nameLab.text = model.user_nickname;
    self.adress.text = model.city_cityName;
    [self.headerIconImg sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    self.jobLabs.text = [NSString stringWithFormat:@" %@  ",model.myDescription];
    [self addSubview:self.gradeView];
    _gradeView.gradeStr = _myModel.user_reputation;
    [_gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.nameLab);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(18);
    }];
  
}

//-(void)initGradeView{
//    _gradeView =  [[JMGradeView alloc]initWithFrame:CGRectMake(self.nameLab.frame.origin.x+self.nameLab.frame.size.width + 5, 100, 200, 18)];
//    _gradeView.gradeStr = _myModel.user_reputation;
//    [self addSubview:_gradeView];
//    [_gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.nameLab.mas_right).mas_offset(5);
//        make.centerY.mas_equalTo(self.nameLab);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(18);
//    }];
//
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(JMGradeView *)gradeView{
    if (_gradeView == nil) {
        _gradeView =  [[JMGradeView alloc]initWithFrame:CGRectMake(self.nameLab.frame.origin.x+self.nameLab.frame.size.width + 5, 100, 200, 18)];
    }
    return _gradeView;
}


@end
