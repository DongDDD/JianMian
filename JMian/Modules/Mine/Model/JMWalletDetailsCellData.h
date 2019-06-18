//
//  JMWalletDetailsCellData.h
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMWalletDetailsCellData : NSObject

@property (copy, nonatomic) NSString *amount;
@property (copy, nonatomic) NSString *created_at;
@property (copy, nonatomic) NSString *detail_id;
@property (copy, nonatomic) NSString *serial_no;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *action;

@end

NS_ASSUME_NONNULL_END
