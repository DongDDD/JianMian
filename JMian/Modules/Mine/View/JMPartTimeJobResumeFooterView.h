//
//  JMPartTimeJobResumeFooterView.h
//  JMian
//
//  Created by mac on 2019/6/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JMPartTimeJobResumeFooterViewType) {
    JMPartTimeJobResumeFooterViewTypeDefault,
    JMPartTimeJobResumeFooterViewTypeJobDecription,
    JMPartTimeJobResumeFooterViewTypeMyAdvantage,
    JMPartTimeJobResumeFooterViewTypePartTimeJob,
    JMPartTimeJobResumeFooterViewTypeGoodsDesc,
    JMPartTimeJobResumeFooterViewTypeCommentDesc,
};


@protocol JMPartTimeJobResumeFooterViewDelegate <NSObject>

-(void)sendContent:(NSString *)content;

@end

@interface JMPartTimeJobResumeFooterView : UIView

@property(nonatomic,copy)NSString * content;
@property(nonatomic,strong)UILabel *placeHolder;
@property(nonatomic,strong)UITextView *contentTextView;
-(void)setContent:(NSString *)content;
@property(nonatomic,weak)id<JMPartTimeJobResumeFooterViewDelegate>delegate;

@property(nonatomic,assign)JMPartTimeJobResumeFooterViewType viewType;

@end

NS_ASSUME_NONNULL_END
