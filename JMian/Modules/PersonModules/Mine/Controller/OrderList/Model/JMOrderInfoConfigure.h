//
//  JMOrderInfoConfigure.h
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMOrderInfoHeaderTableViewCell.h"
#import "JMOrderInfoAdressTableViewCell.h"
#import "JMGoodsInfoTableViewCell.h"
#import "JMOrderInfoPriceTableViewCell.h"
#import "JMOrderInfoTimeMsgTableViewCell.h"
#import "JMOderInfoBtnTableViewCell.h"
#import "JMOrderInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMMyStoreCellType){
    JMOrderInfoTypeTitleHeader = 0 ,
    JMOrderInfoTypeAdress ,
    JMOrderInfoTypeGoodsList ,
    JMOrderInfoTypePrice ,
    JMOrderInfoTypeTimeMsg ,
    JMOrderInfoTypeBtn,
};
@interface JMOrderInfoConfigure : NSObject

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat footerheight;

@property (assign, nonatomic) NSInteger rowsNum;
@property (assign, nonatomic) NSInteger section;
@property (copy, nonatomic) NSString *cellId;
@property (strong, nonatomic) JMOrderInfoModel *model;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (UIView *)headerViewInSection:(NSInteger)section;

- (CGFloat)heightForRowsInSection:(NSInteger)section;

- (NSString *)cellIdForSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
