//
//  JMJobDescriptionViewController.h
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

@protocol JMJobDescriptionDelegate <NSObject>

-(void)sendTextView_textData:(NSString *_Nonnull)textData;

@end
NS_ASSUME_NONNULL_BEGIN

@interface JMJobDescriptionViewController : BaseViewController

@property(weak,nonatomic)id<JMJobDescriptionDelegate>delegate;
@property(nonatomic,copy)NSString *foreign_key;
@end

NS_ASSUME_NONNULL_END
