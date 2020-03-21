//
//  JMGoodsDetailConfigures.m
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsDetailConfigures.h"
#import "DimensMacros.h"

@implementation JMGoodsDetailConfigures

-(void)initDataWithSection:(NSInteger)section{
    switch (section) {
        case JMGoodsDetailCellTypeSDC:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.headerheight = 1;
            self.height = 375;
//            self.cellId = JMMyStoreTitleHeaderTableViewCellIdentifier;
            break;
        case JMGoodsDetailCellTypeTitle:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.headerheight = 0;
            self.height = 153;
          //  self.cellId = JMMyStoreOrderStatusTableViewCellIdentifier;
            break;
        case JMGoodsDetailCellTypeVideo:
            self.rowsNum = 1;
            self.footerheight = 1;
            self.headerheight = 0;
            self.height = 260;
            //self.cellId = JMMyStoreManager2TableViewCellIdentifier;
            break;
        case JMGoodsDetailCellTypeDesc:
            self.rowsNum = 1;
            self.footerheight = 1;
            self.headerheight = 0;
            self.height = self.webViewHeight+20;
            //            self.height = 100;
            
            //self.cellId = JMMyStoreManager1TableViewCellIdentifier;
            break;
//        case JMGoodsDetailCellTypeImages:
//            self.rowsNum = self.model.images.count;
//            self.footerheight = 1;
//            self.headerheight = 1;
//            self.height = 500;
//            //self.cellId = JMMyStoreManager2TableViewCellIdentifier;
//            break;
        case JMGoodsDetailCellTypeMicrotitle:
            self.rowsNum = 1;
            self.footerheight = 1;
            self.headerheight = 0;
            self.height = 45;
            //self.cellId = JMMyStoreManager2TableViewCellIdentifier;
            break;
        case JMGoodsDetailCellTypeStoreGoods:
            self.rowsNum = 1;
            self.footerheight = 1;
            self.headerheight = 1;
//            self.height = 300;
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

-(CGFloat)getHeightFromDecri{
    CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:@"" andFont:[UIFont systemFontOfSize:14] andLinespace:8];
    NSLog(@"FFFFF:%f",H);
    return H+100;
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
//-(CGFloat)getHeightFromImage{
//    JMGoodsInfoImageModel *imgModel = self.model.images[indexPath.row];
//    UIImageView *imageView = [[UIImageView alloc]init];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:imgModel.file_path] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"宽：%f, 高：%f", image.size.width, image.size.height);
//        CGFloat imgHeight = image.size.height * SCREEN_WIDTH / image.size.width;
//        self.height = imgHeight;
//    }];
//
//}



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
