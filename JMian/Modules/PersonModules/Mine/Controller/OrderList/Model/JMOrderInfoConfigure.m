//
//  JMOrderInfoConfigure.m
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOrderInfoConfigure.h"

@implementation JMOrderInfoConfigure

-(void)initDataWithSection:(NSInteger)section{
    switch (section) {
        case JMOrderInfoTypeTitleHeader:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 75;
            break;
        case JMOrderInfoTypeAdress:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 64;
            break;
        case JMOrderInfoTypeGoodsList:
            self.rowsNum = self.model.goods.count;
            self.footerheight = 10;
            self.height = 110;
            break;
        case JMOrderInfoTypePrice:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 41;
            break;
        case JMOrderInfoTypeTimeMsg:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 120;
            break;
            case JMOrderInfoTypeBtn:
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
