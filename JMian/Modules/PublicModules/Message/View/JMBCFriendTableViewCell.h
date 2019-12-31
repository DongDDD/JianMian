//
//  JMBCFriendTableViewCell.h
//  JMian
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMFriendListData.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMBCFriendTableViewCellType) {
    JMCFriendTableViewCell,
    JMBFriendTableViewCell,
};
typedef NS_ENUM(NSInteger, JMBCFriendTableViewCellType2) {
    JMFriendTableViewCellFriendList,
    JMFriendTableViewCellCreateGroup,
};


@protocol JMBCFriendTableViewCellDelegate <NSObject>

-(void)didSelectedFriendWithModel:(JMFriendListData *)data;
-(void)didCancelFriendWithModel:(JMFriendListData *)data;

@end

@interface JMBCFriendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property(nonatomic,strong)JMFriendListData *data;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property(nonatomic,assign)JMBCFriendTableViewCellType viewType;
@property(nonatomic,assign)JMBCFriendTableViewCellType2 viewType2;

@property(nonatomic,weak)id<JMBCFriendTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
