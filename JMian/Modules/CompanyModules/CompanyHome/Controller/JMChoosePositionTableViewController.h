//
//  JMChoosePositionTableViewController.h
//  JMian
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JMChoosePositionTableViewController;
@protocol JMChoosePositionTableViewControllerDelegate <NSObject>

-(void)didSelectCellActionController:(JMChoosePositionTableViewController *)controller;

@end

@interface JMChoosePositionTableViewController : UITableViewController

@property(nonatomic,weak)id<JMChoosePositionTableViewControllerDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *choosePositionArray;

@end

NS_ASSUME_NONNULL_END
