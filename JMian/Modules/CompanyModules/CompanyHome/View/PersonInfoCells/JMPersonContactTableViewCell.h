//
//  JMPersonContactTableViewCell.h
//  JMian
//
//  Created by mac on 2019/11/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"
extern NSString *const JMPersonContactTableViewCellIdentifier;

NS_ASSUME_NONNULL_BEGIN
@protocol JMPersonContactTableViewCellDelegate <NSObject>

-(void)vipAction;

@end

@interface JMPersonContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *telephoneLab;
@property (weak, nonatomic) IBOutlet UILabel *emailLab;
@property (nonatomic, weak)id<JMPersonContactTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *vipBtn;
@property (nonatomic, strong)JMVitaDetailModel *model;
@end

NS_ASSUME_NONNULL_END
