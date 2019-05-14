//
//  JMVitaOfPersonDetailViewController.h
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JMVitaOfPersonDetailViewController : UIViewController

@property(nonatomic,strong)NSArray *experiencesArray;
@property(nonatomic,strong)NSArray *educationArray;
@property(nonatomic,strong)NSArray *shieldingArray;
@property (nonatomic, strong) void(^didLoadView)(CGFloat);

@end

NS_ASSUME_NONNULL_END
