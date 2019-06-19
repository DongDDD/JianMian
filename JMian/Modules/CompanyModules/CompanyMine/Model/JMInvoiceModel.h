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

@property (nonatomic, copy) NSString *tax_c;
@property (nonatomic, copy) NSString *tax_b;

@property (nonatomic, copy) NSString *invoice_email;
@property (nonatomic, copy) NSString *invoice_invoice_id;
@property (nonatomic, copy) NSString *invoice_title;
@property (nonatomic, copy) NSString *invoice_tax_number;

@end



NS_ASSUME_NONNULL_END
