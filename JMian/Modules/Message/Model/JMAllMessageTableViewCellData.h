//
//  JMAllMessageTableViewCellData.h
//  JMian
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMAllMessageTableViewCellData : NSObject

@property (nonatomic, strong) NSString *convId;
//@property (nonatomic, assign) TConvType convType;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) int unRead;


@end

NS_ASSUME_NONNULL_END
