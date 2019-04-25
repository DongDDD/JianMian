//
//  JMMineModulesTableViewCell.h
//  JMian
//
//  Created by Chitat on 2019/3/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMMineModulesTableViewCellDelegate <NSObject>

@optional
- (void)didSelectItemWithRow:(NSInteger)row;

@end

@interface JMMineModulesTableViewCell : UITableViewCell

@property (nonatomic,assign)id<JMMineModulesTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
