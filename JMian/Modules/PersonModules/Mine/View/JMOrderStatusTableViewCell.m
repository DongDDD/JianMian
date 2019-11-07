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
//@property (weak, nonatomic) IBOutlet UIImageView *detailImg;//详情按钮右面箭头
@property (weak, nonatomic) IBOutlet UIButton *logisticsNumBtn;

//@property (nonatomic, strong)UIView *detailContentView;//快递
//@property (nonatomic, strong)UIImageView *cpImage;//复制图标

@property (weak, nonatomic) IBOutlet UIView *contactBGView;
@property (weak, nonatomic) IBOutlet UIView *remakeDetailBGView;
@property (weak, nonatomic) IBOutlet UILabel *orderRemakeLab;//订单备注
@property (weak, nonatomic) IBOutlet UIButton *rightTopBtn;
@property (weak, nonatomic) IBOutlet UIImageView *didSendGoodsImageView;


@property (nonatomic, strong)JMOrderCellData *myData;
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
//        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
//        if ([userModel.type isEqualToString:B_Type_UESR]) {
//            [self.deliverGoodsBtn setHidden:YES];
//
//        }else if ([userModel.type isEqualToString:C_Type_USER]){
//            [self.deliverGoodsBtn setHidden:NO];
//
//
//        }
        
    }
    return self;
}
 //0:已下单 1:已取消 2:已支付(未发货) 3:已发货
-(void)setOrderCellData:(JMOrderCellData *)orderCellData{
    _myData = orderCellData;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    //详情展开判断
    if (orderCellData.isSpread == YES) {
        [self.remakeDetailBGView setHidden:NO];
    }else{
        [self.remakeDetailBGView setHidden:YES];
    }
    //获取产品第一张图片
    JMSnapshotImageModel *imgModel = orderCellData.snapshot_images[0];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imgModel.file_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.infoLab2.text = [NSString stringWithFormat:@"¥ %@",orderCellData.goods_price];
    self.infoLab3.text = [NSString stringWithFormat:@"X %@",orderCellData.buy_quantity];
    //------是否有物流信息，有则已发货

    if (orderCellData.logistics_name) {
        [self.rightTopBtn setHidden:YES];
        [self.didSendGoodsImageView setHidden:NO];
//        [self.deliverGoodsBtn setTitle:@"已发货" forState:UIControlStateNormal];
//        [self.deliverGoodsBtn setEnabled:NO];
        NSString *logisticsInfo = [NSString stringWithFormat:@"%@:%@",orderCellData.logistics_name,orderCellData.logistics_no];
        [self.logisticsNumBtn setTitle:logisticsInfo forState:UIControlStateNormal];

    }else if ([orderCellData.status isEqualToString:@"0"]) {
        [self.rightTopBtn setHidden:NO];
        [self.rightTopBtn setTitle:@"未付款" forState:UIControlStateNormal];
        [self.didSendGoodsImageView setHidden:YES];
        [self.rightTopBtn setEnabled:NO];
        
    }else if ([orderCellData.status isEqualToString:@"2"]) {
        //已付款,未发货
        NSString *rightTopBtnTitle;
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            //商家
            if ([orderCellData.boss_user_id isEqualToString:userModel.user_id]) {
                [self.rightTopBtn setHidden:YES];
                [self.rightTopBtn setEnabled:NO];
            }else{
                rightTopBtnTitle = @"已付款,去发货";
                [self.rightTopBtn setEnabled:YES];
                
            }

        }else if ([userModel.type isEqualToString:C_Type_USER]){
            //任务接受者或消费者
            rightTopBtnTitle = @"已付款，待发货";
            [self.rightTopBtn setEnabled:NO];

        }

        [self.rightTopBtn setTitle:rightTopBtnTitle forState:UIControlStateNormal];
        [self.rightTopBtn setHidden:NO];
        [self.didSendGoodsImageView setHidden:YES];
        
    }
 
    
    self.orderRemakeLab.text = orderCellData.remark;//---备注
    self.nameLab.text = orderCellData.contact_name;//---联系人
    self.phoneNumLab.text = orderCellData.contact_phone;//---联系电话
    //地址获取
    NSMutableArray *adrArr = [NSMutableArray array];
    for (NSString *str in orderCellData.city_name_relation) {
        [adrArr addObject:str];
    }
    NSString *adrStr = [adrArr componentsJoinedByString:@""];
    NSString *adrStr2 = [NSString stringWithFormat:@"%@%@",adrStr,orderCellData.city_city_name];
    NSString *adrStr3 = [NSString stringWithFormat:@"%@%@",adrStr2,orderCellData.contact_address];
    self.adressLab.text = adrStr3;
    
    
    //订单状态
    if ([userModel.type isEqualToString: B_Type_UESR]) {
        NSString *str = [NSString stringWithFormat:@"销售：%@ >",orderCellData.referrer_nickname];
        [self.titleBtn setTitle:str forState:UIControlStateNormal];
        self.infoLab1.text = orderCellData.title;
//        if ([orderCellData.status isEqualToString:@"2"]) {
//            [self.rightTopBtn setHidden:NO];
//            [self.didSendGoodsImageView setHidden:YES];
//            [self.rightTopBtn setTitle:@"已付款,去发货" forState:UIControlStateNormal];
//            [self.rightTopBtn setEnabled:YES];
//        }
        //        if (orderCellData.logistics_label_id) {
        //            [self.deliverGoodsBtn setHidden:YES];
//            [self.deliverGoodsBtn setTitle:@"已发货" forState:UIControlStateNormal];
//            [self.deiveredImageView setHidden:NO];
//            [self.deliverGoodsBtn setEnabled:NO];
//
//        }else if ([orderCellData.status isEqualToString:@"2"]) {
//            [self.deliverGoodsBtn setHidden:NO];
//            [self.deliverGoodsBtn setTitle:@"去发货" forState:UIControlStateNormal];
//            [self.deiveredImageView setHidden:YES];
//            [self.deliverGoodsBtn setEnabled:YES];
//
//        }else if ([orderCellData.status isEqualToString:@"0"]) {
//            [self.deliverGoodsBtn setHidden:NO];
//            [self.deliverGoodsBtn setTitle:@"未付款" forState:UIControlStateNormal];
//            [self.deiveredImageView setHidden:YES];
//            [self.deliverGoodsBtn setEnabled:NO];
//
//        }

    }else if ([userModel.type isEqualToString: C_Type_USER]){
        NSString *str = [NSString stringWithFormat:@"%@ >",orderCellData.snapshot_company_company_name];
        [self.titleBtn setTitle:str forState:UIControlStateNormal];
        self.infoLab1.text = orderCellData.snapshot_goods_goods_title;
        
    }

    
}


