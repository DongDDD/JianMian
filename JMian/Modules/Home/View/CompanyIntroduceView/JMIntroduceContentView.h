//
//  JMIntroduceContentView.h
//  JMian
//
//  Created by mac on 2019/4/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>

NS_ASSUME_NONNULL_BEGIN


@protocol JMIntroduceContentViewDelegate <NSObject>

@optional
-(void)didClickButton:(CGFloat)contentHeight;

@end

@interface JMIntroduceContentView : UIView


@property(nonatomic,strong)YYLabel *contenLab;
@property(nonatomic,strong)UIButton *spreadBtn;
@property(nonatomic,weak) id<JMIntroduceContentViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
