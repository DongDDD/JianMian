//
//  JMBottom2View.h
//  JMian
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMBottom2ViewDelegate <NSObject>

-(void)bottomLeftActionDelegate;
-(void)bottomRightActionDelegate;

@end
@interface JMBottom2View : UIView
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (nonatomic, weak) id<JMBottom2ViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
