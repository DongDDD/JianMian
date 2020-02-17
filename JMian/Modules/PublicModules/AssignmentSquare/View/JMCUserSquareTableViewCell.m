//
//  JMCUserSquareTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCUserSquareTableViewCell.h"
#import "DimensMacros.h"
#import "JMGradeView.h"

@interface JMCUserSquareTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerIconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *jobLabs;
@property (weak, nonatomic) IBOutlet UILabel *paymentLab;
@property (weak, nonatomic) IBOutlet UILabel *unitLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong)JMGradeView *gradeView;
@property (nonatomic, strong)JMTaskListCellData *myModel;

@end

@implementation JMCUserSquareTableViewCell
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

-(void)setModel:(JMTaskListCellData *)model{
    _myModel = model;
    [self.headerIconImg sd_setImageWithURL:[NSURL URLWithString:model.companyLogo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];

    self.titleLab.text = model.task_title;
    
    if (model.cityName == nil) {
        self.adress.text = @"不限地区";
    }else{
        self.adress.text = model.cityName;
    }
    
    if ([model.front_money isEqualToString:@"0"]) {
        self.jobLabs.text = @"无定金";
    }else{
        self.jobLabs.text = @"有定金";

    }
    if ([model.payment_method isEqualToString:@"1"]) {
        NSMutableArray *arr = [NSMutableArray array];
        if (model.goods.count > 0) {
            for (JMGoodsData *data in model.goods) {
                [arr addObject:data.salary];
            }
            //最大值
            double max_value = [[arr valueForKeyPath:@"@max.doubleValue"] doubleValue];
            int max_value2 =  fabs(max_value);
            //最小值
            double min_value = [[arr valueForKeyPath:@"@min.doubleValue"] doubleValue];
            int min_value2 =  fabs(min_value);
            self.paymentLab.text = [NSString stringWithFormat:@"%d~%d",min_value2,max_value2];
            self.unitLab.text = @"元 / 单";
            [self.paymentLab setHidden:NO];
            [self.unitLab setHidden:NO];
        }else{
            [self.paymentLab setHidden:YES];
            [self.unitLab setHidden:YES];

        }
    }else{
        [self.paymentLab setHidden:NO];
        [self.unitLab setHidden:NO];
        self.paymentLab.text = model.payment_money;
        self.unitLab.text = model.unit;
        
    }
    
    [self addSubview:self.gradeView];
    _gradeView.gradeStr = _myModel.companyReputation;
    [_gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.adress.mas_left);
        make.bottom.mas_equalTo(self.adress.mas_top).offset(-3);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(18);
    }];
  
    
 

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
