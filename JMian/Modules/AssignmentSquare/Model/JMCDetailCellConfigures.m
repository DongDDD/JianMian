//
//  JMCDetailCellConfigures.m
//  JMian
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailCellConfigures.h"
#import "DimensMacros.h"

@implementation JMCDetailCellConfigures

//- (void)initDataWithSection:(NSInteger)section {
//    switch (section) {
//        case 0:
//            self.rowsNum = 1;
//            self.footerheight = 10;
//            self.height = 105;
//            self.cellId = JMTaskDetailHeaderTableViewCellIdentifier;
//            break;
//        case 1:
//            self.rowsNum = 4;
//            self.footerheight = 10;
//            self.height = 105;
//            self.cellId = JMTaskDetailHeaderTableViewCellIdentifier;
//            break;
//        default:
//            break;
//    }
//
//}
//-(UIView *)headerViewInSection:(NSInteger)section{
//    
//    
//    
//    
//}



- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        //公司信息
        return 1;
    }else if (section == 1) {
        //详情描述，视频
        return 3;
    }else if (section == 2) {
        //图片
        NSMutableArray *imgArr = [NSMutableArray array];
        for (JMCDetailImageModel *imgModel in self.model.images) {
            if ([imgModel.status isEqualToString:@"2"]) {
                [imgArr addObject:imgModel];
            }
        }
        NSLog(@"图片有%lu张",(unsigned long)self.model.images.count);
        return imgArr.count;
    }else if (section == 3) {
        if (self.model.latitude.length > 0 && self.model.longitude.length > 0) {
            return 1;
        }else{
            return 0;
        }
    }else if (section == 4) {
        //信誉评价
        NSLog(@"评论有%lu条",(unsigned long)self.commentListArray.count);
        if (self.commentListArray.count) {
            return self.commentListArray.count;
            
        }else{
            return 1;
        }
    }
    return 0;
}

//- (UIView *)footerViewInSection:(NSInteger)section {
//    [self initDataWithSection:section];
//    return self.footerView;
//}

//- (CGFloat)heightForFooterInSection:(NSInteger)section {
//    [self initDataWithSection:section];
//    return self.footerheight;
//}

- (CGFloat)heightForRowsInSection:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
        return 95;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //任务描述
            return 299;
        }else  if (indexPath.row == 1) {
            //任务描述或者产品描述
//            CGFloat F = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:self.model.myDescription andFont:[UIFont systemFontOfSize:14] andLinespace:10];
//            NSLog(@"FFFFF:%f",F);
            return [self getHeightFromDecri];
        }else if (indexPath.row == 2) {
            //视频
            if (self.model.video_file_path) {
                return 283;
            }else{
                return 0;
            }
        }
    }else if (indexPath.section == 2) {
        //图片
//        __weak JMCDetailImageModel *weakSelf = self;
        NSMutableArray *imgArr = [NSMutableArray array];
        for (JMCDetailImageModel *imgModel in self.model.images) {
            if ([imgModel.status isEqualToString:@"2"]) {
                [imgArr addObject:imgModel];
            }
        }
        JMCDetailImageModel *imgModel = imgArr[indexPath.row];
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgModel.file_path] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"宽：%f, 高：%f", image.size.width, image.size.height);
            self.height = image.size.height;
        }];
        return self.height;
    }else if (indexPath.section == 3) {
        //公司地址
        return 400;
    }else if (indexPath.section == 4) {
        //信誉评价
        return 139;
    }
    return 0;
}

- (NSString *)cellIdForSection:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        return JMTaskDetailHeaderTableViewCellIdentifier;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return JMTaskDetailHeaderTableViewCellIdentifier;
        }else  if (indexPath.row == 1) {
            return JMTaskDetailHeaderTableViewCellIdentifier;
        }
    }else if (indexPath.section == 2) {
        return JMTaskDetailHeaderTableViewCellIdentifier;
        
    }
    return self.cellId;
}

-(CGFloat)getHeightFromDecri{
    if ([self.model.payment_method isEqualToString:@"3"]) {
        //普通任务
        CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:self.model.myDescription andFont:[UIFont systemFontOfSize:14] andLinespace:10];
        NSLog(@"FFFFF:%f",H);
        return H + 100;
    }else if ([self.model.payment_method isEqualToString:@"1"]) {
        //销售任务
        CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:self.model.goods_description andFont:[UIFont systemFontOfSize:14] andLinespace:10];
        NSLog(@"FFFFF:%f",H);
        return H + 280;
    }else{
        return 0;
    }
    
}

//-(CGFloat)heightForRowsInRow:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0){
//        return 105;
//    }else if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            return 299;
//        }else  if (indexPath.row == 1) {
//            return 100;
//        }
//    }else if (indexPath.section == 2) {
//        return 105;
//
//    }
//    return 0;
//}

//- (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font {
//    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:14]} context:nil];
//    return rect.size.height;
//
//}


//- (float) heightForString:(NSString *)value andWidth:(float)width{
//    //获取当前文本的属性
//    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
////    _text.attributedText = attrStr;
//    NSRange range = NSMakeRange(0, attrStr.length);
//    // 获取该段attributedString的属性字典
//    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
//    // 计算文本的大小
//    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
//                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
//                                        attributes:dic        // 文字的属性
//                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
//    return sizeToFit.height + 50;
//}


//- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize
//
//{
//
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
//
//    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 0)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
//
//                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
//
//    return rect.size.height+86;
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
