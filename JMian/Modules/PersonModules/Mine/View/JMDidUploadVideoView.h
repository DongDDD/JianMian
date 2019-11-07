//
//  JMDidUploadVideoView.h
//  JMian
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMDidUploadVideoViewDelegate <NSObject>

-(void)leftAction;
-(void)rightAction;
-(void)playAction;

@end

@interface JMDidUploadVideoView : UIView

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,weak)id<JMDidUploadVideoViewDelegate>delegate;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;

@end

NS_ASSUME_NONNULL_END
