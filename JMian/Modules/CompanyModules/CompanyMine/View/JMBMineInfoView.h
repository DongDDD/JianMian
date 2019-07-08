//
//  JMBMineInfoView.h
//  JMian
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMBMineInfoViewDelegate <NSObject>

@optional
- (void)didSelectItemWithRow:(NSInteger)row;

@end

@interface JMBMineInfoView : UIView
@property (nonatomic,assign)id<JMBMineInfoViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
