//
//  JMChatViewSectionView.h
//  JMian
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMChatViewSectionViewDelegate <NSObject>

-(void)videoInterviewAction;

@end


@interface JMChatViewSectionView : UIView

@property(nonatomic,weak)id<JMChatViewSectionViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
