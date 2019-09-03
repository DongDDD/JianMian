//
//  JMUserChangeWindowView.h
//  JMian
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JMUserChangeWindowViewDelegate <NSObject>

-(void)OKAction;
-(void)deleteAction;

@end

@interface JMUserChangeWindowView : UIView

@property (weak, nonatomic) IBOutlet UIView *windowView;
@property (nonatomic,assign)id<JMUserChangeWindowViewDelegate>delegate;
//+(JMUserChangeWindowView *)sharedUserChangeWindow;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

NS_ASSUME_NONNULL_END