//-(void)initView{
//    _detailContentView = [[UIView alloc]init];
//    _detailContentView.backgroundColor = [UIColor redColor];
//    [self addSubview:_detailContentView];
//
//    _expressBtn = [[UIButton alloc]init];
//    [_expressBtn setTitle:@"顺丰快递 68411321654684" forState:UIControlStateNormal];
//    [_expressBtn sizeToFit];
//    [_expressBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
//    _expressBtn.titleLabel.font = kFont(13);
//    [_detailContentView addSubview:_expressBtn];
//
//    _cpImage = [[UIImageView alloc]init];
//    _cpImage.image = [UIImage imageNamed:@"order_cp"];
//    [_detailContentView addSubview:_cpImage];
//
//    _remarkLab = [[UILabel alloc]init];
//    _remarkLab.text = @"麻烦老板给我发一个黑色的和一个白色的，还要一个红色的 谢谢老板";
//    _remarkLab.numberOfLines = 0;
//    _remarkLab.font = kFont(13);
//    _remarkLab.textColor = TEXT_GRAY_COLOR;
//    [_detailContentView addSubview:_remarkLab];
//}

//-(void)initLayout{
//    [_detailContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self);
//        make.centerX.mas_equalTo(self);
//        make.height.mas_equalTo(100);
//        make.bottom.mas_equalTo(_contactBGView.mas_top);
//    }];
//
//
//    [_expressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(12);
//        make.left.mas_equalTo(_iconImageView);
//        make.height.mas_equalTo(13);
//    }];
//    [_cpImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_expressBtn.mas_right).offset(10);
//        make.centerY.mas_equalTo(_expressBtn);
//        make.height.and.width.mas_equalTo(13);
//    }];
//
//    [_remarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self).offset(20);
//        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(37);
//        make.left.mas_equalTo(self).offset(20);
//        make.right.mas_equalTo(self).offset(-20);
//        make.height.mas_equalTo(40);
//    }];
//
//
//
//
//}

- (IBAction)detailSpreadAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(didClickDetail_isSpread:indexPath:)]) {
        [_delegate didClickDetail_isSpread:sender.selected indexPath:_indexPath];
    }
}

- (IBAction)deliverGoodsAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickDeliverGoodsWithData:)]) {
        [_delegate didClickDeliverGoodsWithData:_myData];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
