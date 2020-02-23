//
//  JMShopHomeConfigures.h
//  JMian
//
//  Created by mac on 2020/2/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMCSaleTypeDetailGoodsTableViewCell.h"
#import "JMShopHomeHeaderTableViewCell.h"
#import "JMShopInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMMyStoreCellType){
    JMShopHomeTypeTitleHeader = 0 ,
    JMShopHomeTypeGoodsList,
  
};

@interface JMShopHomeConfigures : NSObject

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat footerheight;

@property (assign, nonatomic) NSInteger rowsNum;
@property (assign, nonatomic) NSInteger section;
@property (copy, nonatomic) NSString *cellId;
@property (nonatomic, strong) NSArray *goodsListArray;
@property (nonatomic, strong) JMShopInfoModel *model;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (UIView *)headerViewInSection:(NSInteger)section;

- (CGFloat)heightForRowsInSection:(NSInteger)section;

- (NSString *)cellIdForSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
