//
//  JMGoodsDescriptionViewController.h
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMGoodsDescriptionViewControllerDelegate <NSObject>

-(void)didWriteGoodsDescWithGoodsName:(NSString *)goodsName price:(NSString *)price goodsDetaolInfo:(NSString *)goodsDetaolInfo;

@end
@interface JMGoodsDescriptionViewController : BaseViewController
@property(nonatomic ,weak)id<JMGoodsDescriptionViewControllerDelegate>delegate;

@property (copy, nonatomic)NSString *goods_title;//商品标题
@property (copy, nonatomic)NSString *goods_price;//商品价格
@property (copy, nonatomic)NSString *goods_desc;//产品描述

@end

NS_ASSUME_NONNULL_END
