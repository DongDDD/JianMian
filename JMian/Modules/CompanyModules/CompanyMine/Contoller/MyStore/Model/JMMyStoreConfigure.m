//
//  JMMyStoreConfigure.m
//  JMian
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMMyStoreConfigure.h"

@implementation JMMyStoreConfigure

-(void)initDataWithSection:(NSInteger)section{
    switch (section) {
        case JMMyStoreTypeTitleHeader:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 116;
            self.cellId = JMMyStoreTitleHeaderTableViewCellIdentifier;
            break;
        case JMMyStoreTypeOrderStatus:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 97;
            self.cellId = JMMyStoreOrderStatusTableViewCellIdentifier;
            break;
        case JMMyStoreTypeOrderManager1:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 122;
            self.cellId = JMMyStoreManager1TableViewCellIdentifier;
            break;
        case JMMyStoreTypeOrderManager2:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 164;
            self.cellId = JMMyStoreManager2TableViewCellIdentifier;
            break;
        default:
            break;
    }
    
    
}


 - (NSInteger)numberOfRowsInSection:(NSInteger)section {
     [self initDataWithSection:section];
     return self.rowsNum;
 }

 - (CGFloat)heightForFooterInSection:(NSInteger)section {
     [self initDataWithSection:section];
     return self.footerheight;
 }

 - (CGFloat)heightForRowsInSection:(NSInteger)section {
     [self initDataWithSection:section];
     return self.height;
 }

 - (NSString *)cellIdForSection:(NSInteger)section {
     [self initDataWithSection:section];
     return self.cellId;
 }

@end
