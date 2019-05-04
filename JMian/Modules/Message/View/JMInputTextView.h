//
//  JMInputTextView.h
//  JMian
//
//  Created by mac on 2019/5/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMGreetView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMInputTextViewDelegate <NSObject>

-(void)sendMessageWithText:(NSString *)text;
-(void)sendGreetAction:(NSInteger *)index;

@end


@interface JMInputTextView : UIView

@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *btn3;
//@property (nonatomic ,strong) JMGreetView *greetView;


@property (nonatomic, strong) NSArray *childVC;
- (void)setCurrentIndex:(NSInteger)index;
@property(nonatomic,weak)id<JMInputTextViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
