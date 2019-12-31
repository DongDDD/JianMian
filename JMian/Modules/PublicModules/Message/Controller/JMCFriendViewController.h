//
//  JMCFriendViewController.h
//  JMian
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMFriendListData.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMCFriendViewControllerViewType) {
    JMCFriendViewControllerViewTypeFriendList,
    JMCFriendViewControllerViewTypeGroup,
};
@protocol JMCFriendViewControllerDelegate <NSObject>

-(void)CFriendViewControllerDidSelectedFriendWithModel:(JMFriendListData *)data;
-(void)CFriendViewControllerDidCancelFriendWithModel:(JMFriendListData *)data;

@end

@interface JMCFriendViewController : BaseViewController
@property(nonatomic,weak)id<JMCFriendViewControllerDelegate>delegate;
@property(nonatomic,assign)JMCFriendViewControllerViewType viewType;

@end

NS_ASSUME_NONNULL_END
