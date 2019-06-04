//
//  JMWeakWebViewScriptDelegate.h
//  JMian
//
//  Created by mac on 2019/6/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DimensMacros.h"

NS_ASSUME_NONNULL_BEGIN
//// WKWebView 内存不释放的问题解决

@interface JMWeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;


@end

NS_ASSUME_NONNULL_END
