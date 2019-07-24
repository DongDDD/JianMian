//
//  PositionDesiredSecondViewController.h
//  JMian
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PositionDesiredSecondViewControllerDelegate <NSObject>

-(void)didSelectedCellWithArr:(NSArray *)arr;

@end
@interface PositionDesiredSecondViewController : BaseViewController

@property(nonatomic,copy)NSString *keyWord;
@property(nonatomic,weak)id<PositionDesiredSecondViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
