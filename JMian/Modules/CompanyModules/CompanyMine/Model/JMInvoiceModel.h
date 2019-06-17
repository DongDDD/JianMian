//
//  JMInvoiceModel.h
//  JMian
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMInvoiceModel : NSObject

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *invoice_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tax_number;

@end

NS_ASSUME_NONNULL_END
