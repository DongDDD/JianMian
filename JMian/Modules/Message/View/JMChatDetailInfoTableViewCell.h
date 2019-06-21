//
//  JMChatDetailInfoTableViewCell.h
//  JMian
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMMessageListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMChatDetailInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *salary;
@property (weak, nonatomic) IBOutlet UILabel *myDescription;

@property (nonatomic, strong) JMMessageListModel *myConModel;

@end

NS_ASSUME_NONNULL_END
