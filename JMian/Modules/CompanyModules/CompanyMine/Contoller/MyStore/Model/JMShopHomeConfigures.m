//
//  JMShopHomeConfigures.m
//  JMian
//
//  Created by mac on 2020/2/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMShopHomeConfigures.h"
 
@implementation JMShopHomeConfigures

-(void)initDataWithSection:(NSInteger)section{
    switch (section) {
        case JMShopHomeTypeTitleHeader:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 116;
            break;
        case JMShopHomeTypeGoodsList:
            self.rowsNum = 1;
            self.footerheight = 0;
            [self getHeightFromGoods];
            break;
 
        default:
            break;
    }
    
    
}

-(void)getHeightFromGoods{
    if (self.goodsListArray.count > 0) {
        CGFloat f = self.goodsListArray.count/2;
        int i = ceil(f);
        if (i > 0) {
            self.height = i * 240+240;
        }else{
            self.height = 240;
        }
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
