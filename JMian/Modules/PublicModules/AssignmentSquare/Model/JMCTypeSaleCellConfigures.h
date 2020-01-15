//
//  JMCTypeSaleCellConfigures.h
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMTaskDetailHeaderTableViewCell.h"//公司头部信息
#import "JMCDetailTaskDecriTableViewCell.h"//通用描述
#import "JMCDetailTaskDecri2TableViewCell.h"//任务描述
#import "JMCSaleTypeDetailStoreHeaderTableViewCell.h"//店铺标题
#import "JMCSaleTypeDetailGoodsTableViewCell.h"//店铺商品
#import "JMCDetailCommentTableViewCell.h"//评论
#import "JMCDetailModel.h"
#import "JMCommentCellData.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMCTypeSaleCellType){
    JMCTypeSaleCellTypeHeader = 0,
    JMCTypeSaleCellTypeTaskDesc1,
    JMCTypeSaleCellTypeTaskDesc2,
    JMCTypeSaleCellTypeMyStoreHeader,
    JMCTypeSaleCellTypeMyStoreGoods,
};

@interface JMCTypeSaleCellConfigures : NSObject
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat footerheight;
@property (assign, nonatomic) CGFloat headerheight;

@property (assign, nonatomic) NSInteger rowsNum;
@property (assign, nonatomic) NSInteger section;
@property (copy, nonatomic) NSString *cellId;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (UIView *)headerViewInSection:(NSInteger)section;

- (CGFloat)heightForRowsInSection:(NSInteger)section;

- (NSString *)cellIdForSection:(NSInteger)section;


- (void)didSelectedRowAtSection:(NSInteger)section;

@property (strong, nonatomic) JMCDetailModel *model;
@property (strong, nonatomic) NSArray *commentListArray;
@end

NS_ASSUME_NONNULL_END
