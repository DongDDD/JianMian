//
//  JMCompanyVideoView.h
//  JMian
//
//  Created by mac on 2019/5/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JMCompanyVideoViewDelegate <NSObject>

-(void)playAction;

@end

@interface JMCompanyVideoView : UIView

@property(nonatomic,copy)NSString *videoUrl;
@property (weak, nonatomic) IBOutlet UIImageView *videoImg;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic)id<JMCompanyVideoViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
