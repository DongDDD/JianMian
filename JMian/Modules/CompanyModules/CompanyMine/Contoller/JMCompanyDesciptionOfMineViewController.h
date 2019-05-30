//
//  JMCompanyDesciptionOfMineViewController.h
//  JMian
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMCompanyDesciptionOfMineViewDelegate <NSObject>

-(void)sendTextView_textData:(NSString *_Nonnull)textData;

@end

@interface JMCompanyDesciptionOfMineViewController : BaseViewController


@property(weak,nonatomic)id<JMCompanyDesciptionOfMineViewDelegate>delegate;
@property(nonatomic, copy)NSString *comDesc;
@end

NS_ASSUME_NONNULL_END
