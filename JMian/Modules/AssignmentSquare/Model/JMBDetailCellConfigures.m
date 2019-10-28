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
//@property (assign, nonatomic) BOOL isGetH;

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
        NSMutableArray *imgArr = [NSMutableArray array];
        for (JMCDetailImageModel *imgModel in self.model.images) {
            if ([imgModel.status isEqualToString:@"2"]) {
                [imgArr addObject:imgModel];
            }
        }
        if (imgArr.count > 0) {
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
        NSMutableArray *imgArr = [NSMutableArray array];
        for (JMBDetailImageModel *imgModel in self.model.images) {
            if ([imgModel.status isEqualToString:@"2"]) {
                [imgArr addObject:imgModel];
            }
        }
        if (imgArr.count > 0) {
//            __weak JMCDetailImageModel *weakSelf = self;
            //审核通过的照片数组imgArr
                JMCDetailImageModel *imgModel = imgArr[indexPath.row];
                NSLog(@"图片加载完了2");
                NSLog(@"高：%f", self.height);
                if (self.height == 0) {
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgModel.file_path]];
                    UIImage *showimage = [UIImage imageWithData:data];
                    self.height = showimage.size.height * SCREEN_WIDTH / showimage.size.width;
                }
                return self.height;
            //手动计算cell
//            return [self getHeightFromImgWithUrl:imgModel.file_path];
            
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

-(CGFloat)getHeightFromImgWithUrl:(NSString *)url{

    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat imgHeight = image.size.height * SCREEN_WIDTH / image.size.width;
        NSLog(@"宽：%f, 高：%f", image.size.width, self.height);
        self.height = imgHeight;
        NSLog(@"图片加载完了1");
        
    }];
//    if (!_isGetH && self.height == 0) {
//        if (_delegate && [_delegate respondsToSelector:@selector(didGetPicH)]) {
//            [_delegate didGetPicH];
//        }
//        _isGetH = YES;
//    }
    return self.height;
    
}


//自我介绍描述高度
-(CGFloat)getHeightFromDecri{
    //销售任务
        CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:self.model.myDescription andFont:[UIFont systemFontOfSize:14] andLinespace:10];
        NSLog(@"FFFFF:%f",H);
        return H+90;
    
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
