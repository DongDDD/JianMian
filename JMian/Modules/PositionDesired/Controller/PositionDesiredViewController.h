//
//  PositionDesiredViewController.h
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

@protocol PositionDesiredDelegate <NSObject>

-(void)sendPositoinData:(NSString *_Nullable)labStr labIDStr:(NSString *_Nullable)labIDStr;

@end

//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)


NS_ASSUME_NONNULL_BEGIN

@interface PositionDesiredViewController : BaseViewController

@property(nonatomic,weak)id<PositionDesiredDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
