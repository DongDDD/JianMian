//
//  JMChooseCardViewController.h
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMBankCardData.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMChooseCardViewControllerDelegate <NSObject>

-(void)didChooseBankCardWithData:(JMBankCardData *)data;

@end
@interface JMChooseCardViewController : BaseViewController

@property(nonatomic, weak)id<JMChooseCardViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
