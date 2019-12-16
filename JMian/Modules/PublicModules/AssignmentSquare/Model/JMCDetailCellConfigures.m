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



- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        //公司信息
        return 1;
    }else if (section == 1) {
        //详情描述，视频
        return 3;
    }else if (section == 2) {
        //图片
        if (self.model.images.count > 0) {
//            NSMutableArray *imgArr = [NSMutableArray array];
//            for (JMCDetailImageModel *imgModel in self.model.images) {
//                if ([imgModel.status isEqualToString:@"2"]) {
//                    [imgArr addObject:imgModel];
//                }
//            }
            NSLog(@"图片有%lu张",(unsigned long)self.model.images.count);
            return self.model.images.count;
        }else{
            return 1;
        }
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

- (CGFloat)heightForRowsInSection:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
        return 95;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //任务描述
            return 299;
        }else  if (indexPath.row == 1) {
            //任务描述或者产品描述
//            NSLog(@"FFFFF:%f",F);
            return [self getHeightFromDecri];
        }else if (indexPath.row == 2) {
            //视频
            if (self.model.video_file_path) {
                return 300;
            }else{
                return 0;
            }
        }
    }else if (indexPath.section == 2) {
        //图片
//        __weak JMCDetailImageModel *weakSelf = self;
        if (self.model.images.count > 0) {
//            NSMutableArray *imgArr = [NSMutableArray array];
//            for (JMCDetailImageModel *imgModel in self.model.images) {
//                if ([imgModel.status isEqualToString:@"2"]) {
//                    [imgArr addObject:imgModel];
//                }
//            }
            JMCDetailImageModel *imgModel = self.model.images[indexPath.row];
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgModel.file_path] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"宽：%f, 高：%f", image.size.width, image.size.height);
                CGFloat imgHeight = image.size.height * SCREEN_WIDTH / image.size.width;
                self.height = imgHeight;
            }];
            return self.height;
            
        }else{
            //没有图片 默认高度
            return 188;

        }
    }else if (indexPath.section == 3) {
        //公司地址
        return 400;
    }else if (indexPath.section == 4) {
        //信誉评价
        if (self.commentListArray.count > 0) {
            return 139;
            
        }else{
            return 44;

        }
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
        CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:self.model.myDescription andFont:[UIFont systemFontOfSize:14] andLinespace:8];
        NSLog(@"FFFFF:%f",H);
        return H + 100;
    }else if ([self.model.payment_method isEqualToString:@"1"]) {
        //销售任务
        CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:self.model.goods_description andFont:[UIFont systemFontOfSize:14] andLinespace:8];
        NSLog(@"FFFFF:%f",H);
        return H + 280;
    }else{
        return 0;
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
