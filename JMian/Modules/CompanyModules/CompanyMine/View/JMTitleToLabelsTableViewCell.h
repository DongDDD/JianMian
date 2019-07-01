//
//  JMTitleToLabelsTableViewCell.h
//  JMian
//
//  Created by mac on 2019/7/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMLabsData.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMTitleToLabelsTableViewCellPartTimeJob,
    JMTitleToLabelsTableViewCellTypeHome,
} JMTitleToLabelsTableViewCellType;
@protocol JMTitleToLabelsTableViewCellDelegate <NSObject>

-(void)didSelectItemWithData:(JMLabsData *)data;

@end


@interface JMTitleToLabelsTableViewCell : UITableViewCell
@property(nonatomic,strong)JMLabsData *labsData;
@property(nonatomic,weak)id<JMTitleToLabelsTableViewCellDelegate>delegate;
//@property(nonatomic,assign)JMTitleToLabelsTableViewCellType viewType;
-(void)setLabsData:(JMLabsData *)labsData myVc:(id)myVc;
@end

NS_ASSUME_NONNULL_END
