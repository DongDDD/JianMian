//
//  JMOrderInfoHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOrderInfoHeaderTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMOrderInfoHeaderTableViewCellIdentifier = @"JMOrderInfoHeaderTableViewCellIdentifier";
@interface JMOrderInfoHeaderTableViewCell ()
 @property(nonatomic,assign)int myOverTime;



@end
@implementation JMOrderInfoHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _activeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(activeCountDownAction) userInfo:nil repeats:YES];
    [_activeTimer fire];

    //    NSLog(@"now%@",now);
    //    NSLog(@"overTime%@",overTime);
    //    NSLog(@"time%ld",(long)time);
    // Do any additional setup after loading the view from its nib.
    
}


-(void)setOverTime:(int)overTime startTime:(NSString *)startTime{
    _myOverTime = overTime;
    [self.timeLab setHidden:NO];
//    NSString *over_time_str  = [self getOverTimeWithOverTime:overTime startTime:startTime];
    NSString *over_time_str = [self getOverTimeWithStartTime:startTime day:overTime];
    NSString *now_time_str = [self getCurrentTimeyyyymmdd];
    _difTime = [self getDateDifferenceWithNowDateStr:now_time_str deadlineStr:over_time_str];
 
}

 

-(void)activeCountDownAction{
    _difTime--;
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", _difTime / 3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (_difTime % 3600) / 60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld", _difTime % 60];
    NSInteger hour = [str_hour integerValue];
    NSString *day = [NSString stringWithFormat:@"%02ld", hour / 24];
    NSString *hour2 = [NSString stringWithFormat:@"%02ld", (hour % 24)];//小时

//    NSString *str_hour2 = [NSString stringWithFormat:@"%02ld", hour / 24];

     self.topTime = [NSString stringWithFormat:@"%@天%@小时 %@分 %@秒", day,hour2, str_minute, str_second];
//    NSLog(@"format_time:%@",format_time);
//    if (_viewType == JMOrderInfoHeadeTypeDidDeliverGoods) {
//        self.timeLab.text =[ NSString stringWithFormat:@"你还有%@ 来确认收货，超时订单自动确认收货", self.topTime];
//
//    }else if (_viewType == JMOrderInfoHeadeTypeTakeDeliveryGoods) {
//        self.timeLab.text =[ NSString stringWithFormat:@"根据《消费者权益保护法》您还有%@ ，无理由退货", self.topTime];
//
//    }
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([_titleLab.text isEqualToString:@"已发货"]) {
        if ([userModel.type isEqualToString:C_Type_USER] && self.isExtension) {
            self.timeLab.text =[ NSString stringWithFormat:@"距离佣金解冻时间还有%@", self.topTime];
        }else{
            self.timeLab.text =[ NSString stringWithFormat:@"距离货款解冻时间还有%@", self.topTime];
        }
    }else if([_titleLab.text isEqualToString:@"已收货"]) {
        
        if ([userModel.type isEqualToString:C_Type_USER] || self.isExtension) {
            if (self.isExtension) {
                self.timeLab.text =[ NSString stringWithFormat:@"根据《消费者权益保护法》您还有%@ ，无理由退货", self.topTime];
                 
            }else{
                self.timeLab.text =[ NSString stringWithFormat:@"根据平台相关规定资金将在本平台冻结%@ 后解冻到账", self.topTime];
            }
        }else{
            self.timeLab.text =[ NSString stringWithFormat:@"根据平台相关规定资金将在本平台冻结%@ 后解冻到账", self.topTime];
            
        }
        
        
    }
    
    
//    if (_myOverTime == 10) {//已发货
////        self.timeLab.text =[ NSString stringWithFormat:@"你还有%@ 来确认收货，超时订单自动确认收货", self.topTime];
//        if ([userModel.type isEqualToString:C_Type_USER]) {
//            if ([_titleLab.text isEqualToString:@"已发货"]) {
//                self.timeLab.text =[ NSString stringWithFormat:@"距离佣金解冻时间还有%@天", self.topTime];
//
//            }
//        }
//
//    }else
//        if (_myOverTime == 15) {//已收货
//
//
//    }

 }
- (NSString *)getCurrentTimeyyyymmdd {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
}

//-(NSString *)getOverTimeWithOverTime:(int)overTime startTime:(NSString *)startTime{
//    NSString *birthdayStr= startTime;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
//    NSDate *currentDate = [dateFormatter dateFromString:birthdayStr];
//
//
////    NSDate *currentDate = [NSDate date];
//    int days = overTime;    // n天后的天数
//    NSDate *appointDate;    // 指定日期声明
//    NSTimeInterval oneDay = 24 * 60 * 60;  // 一天一共有多少秒
//    appointDate = [currentDate initWithTimeIntervalSinceNow: oneDay * days];
//    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
//     formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//     NSString *dayStr = [formatDay stringFromDate:appointDate];
//    return dayStr;
//
//}

- (NSString *)getOverTimeWithStartTime:(NSString *)startTime day:(NSInteger)day {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSDate *startTimeDate = [dateFormatter dateFromString:startTime];
    
    NSTimeInterval days = 24 * 60 * 60 * day;  // 一天一共有多少秒
    NSDate *appointDate = [startTimeDate dateByAddingTimeInterval:days];
 
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter2 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题

    NSString *strDate = [dateFormatter2 stringFromDate:appointDate];
    return strDate;
}

- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    NSInteger timeDifference = 0;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    return timeDifference;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
