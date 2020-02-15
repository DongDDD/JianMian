//
//  JMOderInfoBtnTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JMOderInfoBtnTableViewCelllType){
    JMOderInfoBtnTypeTradeSuccessfully = 0 ,
    JMOderInfoBtnTypeTradeDidRefund,

};
@protocol JMOderInfoBtnTableViewCellDelegate <NSObject>

-(void)didClickBtnWithBtnTtitle:(NSString *_Nonnull)btnTtitle;

@end
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMOderInfoBtnTableViewCellIdentifier;

@interface JMOderInfoBtnTableViewCell : UITableViewCell
@property(nonatomic,assign)JMOderInfoBtnTableViewCelllType viewType;
@property(nonatomic,weak)id<JMOderInfoBtnTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
