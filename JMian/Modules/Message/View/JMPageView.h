//
//  JMPageView.h
//  JMian
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMPageView : UIView

@property (nonatomic, strong) void(^didEndScrollView)(NSInteger);

- (instancetype)initWithFrame:(CGRect)frame childVC:(NSArray *)childVC;

- (void)setCurrentIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
