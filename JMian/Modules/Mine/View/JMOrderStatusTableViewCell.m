//
//  JMOrderStatusTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMOrderStatusTableViewCell.h"
#import "DimensMacros.h"
@interface JMOrderStatusTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *headerIconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLab;
@property (weak, nonatomic) IBOutlet UILabel *adressLab;
@property (weak, nonatomic) IBOutlet UIImageView *detailImg;//详情按钮右面箭头

@property (nonatomic, strong)UIView *detailContentView;//快递
@property (nonatomic, strong)UIButton *expressBtn;//快递
@property (nonatomic, strong)UIImageView *cpImage;
@property (nonatomic, strong)UILabel *remarkLab;//订单备注

@end

@implementation JMOrderStatusTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        [self initView];
        [self initLayout];
        
    }
    return self;
}

-(void)setOrderCellData:(JMOrderCellData *)orderCellData{
    if (orderCellData.isSpread == YES) {
//        [self.detailContentView setHidden:NO];
//        CGRect Frame = self.nameLab.frame;
//        //JMOrderCellData给高度
//        Frame.origin.y = 100;
//        self.nameLab.frame = Frame;
    }else{
//        CGRect Frame = self.nameLab.frame;
//        //JMOrderCellData给高度
//        Frame.origin.y = 35;
//        self.nameLab.frame = Frame;
//        [self.detailContentView setHidden:YES];
    }
    
    
}



-(void)initView{
    _detailContentView = [[UIView alloc]init];
    [self addSubview:_detailContentView];
    
    _expressBtn = [[UIButton alloc]init];
    [_expressBtn setTitle:@"顺丰快递 68411321654684" forState:UIControlStateNormal];
    [_expressBtn sizeToFit];
    [_expressBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    _expressBtn.titleLabel.font = kFont(13);
    [_detailContentView addSubview:_expressBtn];
    
    _cpImage = [[UIImageView alloc]init];
    _cpImage.image = [UIImage imageNamed:@"order_cp"];
    [_detailContentView addSubview:_cpImage];
    
    _remarkLab = [[UILabel alloc]init];
    _remarkLab.text = @"麻烦老板给我发一个黑色的和一个白色的，还要一个红色的 谢谢老板";
    _remarkLab.numberOfLines = 0;
    _remarkLab.font = kFont(13);
    _remarkLab.textColor = TEXT_GRAY_COLOR;
    [_detailContentView addSubview:_remarkLab];
}

-(void)initLayout{
    [_detailContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(_headerIconBtn.mas_bottom);
    }];
    
    
    [_expressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headerIconBtn.mas_bottom).offset(12);
        make.left.mas_equalTo(_headerIconBtn);
        make.height.mas_equalTo(13);
    }];
    [_cpImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_expressBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(_expressBtn);
        make.height.and.width.mas_equalTo(13);
    }];
    
    [_remarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(_headerIconBtn.mas_bottom).offset(37);
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_remarkLab.mas_bottom).offset(25);
        make.left.mas_equalTo(self).offset(43);
    }];
    
    
    
}

- (IBAction)detailSpreadAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(didClickDetail_isSpread:indexPath:)]) {
        [_delegate didClickDetail_isSpread:sender.selected indexPath:_indexPath];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
