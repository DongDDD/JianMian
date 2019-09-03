//
//  JMComDetailCellConfigures.h
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMComDetailHeaderTableViewCell.h"
#import "JMComDetailContentTableViewCell.h"
#import "JMScrollviewTableViewCell.h"
#import "JMMapTableViewCell.h"
#import "JMComDetailVideoTableViewCell.h"
#import "JMCompanyInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JMComDetailCellConfigures : NSObject

//- (NSInteger)numberOfRowsInSection:(NSInteger)section;

//- (CGFloat)heightForFooterInSection:(NSInteger)section;

//- (UIView *)footerViewInSection:(NSInteger)section;
//- (UIView *)headerViewInSection:(NSInteger)section;
@property(nonatomic,strong)JMCompanyInfoModel *model;

- (CGFloat)heightForRowsInSection:(NSIndexPath *)indexPath;

//- (NSString *)cellIdForSection:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
