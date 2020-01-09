//
//  JMBFriendViewController.h
//  JMian
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMFriendListData.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMBFriendViewControllerViewType) {
    JMBFriendViewControllerViewTypeFriendList,
    JMBFriendViewControllerViewTypeGroup,
};
@protocol JMBFriendViewControllerDelegate <NSObject>

-(void)BFriendViewControllerDidSelectedFriendWithModel:(JMFriendListData *)data;
-(void)BFriendViewControllerDidCancelFriendWithModel:(JMFriendListData *)data;
-(void)BFriendViewControllerFriendList:(NSMutableArray *)arr;
@end

@interface JMBFriendViewController : BaseViewController
@property(nonatomic,weak)id<JMBFriendViewControllerDelegate>delegate;
@property(nonatomic,assign)JMBFriendViewControllerViewType viewType;
@end

NS_ASSUME_NONNULL_END
