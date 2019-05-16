//
//  AppDelegate.h
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *playArray;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property(nonatomic,strong)NSDictionary *videoChatDic;

@end

