//
//  JMMyShareView.h
//  JMian
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMMyShareViewDelegate <NSObject>

-(void)myShareWechat1;
-(void)myShareWechat2;
-(void)myShareDeleteAction;
@end
@interface JMMyShareView : UIView
@property (weak, nonatomic) IBOutlet UIView *BGView;

@property(nonatomic,weak)id<JMMyShareViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
