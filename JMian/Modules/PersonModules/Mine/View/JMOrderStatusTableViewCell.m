//
//  JMOrderStatusTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMOrderStatusTableViewCell.h"
#import "DimensMacros.h"
#import "JMGoodsListView.h"
@interface JMOrderStatusTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;//销售名称or公司名称
//@property (weak, nonatomic) IBOutlet UILabel *infoLab1;//商品名称
//@property (weak, nonatomic) IBOutlet UILabel *infoLab2;//价格
//@property (weak, nonatomic) IBOutlet UILabel *infoLab3;//购买数量

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;//商品头像
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//收货人姓名
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLab;//收货人电话
@property (weak, nonatomic) IBOutlet UILabel *adressLab;//收货地址
//@property (weak, nonatomic) IBOutlet UIImageView *detailImg;//详情按钮右面箭头
@property (weak, nonatomic) IBOutlet UIButton *logisticsNumBtn;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *comfirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderBtn;

//@property (nonatomic, strong)UIView *detailContentView;//快递
//@property (nonatomic, strong)UIImageView *cpImage;//复制图标

@property (weak, nonatomic) IBOutlet UIView *contactBGView;
@property (weak, nonatomic) IBOutlet UIView *remakeDetailBGView;
@property (weak, nonatomic) IBOutlet UILabel *orderRemakeLab;//订单备注
@property (weak, nonatomic) IBOutlet UIButton *statusRightTopLab;
@property (weak, nonatomic) IBOutlet UIImageView *didSendGoodsImageView;
@property (weak, nonatomic) IBOutlet UIStackView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewH;
@property(nonatomic,strong)JMGoodsListView *goodsView;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
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

 //0:已下单 1:已取消 2:已支付(未发货) 3:卖家已接单 4申请取消 5拒绝取消 6卖家已发货 7申请退款 8等待退货 9拒绝退款 10卖家已发货 11订单已退款 12买家已收货 13订单已完成
-(void)setOrderCellData:(JMOrderCellData *)orderCellData{
    _myData = orderCellData;
    self.goodsView.goods = orderCellData.goods;
    [self.contentView addSubview:self.goodsView];
    if (orderCellData.isSpread == YES) {
        [self.remakeDetailBGView setHidden:NO];
    }else{
        [self.remakeDetailBGView setHidden:YES];
    }
    [self initLayout];
    //赋值
    [self setValues];
   
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    //详情展开判断

    //------是否有物流信息，有则已发货

    if (orderCellData.logistics_name) {
//        [self.rightTopBtn setHidden:YES];
//        [self.didSendGoodsImageView setHidden:NO];
////        [self.deliverGoodsBtn setTitle:@"已发货" forState:UIControlStateNormal];
////        [self.deliverGoodsBtn setEnabled:NO];
        NSString *logisticsInfo = [NSString stringWithFormat:@"%@:%@",orderCellData.logistics_name,orderCellData.logistics_no];
        [self.logisticsNumBtn setTitle:logisticsInfo forState:UIControlStateNormal];
//
        }
   
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        [self setB_StatusBtn];
        [self.storeImage setHidden:YES];
        [self.titleBtn setHidden:YES];
    }else{
        [self setC_StatusBtn];
    }

    
    
    
}

-(void)setValues{
    //获取产一张图片
    JMSnapshotImageModel *imgModel = _myData.snapshot_images[0];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imgModel.file_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
//    self.infoLab2.text = [NSString stringWithFormat:@"¥ %@",_myData.order_amount];
//    self.infoLab3.text = [NSString stringWithFormat:@"X %@",@"1"];
    self.orderRemakeLab.text = _myData.remark;//---备注
    self.nameLab.text = _myData.contact_name;//---联系人
    self.phoneNumLab.text = _myData.contact_phone;//---联系电话
    //地址获取
    NSMutableArray *adrArr = [NSMutableArray array];
    for (NSString *str in _myData.city_name_relation) {
        [adrArr addObject:str];
    }
    //    NSString *adrStr = [adrArr componentsJoinedByString:@""];
    //    NSString *adrStr2 = [NSString stringWithFormat:@"%@%@",adrStr,orderCellData.city_city_name];
    NSString *adrStr3 = [NSString stringWithFormat:@"%@",_myData.contact_address];
    self.adressLab.text = adrStr3;
    
    NSString *str = [NSString stringWithFormat:@"%@ >",_myData.shop_shop_name];
    [self.titleBtn setTitle:str forState:UIControlStateNormal];
//    self.infoLab1.text = _myData.snapshot_goods_goods_title;
    
}

