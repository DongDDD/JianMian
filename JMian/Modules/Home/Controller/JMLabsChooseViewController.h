//
//  JMLabsChooseViewController.h
//  JMian
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMLabsChooseViewControllerDelegate <NSObject>

-(void)resetAction;
-(void)OKAction;
-(void)sendKeyWord_education:(NSString *)education exprience:(NSString *)exprience;
- (void)didChooseLabsTitle_str:(NSString *)str index:(NSInteger)index;

@end

@interface JMLabsChooseViewController : UIViewController

@property(nonatomic,weak)id<JMLabsChooseViewControllerDelegate>delegate;



@end

NS_ASSUME_NONNULL_END
