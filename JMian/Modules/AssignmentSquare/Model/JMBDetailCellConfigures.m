//
//  JMBDetailCellConfigures.m
//  JMian
//
//  Created by mac on 2019/9/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBDetailCellConfigures.h"
#import "DimensMacros.h"
@interface JMBDetailCellConfigures ()
@property (assign, nonatomic) CGFloat height;

@end
@implementation JMBDetailCellConfigures


- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        // 个人信息
        return 1;
    }else if (section == 1) {
        //工作描述
        return 1;
    }else if (section == 2) {
        //图片
        if (self.model.images.count > 0) {
            NSMutableArray *imgArr = [NSMutableArray array];
            for (JMCDetailImageModel *imgModel in self.model.images) {
                if ([imgModel.status isEqualToString:@"2"]) {
                    [imgArr addObject:imgModel];
                }
            }
            NSLog(@"图片有%lu张",(unsigned long)self.model.images.count);
            return imgArr.count;
            
        }else{
            return 1;
        }
    }else if (section == 3) {
        //评论
        NSLog(@"评论有%lu条",(unsigned long)self.commentListArray.count);
        if (self.commentListArray.count) {
            return self.commentListArray.count;
            
        }else{
            return 1;
        }
    }
    return 0;
}


- (CGFloat)heightForRowsInSection:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
        //个人信息
        return 163;;
        
    }else if (indexPath.section == 1) {
        //自我介绍
        return [self getHeightFromDecri];
        
    }else if (indexPath.section == 2) {
        //图片作品
        if (self.model.images.count > 0) {
            __weak JMCDetailImageModel *weakSelf = self;
            NSMutableArray *imgArr = [NSMutableArray array];
            for (JMBDetailImageModel *imgModel in self.model.images) {
                if ([imgModel.status isEqualToString:@"2"]) {
                    [imgArr addObject:imgModel];
                }
            }
            
            JMCDetailImageModel *imgModel = imgArr[indexPath.row];
            UIImageView *imageView = [[UIImageView alloc]init];

            [imageView sd_setImageWithURL:[NSURL URLWithString:imgModel.file_path] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"宽：%f, 高：%f", image.size.width, image.size.height);
                CGFloat imgHeight = image.size.height * SCREEN_WIDTH / image.size.width;
                self.height = imgHeight;
            }];
 
            
            //手动计算cell
            return self.height;

            
        }else{
            return 200;

        }
    }else if (indexPath.section == 3) {
        if (self.commentListArray.count > 0) {
            return 139;
            
        }else{
            return 44;
            
        }
    }
    return 0;
}


//自我介绍描述高度
-(CGFloat)getHeightFromDecri{
    //销售任务
        CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:self.model.myDescription andFont:[UIFont systemFontOfSize:14] andLinespace:10];
        NSLog(@"FFFFF:%f",H);
        return H+75;
    
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
