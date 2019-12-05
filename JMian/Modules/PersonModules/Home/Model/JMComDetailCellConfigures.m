//
//  JMComDetailCellConfigures.m
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMComDetailCellConfigures.h"
#import "DimensMacros.h"

@implementation JMComDetailCellConfigures
- (CGFloat)heightForRowsInSection:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 217;
    }
    if (indexPath.section ==1) {
        if (self.model.work.count > 0) {
            return 142;
        }else{
            return 200;
            
        }
    }
    
    
    if (indexPath.section ==2) {
        if (indexPath.row == 0) {
            return [self getHeightFromDecri];
            
        }else if (indexPath.row == 1) {
            NSMutableArray *imagesURLStrings = [NSMutableArray array];
            for (JMFilesModel *filesModel in self.model.files) {
                if ([filesModel.files_type isEqualToString:@"2"]) {
                    [imagesURLStrings addObject:filesModel.files_file_path];
                }
                
            }
            if (imagesURLStrings.count > 0) {
                return 211;
            }else{
                
                return 0;
            }

        }else if (indexPath.row == 2) {
            //地址
            return 400;

        }else if (indexPath.row == 3) {
            //公司视频
            if (self.model.video.count == 0) {
                return 77;
            }else{
                return 537;
                
            }
           

        }
    }
    return 0;
}


- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        if (self.model.work.count > 0) {
            return self.model.work.count;
             
        }else{
            return 1;
        }
    }else if (section == 2) {
        return 4;
    }
    return 0;
    
}

-(CGFloat)getHeightFromDecri{
//    CGFloat H = 0.0;
    if (self.model.comDescription.length > 0) {
       CGFloat H = [self boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) WithStr:self.model.comDescription andFont:[UIFont systemFontOfSize:14] andLinespace:10];
        NSLog(@"FFFFF:%f",H);
        return H + 200;
        
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
