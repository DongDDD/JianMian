//
//  JMPictureAddViewController.h
//  JMian
//
//  Created by mac on 2019/12/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMPictureAddViewControllerDelegate <NSObject>

-(void)pictureAddWithImage_arr:(NSArray *)image_arr;

@end
@interface JMPictureAddViewController : BaseViewController
@property(nonatomic,weak)id<JMPictureAddViewControllerDelegate>delegate;
@property(nonatomic,strong)NSArray *image_arr;

@end

NS_ASSUME_NONNULL_END
