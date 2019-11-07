//
//  JMBDetailVideoView.h
//  JMian
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMBDetailModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMBDetailVideoViewDelegate <NSObject>

-(void)playVideoActionWithUrl:(NSString *)url;


@end
@interface JMBDetailVideoView : UIView

@property(nonatomic,strong)JMBDetailModel *model;
@property(nonatomic,weak)id<JMBDetailVideoViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
