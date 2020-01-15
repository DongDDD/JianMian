//
//  JMProductSpecicationConfigures.m
//  JMian
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMProductSpecicationConfigures.h"

@implementation JMProductSpecicationConfigures

-(void)initDataWithSection:(NSInteger)section{
    switch (section) {
        case JMProductSpecicationSectionTypeColor:
            self.rowsNum = self.colorDataArr.count;
            self.footerheight = 0;
            self.height = 40;
//            self.cellId = JMMyStoreTitleHeaderTableViewCellIdentifier;
            break;
        case JMProductSpecicationSectionTypeSize:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 97;
//            self.cellId = JMMyStoreOrderStatusTableViewCellIdentifier;
            break;
        case JMProductSpecicationSectionTypeStock:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 122;
//            self.cellId = JMMyStoreManager1TableViewCellIdentifier;
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
