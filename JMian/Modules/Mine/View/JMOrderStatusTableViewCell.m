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
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;//销售名称or公司名称
@property (weak, nonatomic) IBOutlet UILabel *infoLab1;//商品名称
@property (weak, nonatomic) IBOutlet UILabel *infoLab2;//价格
@property (weak, nonatomic) IBOutlet UILabel *infoLab3;//购买数量

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;//商品头像
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//收货人姓名
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLab;//收货人电话
@property (weak, nonatomic) IBOutlet UILabel *adressLab;//收货地址
@property (weak, nonatomic) IBOutlet UIImageView *detailImg;//详情按钮右面箭头

@property (nonatomic, strong)UIView *detailContentView;//快递
@property (nonatomic, strong)UIButton *expressBtn;//快递
@property (nonatomic, strong)UIImageView *cpImage;//复制图标
@property (nonatomic, strong)UILabel *remarkLab;//订单备注
@property (weak, nonatomic) IBOutlet UIView *contactBGView;
@property (weak, nonatomic) IBOutlet UIView *remakeDetailBGView;

@end

@implementation JMOrderStatusTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
//        [self initView];
//        [self initLayout];
        
    }
    return self;
}

-(void)setOrderCellData:(JMOrderCellData *)orderCellData{
    if (orderCellData.isSpread == YES) {
        [self.remakeDetailBGView setHidden:NO];
    }else{
        [self.remakeDetailBGView setHidden:YES];
    }
    
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString: B_Type_UESR]) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:orderCellData.referrer_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        NSString *str = [NSString stringWithFormat:@"销售：%@ >",orderCellData.referrer_nickname];
        [self.titleBtn setTitle:str forState:UIControlStateNormal];
        self.infoLab1.text = orderCellData.title;
        self.infoLab2.text = [NSString stringWithFormat:@"¥ %@",orderCellData.goods_price];
        self.infoLab3.text = [NSString stringWithFormat:@"X %@",orderCellData.buy_quantity];
        self.remarkLab.text = orderCellData.remark;
        self.nameLab.text = orderCellData.contact_name;
        self.phoneNumLab.text = orderCellData.contact_phone;
        self.adressLab.text = orderCellData.contact_address;
    }else{
        
        
    }
    
    
    
}



-(void)initView{
    _detailContentView = [[UIView alloc]init];
    _detailContentView.backgroundColor = [UIColor redColor];
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
        make.bottom.mas_equalTo(_contactBGView.mas_top);
    }];
    
    
    [_expressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(12);
        make.left.mas_equalTo(_iconImageView);
        make.height.mas_equalTo(13);
    }];
    [_cpImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_expressBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(_expressBtn);
        make.height.and.width.mas_equalTo(13);
    }];
    
    [_remarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(37);
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.height.mas_equalTo(40);
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
