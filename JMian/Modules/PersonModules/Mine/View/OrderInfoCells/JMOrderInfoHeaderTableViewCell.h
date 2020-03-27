//
//  JMOrderInfoHeaderTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
 
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMOrderInfoHeaderTableViewCellIdentifier;

@interface JMOrderInfoHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property(nonatomic,strong)NSTimer *activeTimer;
@property(nonatomic,assign)NSInteger difTime;
@property(nonatomic,copy)NSString *sendTime;//发货时间

@property(nonatomic,assign)int overTime;
@property(nonatomic,assign)int isExtension;

-(void)setOverTime:(int)overTime startTime:(NSString *)startTime;

@property(nonatomic,copy)NSString *topTime;


@end

NS_ASSUME_NONNULL_END
