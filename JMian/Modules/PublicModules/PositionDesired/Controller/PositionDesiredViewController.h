//
//  PositionDesiredViewController.h
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchView.h"

@protocol PositionDesiredDelegate <NSObject>

-(void)sendPositoinData:(NSString *_Nullable)labStr labIDStr:(NSString *_Nullable)labIDStr;

@end


NS_ASSUME_NONNULL_BEGIN

@interface PositionDesiredViewController : BaseViewController

@property(nonatomic,weak)id<PositionDesiredDelegate>delegate;
@property (nonatomic, strong) SearchView *searchView;
@property(nonatomic, assign)BOOL isHomeViewVC;
@end

NS_ASSUME_NONNULL_END
