//
//  JMMessageTableViewController.h
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMAllMessageTableViewCell.h"
#import "JMMessageListModel.h"
#import "BaseViewController.h"
#import "JMMessageCell.h"

NS_ASSUME_NONNULL_BEGIN
@class JMMessageTableViewController;
@protocol JMMessageTableViewControllerDelegate <NSObject>
- (void)didTapInMessageController:(JMMessageTableViewController *)controller;
- (void)isDominatorController:(JMMessageTableViewController *)controller;

//- (void)didHideMenuInMessageController:(JMMessageTableViewController *)controller;
//- (BOOL)messageController:(JMMessageTableViewController *)controller willShowMenuInView:(UIView *)view;
//- (void)messageController:(JMMessageTableViewController *)controller didSelectMessages:(NSMutableArray *)msgs atIndex:(NSInteger)index;
@end
@interface JMMessageTableViewController : UITableViewController

- (void)setMyConvModel:(JMMessageListModel *)myConvModel;

@property (nonatomic, weak) id<JMMessageTableViewControllerDelegate> delegate;
-(void)sendMessage:(JMMessageCellData *)data;
- (void)scrollToBottom:(BOOL)animate;

@end

NS_ASSUME_NONNULL_END
