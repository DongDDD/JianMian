//
//  JMCompanyHomeTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyHomeTableViewCell.h"
#import "DimensMacros.h"

@interface JMCompanyHomeTableViewCell ()

@property(nonatomic,strong)JMCompanyHomeModel *myModel;

@end


@implementation JMCompanyHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}


-(void)setModel:(JMCompanyHomeModel *)model{
    _myModel = model;
    self.jobNameLab.text = model.userNickname;
     [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.userAvatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
  
    NSString *salaryStr = [self getSalaryStrWithMin:model.salary_min max:model.salary_max];
    self.jobDetailLab.text = model.workName;
    self.salaryLab.text = salaryStr;
    self.educationLab.text = [self getEducationStrWithEducation:model.vitaEducation];
    self.subDecription.text = model.vita_description;
    if (model.video_file_path == nil) {
        [self.playBtn setHidden:YES];
    }else{
         [self.playBtn setHidden:NO];
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            
//            NSURL *url = [NSURL URLWithString:model.video_file_path];
//            //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
//            AVPlayer *player = [AVPlayer playerWithURL:url];
//            self.player = player;
//        });
        
    }

    
}

//-(void)loadPlayer{
//    NSURL *url = [NSURL URLWithString:@"https://jmsp-1258537318.picgz.myqcloud.com//storage//images//2019//05//13//K7xxhMIVfIbCgHGOHFqmIN8cGMh9QRw32luiKRJ3.mp4"];
//    //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
//    AVPlayer *player = [AVPlayer playerWithURL:url];
//    self.player = player;
////    //创建AVPlayerViewController控制器
////    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
////    playerVC.player = player;
////
//////    playerVC.view.frame = self.view.frame;
//////    [self.view addSubview:playerVC.view];
////    self.playerVC = playerVC;
//    //调用控制器的属性player的开始播放方法
////    [self.playerVC.player play];
//
//
//}

//工资数据转化，除以1000，转化成k
-(NSString *)getSalaryStrWithMin:(id)min max:(id)max{
    NSInteger myint = [min integerValue];
    NSInteger intMin = myint/1000;
    
    NSInteger myint2 = [max integerValue];
    NSInteger intMax = myint2/1000;
    
    NSString *salaryStr;
    salaryStr = [NSString stringWithFormat:@"%dk~%dk",  (int)intMin, (int)intMax];
    
    return salaryStr;
}

//学历数据转化
-(NSString *)getEducationStrWithEducation:(NSString *)education{
    NSInteger myInt = [education integerValue];
    
    switch (myInt) {
        case 0:
            return @"不限";
            break;
        case 1:
            return @"初中及以下";
            break;
        case 2:
            return @"中专/中技";
            break;
        case 3:
            return @"高中";
            break;
        case 4:
            return @"大专";
            break;
        case 5:
            return @"本科";
            break;
        case 6:
            return @"硕士";
            break;
        case 7:
            return @"博士";
            break;
            
        default:
            break;
    }
    return @"不限";
    
}


- (IBAction)playAction:(UIButton *)sender {
 
    if (_delegate && [_delegate respondsToSelector:@selector(playAction_cell:model:)]) {
        
        [_delegate playAction_cell:self model:_myModel];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