-(void)initLayout{
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsView.mas_bottom);
        make.right.mas_equalTo(self).offset(-20);
        make.height.mas_equalTo(40);
    }];
    [self.remakeDetailBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailBtn.mas_bottom);
        make.left.right.mas_equalTo(self.goodsView);
        make.height.mas_equalTo(60);
    }];
    [self.contactBGView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.remakeDetailBGView.mas_bottom);
        make.height.mas_equalTo(51);
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.contentView).offset(-self.bottomViewH.constant);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contactBGView.mas_bottom);
        make.right.mas_equalTo(self).offset(-20);
        make.bottom.mas_equalTo(self).offset(-5);
    }];
    
}

- (IBAction)bottomBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickBottomBtnActionWithTag:data:)]) {
        [_delegate didClickBottomBtnActionWithTag:sender.tag data:self.myData];
    }
}

-(void)setB_StatusBtn{
    [self.bottomView setHidden:YES];
     self.bottomViewH.constant = 0;
     [self.statusRightTopLab setTitleColor:MASTER_COLOR forState:UIControlStateNormal];

    if ([_myData.status isEqualToString:@"7"]) {
        [self.statusRightTopLab setTitle:@"对方发起退款" forState:UIControlStateNormal];
        [self.statusRightTopLab setEnabled:NO];
        [self.statusRightTopLab setHidden:NO];
    } else if ([_myData.status isEqualToString:@"8"]) {
        [self.statusRightTopLab setTitle:@"等待退货" forState:UIControlStateNormal];
        [self.statusRightTopLab setEnabled:NO];
        [self.statusRightTopLab setHidden:NO];
        
    } else if ([_myData.status isEqualToString:@"11"]) {
             [self.statusRightTopLab setTitle:@"已退款" forState:UIControlStateNormal];
        [self.statusRightTopLab setEnabled:NO];
        [self.statusRightTopLab setHidden:NO];
        
    } else if ([_myData.status isEqualToString:@"2"]) {
        [self.statusRightTopLab setTitle:@"去发货" forState:UIControlStateNormal];
        [self.statusRightTopLab setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [self.statusRightTopLab setEnabled:YES];
        [self.statusRightTopLab setHidden:NO];
        
    } else if ([_myData.status isEqualToString:@"0"]) {
        [self.statusRightTopLab setTitle:@"未付款" forState:UIControlStateNormal];
        [self.statusRightTopLab setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [self.statusRightTopLab setEnabled:NO];
        [self.statusRightTopLab setHidden:NO];
        
    }
    
}
-(void)setC_StatusBtn{
       //已下单
        if ([_myData.status isEqualToString:@"0"]) {
            [self.cancelOrderBtn setHidden:NO];
            [self.statusRightTopLab setHidden:NO];
            [self.statusRightTopLab setTitle:@"未付款" forState:UIControlStateNormal];
            [self.didSendGoodsImageView setHidden:YES];
            [self.statusRightTopLab setEnabled:NO];
            [self.contactBtn setHidden:NO];
            [self.comfirmBtn setHidden:YES];
            [self.payBtn setHidden:NO];
        }else if ([_myData.status isEqualToString:@"2"] || [_myData.status isEqualToString:@"6"]) {
            if ([_myData.status isEqualToString:@"2"]) {
                [self.cancelOrderBtn setHidden:NO];
                [self.comfirmBtn setHidden:YES];
                [self.didSendGoodsImageView setHidden:YES];

            }else{
                [self.comfirmBtn setHidden:NO];
                [self.cancelOrderBtn setHidden:YES];
                [self.didSendGoodsImageView setHidden:NO];
            }
            [self.contactBtn setHidden:NO];
            [self.payBtn setHidden:YES];

            [self.statusRightTopLab setTitle:@"" forState:UIControlStateNormal];
            [self.statusRightTopLab setHidden:NO];
            
        }else if ([_myData.status isEqualToString:@"12"]) {
            [self.didSendGoodsImageView setHidden:YES];
            [self.cancelOrderBtn setHidden:YES];
            [self.contactBtn setHidden:NO];
            [self.comfirmBtn setHidden:YES];
            [self.payBtn setHidden:YES];
            //确认收货后
            [self.statusRightTopLab setTitle:@"已收货" forState:UIControlStateNormal];
            [self.statusRightTopLab setEnabled:NO];
            [self.statusRightTopLab setHidden:NO];

            
        }else if ([_myData.status isEqualToString:@"1"]) {
            [self.cancelOrderBtn setHidden:YES];
            [self.contactBtn setHidden:NO];
            [self.comfirmBtn setHidden:YES];
            [self.payBtn setHidden:YES];
            [self.statusRightTopLab setTitle:@"订单已取消" forState:UIControlStateNormal];
            [self.statusRightTopLab setEnabled:NO];
            [self.statusRightTopLab setHidden:NO];
            [self.didSendGoodsImageView setHidden:YES];

        }else if ([_myData.status isEqualToString:@"11"]) {
              //订单已退款
            [self.cancelOrderBtn setHidden:YES];
            [self.contactBtn setHidden:NO];
            [self.comfirmBtn setHidden:YES];
            [self.payBtn setHidden:YES];
            [self.statusRightTopLab setTitle:@"订单已退款" forState:UIControlStateNormal];
            [self.statusRightTopLab setEnabled:NO];
            [self.statusRightTopLab setHidden:NO];
            [self.didSendGoodsImageView setHidden:YES];

        }else if ([_myData.status isEqualToString:@"7"]) {
            //申请退款中
            [self.cancelOrderBtn setHidden:YES];
            [self.contactBtn setHidden:NO];
            [self.comfirmBtn setHidden:YES];
            [self.payBtn setHidden:YES];
            [self.statusRightTopLab setTitle:@"售后中" forState:UIControlStateNormal];
            [self.statusRightTopLab setEnabled:NO];
            [self.statusRightTopLab setHidden:NO];
            [self.didSendGoodsImageView setHidden:YES];

        }else if ([_myData.status isEqualToString:@"9"]) {
            //卖家拒绝退款
            [self.cancelOrderBtn setHidden:YES];
            [self.contactBtn setHidden:NO];
            [self.comfirmBtn setHidden:YES];
            [self.payBtn setHidden:YES];
            [self.statusRightTopLab setTitle:@"卖家拒绝退款" forState:UIControlStateNormal];
            [self.statusRightTopLab setEnabled:NO];
            [self.statusRightTopLab setHidden:NO];
            [self.didSendGoodsImageView setHidden:YES];

        }else if ([_myData.status isEqualToString:@"8"]) {
            //等待退货
            [self.didSendGoodsImageView setHidden:YES];

            [self.cancelOrderBtn setHidden:YES];
            [self.contactBtn setHidden:NO];
            [self.comfirmBtn setHidden:YES];
            [self.payBtn setHidden:YES];
            [self.statusRightTopLab setTitle:@"等待退货" forState:UIControlStateNormal];
            [self.statusRightTopLab setEnabled:NO];
            [self.statusRightTopLab setHidden:NO];
            
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

-(JMGoodsListView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[JMGoodsListView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, self.myData.goods.count*60)];
    }
    return _goodsView;
    
}

@end
