//
//  JMGoodsListView.h
//  JMian
//
//  Created by mac on 2020/2/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//typedef enum : NSUInteger {
//    JMGoodsListViewTypeOrderInfo,
//    JMGoodsListViewTypeAfterSales,
//} JMGoodsListViewType;

@interface JMGoodsListView : UIView
@property(nonatomic,strong)NSArray *goods;
//@property(nonatomic,assign)JMGoodsListViewType viewType;
@end

NS_ASSUME_NONNULL_END
