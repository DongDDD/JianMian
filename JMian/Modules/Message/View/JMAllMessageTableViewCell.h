//
//  JMAllMessageTableViewCell.h
//  JMian
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TConvType) {
    TConv_Type_C2C      = 1,
    TConv_Type_Group    = 2,
    TConv_Type_System   = 3,
};


@interface JMAllMessageTableViewCellData : NSObject

@property (nonatomic, strong) NSString *convId;
@property (nonatomic, assign) TConvType convType;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) int unRead;
@end

@interface JMAllMessageTableViewCell : UITableViewCell

- (void)setData:(JMAllMessageTableViewCellData *)data;

@end

NS_ASSUME_NONNULL_END
