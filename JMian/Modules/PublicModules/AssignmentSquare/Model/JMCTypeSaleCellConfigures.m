//
//  JMCTypeSaleCellConfigures.m
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMCTypeSaleCellConfigures.h"
#import "DimensMacros.h"

@implementation JMCTypeSaleCellConfigures

-(void)initDataWithSection:(NSInteger)section{
    switch (section) {
        case JMCTypeSaleCellTypeHeader:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.headerheight = 1;
            self.height = 116;
//            self.cellId = JMMyStoreTitleHeaderTableViewCellIdentifier;
            break;
        case JMCTypeSaleCellTypeTaskDesc1:
            self.rowsNum = 1;
            self.footerheight = 0;
            if (_isSnapshoot) {
                self.headerheight = 60;
            }else{
                self.headerheight = 44;
            }
          [self getHeightForDesc1];
          //  self.cellId = JMMyStoreOrderStatusTableViewCellIdentifier;
            break;
        case JMCTypeSaleCellTypeTaskDesc2:
            self.rowsNum = 1;
            self.footerheight = 1;
            self.headerheight = 0;
            self.height = [self getHeightForDesc2];
            //self.cellId = JMMyStoreManager1TableViewCellIdentifier;
            break;
        case JMCTypeSaleCellTypeMyStoreHeader:
            self.rowsNum = 1;
            self.footerheight = 1;
            self.headerheight = 1;
            self.height = 153;
            //self.cellId = JMMyStoreManager2TableViewCellIdentifier;
            break;
        case JMCTypeSaleCellTypeMyStoreGoods:
            self.rowsNum = 1;
            self.footerheight = 1;
            self.headerheight = 1;
            self.height = 700;
            [self getHeightFromGoods];
            //self.cellId = JMMyStoreManager2TableViewCellIdentifier;
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

- (CGFloat)heightForHeaderInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.headerheight;
}

 - (CGFloat)heightForRowsInSection:(NSInteger)section {
     [self initDataWithSection:section];
     return self.height;
 }

 - (NSString *)cellIdForSection:(NSInteger)section {
     [self initDataWithSection:section];
     return self.cellId;
 }

-(CGFloat)getHeightForDesc2{
     if ([self.model.payment_method isEqualToString:@"1"]) {
        //销售任务
        CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:self.model.myDescription andFont:[UIFont systemFontOfSize:14] andLinespace:8];
        NSLog(@"FFFFF:%f",H);
        return H+100;
    }else{
        return 0;
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

-(void)getHeightForDesc1{
    if (self.model.goods.count > 0) {
        self.height = 280;
    }else{
        self.height = 250;
        
    }
    
    
}

- (CGFloat)boundingRectWithSize:(CGSize)size WithStr:(NSString*)string andFont:(UIFont *)font andLinespace:(CGFloat)space
{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:space];
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
    CGSize retSize = [string boundingRectWithSize:size
                                          options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    return retSize.height;
}

@end
