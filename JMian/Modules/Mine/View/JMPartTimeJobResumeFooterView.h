//
//  JMPartTimeJobResumeFooterView.h
//  JMian
//
//  Created by mac on 2019/6/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMPartTimeJobResumeFooterViewDelegate <NSObject>

-(void)sendContent:(NSString *)content;

@end

@interface JMPartTimeJobResumeFooterView : UIView

@property(nonatomic,copy)NSString * content;
@property(nonatomic,strong)UILabel *placeHolder;
@property(nonatomic,strong)UITextView *contentTextView;
-(void)setContent:(NSString *)content;
@property(nonatomic,weak)id<JMPartTimeJobResumeFooterViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
