//
//  JMBUserPositionVideoView.h
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMBUserPositionVideoViewDelegate <NSObject>
-(void)videoLeftBtnAction;
-(void)videoRightBtnAction;
-(void)playBtnAction;

@end

@interface JMBUserPositionVideoView : UIView
@property (weak, nonatomic) IBOutlet UIButton *videoLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoRightBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *videoImg;
@property (weak, nonatomic) id<JMBUserPositionVideoViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
