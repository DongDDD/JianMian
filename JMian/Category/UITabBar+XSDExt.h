//
//  UITabBar+XSDExt.h
//  JMian
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (XSDExt)
- (void)showBadgeOnItemIndex:(NSInteger)index;   ///<显示小红点

- (void)hideBadgeOnItemIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
