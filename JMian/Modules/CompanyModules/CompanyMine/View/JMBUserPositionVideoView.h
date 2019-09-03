//
//  JMBUserPositionVideoView.h
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JMTaskPartTimejobDetailModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMBUserPositionVideoViewDelegate <NSObject>
-(void)videoLeftBtnAction;
-(void)videoRightBtnAction;
-(void)playBtnActionWithUrl:(NSString *)url;

@end

@interface JMBUserPositionVideoView : UIView
@property (weak, nonatomic) IBOutlet UIButton *videoLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoRightBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *videoImg;
@property (weak, nonatomic) id<JMBUserPositionVideoViewDelegate>delegate;
@property (nonatomic, copy) NSString *video_path;
@property (nonatomic, copy) NSString *video_cover;

//-(void)setValusWithVideo_path:(NSString *)video_path video_cover:(NSString *)video_cover;
//@property (strong, nonatomic) JMTaskPartTimejobDetailModel *model;


@end

NS_ASSUME_NONNULL_END
