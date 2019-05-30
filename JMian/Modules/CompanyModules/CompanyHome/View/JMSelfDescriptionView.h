//
//  JMSelfDescriptionView.h
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMSelfDescriptionView : UIView

//@property (nonatomic, strong) void(^didLoadContentLab)(CGFloat);
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, copy)NSString *content;

@end

NS_ASSUME_NONNULL_END
