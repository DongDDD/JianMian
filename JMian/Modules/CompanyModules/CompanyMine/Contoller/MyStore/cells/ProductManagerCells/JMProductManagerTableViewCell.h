//
//  JMProductManagerTableViewCell.h
//  JMian
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMProductManagerTableViewCellIdentifier;

@interface JMProductManagerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn1;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn2;
@property (weak, nonatomic) IBOutlet UIButton *BottomBtn3;

@end

NS_ASSUME_NONNULL_END
