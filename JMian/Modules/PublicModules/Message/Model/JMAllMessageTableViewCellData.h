//
//  JMAllMessageTableViewCellData.h
//  JMian
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, TConvType) {
    TConv_Type_C2C      = 1,
    TConv_Type_Group    = 2,
    TConv_Type_System   = 3,
    TConv_Type_Service   = 4,
    TConv_Type_DemiSystem   = 5,
};

@interface JMAllMessageTableViewCellData : NSObject

@property (nonatomic, copy) NSString *convId;
@property (nonatomic, assign) TConvType convType;
@property (nonatomic, copy) NSString *head;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) int unRead;


@end

NS_ASSUME_NONNULL_END
