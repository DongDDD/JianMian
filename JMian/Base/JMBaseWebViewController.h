//
//  JMBaseWebViewController.h
//  JMian
//
//  Created by mac on 2019/6/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMWeakWebViewScriptMessageDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMBaseWebViewController : BaseViewController

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) WKUserContentController *wkUController;
@property(nonatomic, strong) JMWeakWebViewScriptMessageDelegate *weakScriptMessageDelegate;

- (void)setHTMLPath:(NSString *)path;
//- (void)ocToJs_arrayData:(NSArray *)arrayData selectedLabs:(NSArray *)selectedLabs;//选择行业
-(NSString *)arrayToJSONWithArr:(NSArray *)arr;//数组转JSON
-(NSString *)dicToJSONWithDic:(NSDictionary *)dic;//字典转JSON
@end

NS_ASSUME_NONNULL_END
