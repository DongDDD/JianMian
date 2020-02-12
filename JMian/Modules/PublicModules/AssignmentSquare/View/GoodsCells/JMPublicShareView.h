//
//  JMPublicShareView.h
//  JMian
//
//  Created by mac on 2020/2/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMShareView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMPublicShareViewDelegate <NSObject>

-(void)didClickShareActoinWithTag:(NSInteger)tag;

@end
@interface JMPublicShareView : UIView<JMShareViewDelegate>
@property(nonatomic,strong)JMShareView *shareView;
@property(nonatomic,weak)id<JMPublicShareViewDelegate>delegate;
-(void)show;
-(void)hide;
@end

NS_ASSUME_NONNULL_END
