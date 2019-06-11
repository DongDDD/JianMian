//
//  JMComfirmPostBottomView.h
//  JMian
//
//  Created by mac on 2019/6/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMComfirmPostBottomViewDelegate <NSObject>

-(void)isReadProtocol:(BOOL)isRead;
-(void)OKAction;

@end
@interface JMComfirmPostBottomView : UIView
@property(nonatomic,weak)id<JMComfirmPostBottomViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *didReadBtn;
@property (weak, nonatomic) IBOutlet UIButton *OKBtn;

@end

NS_ASSUME_NONNULL_END
