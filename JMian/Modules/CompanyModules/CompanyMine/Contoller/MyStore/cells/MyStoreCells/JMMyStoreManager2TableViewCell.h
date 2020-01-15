//
//  JMMyStoreManager2TableViewCell.h
//  JMian
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMMyStoreManager2TableViewCellIdentifier;
@protocol JMMyStoreManager2TableViewCellDelegate <NSObject>
-(void)didSelectStoreManager2ItemWithRow:(NSInteger)row;
@end

@interface JMMyStoreManager2TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (nonatomic,weak)id<JMMyStoreManager2TableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
