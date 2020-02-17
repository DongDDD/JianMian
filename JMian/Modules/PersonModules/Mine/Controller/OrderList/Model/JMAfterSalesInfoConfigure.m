//
//  JMAfterSalesInfoConfigure.m
//  JMian
//
//  Created by mac on 2020/2/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMAfterSalesInfoConfigure.h"

@implementation JMAfterSalesInfoConfigure
-(void)initDataWithSection:(NSInteger)section{
    switch (section) {
        case JMAfterSalesInfoTypeTitleHeader:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 75;
            break;
        case JMAfterSalesInfoTypeRefundTitle:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 44;
            break;
        case JMAfterSalesInfoTypeGoodsList:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 110;
            break;
        case JMAfterSalesInfoTypeDetail:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 94;
            break;
        case JMAfterSalesInfoTypeHistory:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 33;
            break;
        case JMAfterSalesInfoTypeBtn:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 75;
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
