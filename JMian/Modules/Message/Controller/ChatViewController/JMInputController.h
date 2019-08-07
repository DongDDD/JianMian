//
//  JMInputController.h
//  JMian
//
//  Created by mac on 2019/5/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMInputTextView.h"
#import "JMGreetView.h"
#import "JMFaceView.h"
#import "JMMoreView.h"
#import "JMMessageCell.h"
#import "JMMoreCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class JMInputController;
@protocol JMInputControllerDelegate <NSObject>
- (void)inputController:(JMInputController *)inputController didChangeHeight:(CGFloat)height;
- (void)inputController:(JMInputController *)inputController didSendMessage:(JMMessageCellData *)msg;
- (void)inputController:(JMInputController *)inputController didSelectMoreAtIndex:(NSInteger)index;
- (void)inputController:(JMInputController *)inputController didSelectMoreCell:(JMMoreCollectionViewCell *)cell;
@end


@interface JMInputController : UIViewController

@property (nonatomic, strong) JMInputTextView *inputTextView;
@property (nonatomic, strong) JMGreetView *greeView;
@property (nonatomic, strong) JMFaceView *faceView;
@property (nonatomic, strong) JMMoreView *moreView;
- (void)reset;

@property (nonatomic, weak) id<JMInputControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
