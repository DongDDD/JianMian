//
//  JMPersonInfoConfigures.m
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPersonInfoConfigures.h"
#import "DimensMacros.h"

@implementation JMPersonInfoConfigures


- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        //视频
        if (![self.model.video_status isEqualToString:@"2"] && self.model.video_file_path.length > 0) {
            return 0;
        }
    }
    if (section == 3) {
        //工作经历
        return self.model.experiences.count;
    }else if (section == 5) {
        //教育经历
        return self.model.education.count;
    }
    return 1;
}

- (CGFloat)heightForRowsInSection:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        //个人信简介
        return 90;;
        
    }else if (indexPath.section == 1) {
        //视频
        if ([self.model.video_status isEqualToString:@"2"] && self.model.video_file_path.length > 0) {
            return 401;
        }else{
            return 0;
        }
    }else if (indexPath.section == 2) {
        //求职意向
        return 260;
    }else if (indexPath.section == 3) {
        //工作经历
        JMExperiencesModel *expModel = self.model.experiences[indexPath.row];
        
        return [self getHeightWithWorkExp:expModel.experiences_description];
//        return 222;

    }else if (indexPath.section == 4) {
        //自我描述
        return [self getHeightWithVitaDescri:self.model.vita_description];
//        return 222;

    }else if (indexPath.section == 5) {
        //教育经历
        return 100;
    }else if (indexPath.section == 6) {
        //联系方式
        return SCREEN_HEIGHT-100;
    }
    return 0;
}

//自我描述计算高度
-(CGFloat)getHeightWithVitaDescri:(NSString *)vitaDescri{
  
    CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:vitaDescri andFont:[UIFont systemFontOfSize:14] andLinespace:5];
    NSLog(@"FFFFF:%f",H);
    return H+90;
}

//工作经历
-(CGFloat)getHeightWithWorkExp:(NSString *)workExp{
   
    CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, 0) WithStr:workExp andFont:[UIFont systemFontOfSize:14] andLinespace:5];
    NSLog(@"FFFFF:%f",H);
    return H+190;
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
