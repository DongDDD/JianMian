//
//  JMIndustryWebViewController.h
//  JMian
//
//  Created by mac on 2019/6/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBaseWebViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMIndustryWebViewControllerDelegate <NSObject>

-(void)sendlabsWithJson:(NSString *)json;

@end

@interface JMIndustryWebViewController : JMBaseWebViewController
@property(nonatomic,weak)id<JMIndustryWebViewControllerDelegate>delegate;
@property (nonatomic, strong)NSString *labsJson;

@end

NS_ASSUME_NONNULL_END
