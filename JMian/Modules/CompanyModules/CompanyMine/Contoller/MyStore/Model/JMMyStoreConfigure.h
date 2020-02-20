//
//  JMMyStoreConfigure.h
//  JMian
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMMyStoreTitleHeaderTableViewCell.h"
#import "JMMyStoreOrderStatusTableViewCell.h"
#import "JMMyStoreManager1TableViewCell.h"
#import "JMMyStoreManager2TableViewCell.h"
#import "JMShopInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMMyStoreCellType){
    JMMyStoreTypeTitleHeader = 0 ,
    JMMyStoreTypeOrderStatus,
    JMMyStoreTypeOrderManager1,
    JMMyStoreTypeOrderManager2,
};

@interface JMMyStoreConfigure : NSObject
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat footerheight;

@property (assign, nonatomic) NSInteger rowsNum;
@property (assign, nonatomic) NSInteger section;
@property (copy, nonatomic) NSString *cellId;
@property (strong, nonatomic) JMShopInfoModel *model;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (UIView *)headerViewInSection:(NSInteger)section;

- (CGFloat)heightForRowsInSection:(NSInteger)section;

- (NSString *)cellIdForSection:(NSInteger)section;


- (void)didSelectedRowAtSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
