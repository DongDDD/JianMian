//
//  JMPostProductConfigures.m
//  JMian
//
//  Created by mac on 2020/1/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMPostProductConfigures.h"

@implementation JMPostProductConfigures

-(void)initDataWithSection:(NSInteger)section{
    switch (section) {
        case JMPostProductTypeHeader:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 375;
//            self.cellId = JMMyStoreTitleHeaderTableViewCellIdentifier;
            break;
        case JMPostProductTypeParam:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 400;
//            self.cellId = JMMyStoreOrderStatusTableViewCellIdentifier;
            break;
        case JMPostProductTypeDesc:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 250;
//            self.cellId = JMMyStoreManager1TableViewCellIdentifier;
            break;
        case JMPostProductTypePostBtn:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 60;
//            self.cellId = JMMyStoreManager2TableViewCellIdentifier;
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
