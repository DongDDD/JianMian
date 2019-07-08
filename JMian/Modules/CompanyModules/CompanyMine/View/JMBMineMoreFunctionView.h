//
//  JMBMineMoreFunctionView.h
//  JMian
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMBMineMoreFunctionViewDelegate <NSObject>

@optional
- (void)didSelectCellWithRow:(NSInteger)row;

@end

@interface JMBMineMoreFunctionView : UIView

@property (nonatomic,assign)id<JMBMineMoreFunctionViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
