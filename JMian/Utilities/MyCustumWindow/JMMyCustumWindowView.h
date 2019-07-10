//
//  JMMyCustumWindowView.h
//  JMian
//
//  Created by mac on 2019/7/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMMyCustumWindowViewDelegate <NSObject>

-(void)windowLeftAction;
-(void)windowRightAction;

@end

@interface JMMyCustumWindowView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property(nonatomic, weak)id<JMMyCustumWindowViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
