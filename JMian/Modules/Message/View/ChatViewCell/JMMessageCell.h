//
//  JMMessageCell.h
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//typedef NS_ENUM(NSUInteger, TMsgStatus) {
//    Msg_Status_Sending,
//    Msg_Status_Sending_2,
//    Msg_Status_Succ,
//    Msg_Status_Fail,
//};


@interface JMMessageCellData : NSObject
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL showName;
@property (nonatomic, assign) BOOL isSelf;
//@property (nonatomic, assign) TMsgStatus status;
@property (nonatomic, strong) id custom;

@end


@interface JMMessageCell : UITableViewCell
@property (nonatomic, strong) UIImageView *head;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UIImageView *error;

@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIImageView *bubble;

- (CGFloat)getHeight:(JMMessageCellData *)data;
- (void)setData:(JMMessageCellData *)data;
- (void)setupViews;

@end

NS_ASSUME_NONNULL_END
