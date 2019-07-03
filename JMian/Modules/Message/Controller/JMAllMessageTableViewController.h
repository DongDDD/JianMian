//
//  JMAllMessageTableViewController.h
//  JMian
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMAllMessageTableViewController : UITableViewController
@property (nonatomic, strong) void(^didReadMessage)(int);
@property(nonatomic,assign)int unReadNum;

@end

NS_ASSUME_NONNULL_END
