//
//  JMPostProductConfigures.h
//  JMian
//
//  Created by mac on 2020/1/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMPostProductHeaderTableViewCell.h"
#import "JMPostProductParamTableViewCell.h"
#import "JMPostProductDescTableViewCell.h"
#import "JMPostProductBottomBtnTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,  JMPostProductCellType){
    JMPostProductTypeHeader = 0 ,
    JMPostProductTypeParam,
    JMPostProductTypeDesc,
    JMPostProductTypePostBtn,
};

@interface JMPostProductConfigures : NSObject

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat footerheight;

@property (assign, nonatomic) NSInteger rowsNum;
@property (assign, nonatomic) NSInteger section;
@property (copy, nonatomic) NSString *cellId;
//@property(nonatomic,strong)NSArray *jobListArr;
@property(nonatomic,strong)NSArray *taskListArr;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (UIView *)headerViewInSection:(NSInteger)section;

- (CGFloat)heightForRowsInSection:(NSInteger)section;

- (NSString *)cellIdForSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
