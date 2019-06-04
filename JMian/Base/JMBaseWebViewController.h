//
//  JMBaseWebViewController.h
//  JMian
//
//  Created by mac on 2019/6/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMBaseWebViewController : BaseViewController

@property(nonatomic, strong) WKWebView *webView;
- (void)setHTMLPath:(NSString *)path;
//- (void)ocToJs_arrayData:(NSArray *)arrayData selectedLabs:(NSArray *)selectedLabs;//选择行业
- (NSString *)arrayToJSON:(NSArray *)arr;
@end

NS_ASSUME_NONNULL_END
