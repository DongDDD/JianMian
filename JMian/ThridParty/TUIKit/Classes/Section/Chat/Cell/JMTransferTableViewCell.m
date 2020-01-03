//
//  JMTransferTableViewCell.m
//  JMian
//
//  Created by mac on 2019/12/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTransferTableViewCell.h"
#import "THeader.h"
#import "THelper.h"
#import "MMLayout/UIView+MMLayout.h"
#import "ReactiveObjC/ReactiveObjC.h"
#import "DimensMacros.h"
 

@implementation JMTransferTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        [self initLayout];
    }
    return self;
}

-(void)initView{
    _transferImg = [[UIImageView alloc] init];
    _transferImg.contentMode = UIViewContentModeScaleAspectFit;
    
    _money = [[UILabel alloc]init];
    _money.textColor = [UIColor whiteColor];
    _money.font = [UIFont systemFontOfSize:14];
    [_transferImg addSubview:_money];
    
    _symbolImg = [[UIImageView alloc] init];
    _symbolImg.image = [UIImage imageNamed:@"symbol-money"];
    _symbolImg.contentMode = UIViewContentModeScaleAspectFit;
    [_transferImg addSubview:_symbolImg];
        
    _remark = [[UILabel alloc]init];
    _remark.textColor = [UIColor whiteColor];
    _remark.font = [UIFont systemFontOfSize:14];
    [_transferImg addSubview:_remark];
    
    [self.container addSubview:_transferImg];
    //        _transferImg.mm_fill();
    _transferImg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tap];
//    self.transferImg.userInteractionEnabled = YES;
    
}

-(void)tapAction:(UIGestureRecognizer *)recognizer{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(onSelectMessage:)]) {
//        [self.delegate onSelectMessage:self];
//    }
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Transfer object:nil];

}

-(void)initLayout{
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_transferImg.mas_left).mas_offset(91);
        make.top.mas_equalTo(_transferImg.mas_centerY).mas_offset(-30);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(15);
    }];
        [_symbolImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_money.mas_left).mas_offset(-7);
            make.centerY.mas_equalTo(_money.mas_centerY);
    //        make.width.mas_equalTo(100);
    //        make.height.mas_equalTo(15);
        }];
    
    [_remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_symbolImg.mas_left);
        make.top.mas_equalTo(_transferImg.mas_centerY).mas_offset(-10);
    }];
    
    
}



-(void)fillWithData:(JMTransferMessageCellData *)data{
    [super fillWithData:data];
    self.transferData = data;
    NSString *str = [[NSString alloc] initWithData:data.data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [self dictionaryWithJsonString:str];
//    NSString *amount = dic[@"amount"];
    NSString *remark = dic[@"remark"];
  
    _money.text =  dic[@"amount"];
    if (![remark isEqual:[NSNull null]]) {
        if (remark.length > 0) {
            _remark.text = dic[@"remark"];
        }else{
            _remark.text = data.desc;
        }
         
    }

    if (data.direction == MsgDirectionIncoming) {
        _transferImg.image = [UIImage imageNamed:@"IM-turn-left"];
        _transferImg.frame = CGRectMake(0, 0, 239, 110);

    }else{
        _transferImg.frame = CGRectMake(-239, 0, 239, 110);
        _transferImg.image = [UIImage imageNamed:@"IM-turn-right"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
