//
//  JMTitlesView.h
//  JMian
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"

@interface JMTitlesView : UIView

@property (nonatomic, strong) void(^didTitleClick)(NSInteger);

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

- (void)setCurrentTitleIndex:(NSInteger)index;

@end
