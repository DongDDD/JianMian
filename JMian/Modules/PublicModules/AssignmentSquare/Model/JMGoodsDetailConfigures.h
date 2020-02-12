//
//  JMGoodsDetailConfigures.h
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMScrollviewTableViewCell.h"
#import "JMGoodsDetialTitleTableViewCell.h"
#import "JMCDetailTaskDecri2TableViewCell.h"//商品介绍
#import "JMGoodsDescTableViewCell.h"
#import "JMCDetailVideoTableViewCell.h"
#import "JMCDetailImageTableViewCell.h"
#import "JMGoodsDetailMicrotitleTableViewCell.h"//小提示
#import "JMCSaleTypeDetailGoodsTableViewCell.h"//店铺商品
#import "JMGoodsDescTableViewCell.h"
#import "JMGoodsInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMGoodsDetailCellType){
    JMGoodsDetailCellTypeSDC = 0,
    JMGoodsDetailCellTypeTitle,
    JMGoodsDetailCellTypeVideo,
    JMGoodsDetailCellTypeDesc,
//    JMGoodsDetailCellTypeImages,
    JMGoodsDetailCellTypeMicrotitle,
    JMGoodsDetailCellTypeStoreGoods,


};

@interface JMGoodsDetailConfigures : NSObject

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat webViewHeight;

@property (assign, nonatomic) CGFloat footerheight;
@property (assign, nonatomic) CGFloat headerheight;

@property (assign, nonatomic) NSInteger rowsNum;
@property (assign, nonatomic) NSInteger section;
@property (copy, nonatomic) NSString *cellId;
@property (strong, nonatomic) JMGoodsInfoModel *model;
@property (strong, nonatomic) NSArray *goodsListArray;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (UIView *)headerViewInSection:(NSInteger)section;

- (CGFloat)heightForRowsInSection:(NSInteger)section;

- (NSString *)cellIdForSection:(NSInteger)section;


@end

NS_ASSUME_NONNULL_END
