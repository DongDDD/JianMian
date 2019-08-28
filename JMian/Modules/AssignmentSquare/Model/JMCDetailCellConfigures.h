//
//  JMCDetailCellConfigures.h
//  JMian
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMTaskDetailHeaderTableViewCell.h"//公司头部信息
#import "JMCDetailTaskDecriTableViewCell.h"//通用描述
#import "JMCDetailTaskDecri2TableViewCell.h"//任务描述
#import "JMCDetailProduceTableViewCell.h"//产品描述
#import "JMCDetailVideoTableViewCell.h"
#import "JMCDetailImageTableViewCell.h"
#import "JMMapTableViewCell.h"//公司地址
#import "JMCDetailCommentTableViewCell.h"//评论
#import "JMCDetailModel.h"
#import "JMCommentCellData.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMTaskDetailTableViewCellType){
    JMTaskDetailCellTypeHeader = 0,
    JMTaskDetail2CellType,
};

@interface JMCDetailCellConfigures : NSObject

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat footerheight;
@property (assign, nonatomic) NSInteger rowsNum;
@property (assign, nonatomic) NSInteger section;
@property (copy, nonatomic) NSString *cellId;
//@property (assign, nonatomic) UIView *footerView;

@property (strong, nonatomic) JMCDetailModel *model;
@property (strong, nonatomic) NSArray *commentListArray;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

//- (UIView *)footerViewInSection:(NSInteger)section;
- (UIView *)headerViewInSection:(NSInteger)section;


- (CGFloat)heightForRowsInSection:(NSIndexPath *)indexPath;

- (NSString *)cellIdForSection:(NSIndexPath *)indexPath;

//- (void)didSelectedRowAtSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
