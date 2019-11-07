//
//  JMMoreView.h
//  JMian
//
//  Created by mac on 2019/5/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMMoreCollectionViewCell.h"


NS_ASSUME_NONNULL_BEGIN
@class JMMoreView;

@protocol JMMoreViewDelegate <NSObject>

- (void)moreView:(JMMoreView *)moreView didSelectMoreCell:(JMMoreCollectionViewCell *)cell;
@end

@interface JMMoreView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *imageNameArr,*labelStrArr;

@property (weak, nonatomic)id<JMMoreViewDelegate>delegate;

/**
 *  moreView的页面控制器。
 *  用于 moreCell 的多页浏览，能够实现滑动切换更多视图页，在更多视图下方以原点形式显示总页数以及当前页数等功能。
 */
@property (nonatomic, strong) UIPageControl *pageControl;

/**
 *  设置数据
 *  用来进行 TUIMoreView 的数据初始化或在有需要时设置新的数据。
 *  数组中存放的元素类型为 TUIInputMoreCellData。
 *
 *  @param data     需要设置的数据
 */
- (void)setData:(NSArray *)data;
@end

NS_ASSUME_NONNULL_END
