//
//  JMBDetailCellConfigures.h
//  JMian
//
//  Created by mac on 2019/9/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMBDetailVideoTableViewCell.h"//个人视频简介
#import "JMBDetailHeaderInfoTableViewCell.h"//任务简历个人头部信息
#import "JMCDetailTaskDecri2TableViewCell.h"//自我介绍
#import "JMCDetailImageTableViewCell.h"//公司图片
#import "JMNoDataTableViewCell.h"//没有图片

#import "JMCDetailCommentTableViewCell.h"//接单记录
#import "JMBDetailModel.h"
#import "JMCommentCellData.h"
NS_ASSUME_NONNULL_BEGIN

@interface JMBDetailCellConfigures : NSObject

@property (strong, nonatomic) JMBDetailModel *model;
@property (strong, nonatomic) NSArray *commentListArray;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

//- (UIView *)footerViewInSection:(NSInteger)section;
- (UIView *)headerViewInSection:(NSInteger)section;


- (CGFloat)heightForRowsInSection:(NSIndexPath *)indexPath;

- (NSString *)cellIdForSection:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
