//
//  JMInvoiceModel.m
//  JMian
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMInvoiceModel.h"

@implementation JMInvoiceModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"invoice_email":@"invoice.email",
             @"invoice_invoice_id":@"invoice.invoice_id",
             @"invoice_title":@"invoice.title",
             @"invoice_tax_number":@"invoice.tax_number",
             };
    
}

@end
