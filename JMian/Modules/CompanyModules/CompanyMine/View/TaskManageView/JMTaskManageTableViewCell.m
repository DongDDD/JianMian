//
//  JMTaskManageTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskManageTableViewCell.h"
#import "DimensMacros.h"
@interface JMTaskManageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *headerLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UIImageView *headerRightImgView;
@property (weak, nonatomic) IBOutlet UILabel *infoLab1;
@property (weak, nonatomic) IBOutlet UILabel *infoLab2;
@property (weak, nonatomic) IBOutlet UILabel *infoLab3;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (nonatomic, strong)JMTaskOrderListCellData *myData;

@end

@implementation JMTaskManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(JMTaskOrderListCellData *)data{
    _myData = data;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        
        [self setBHeaderView_data:data];
        [self setBButton_data:data];
        
    }else{
        
        [self setCHeaderView_data:data];
        [self setCButton_data:data];
        
    }
    
}

-(void)setBHeaderView_data:(JMTaskOrderListCellData *)data{
    NSURL *url = [NSURL URLWithString:data.user_avatar];
    [self.iconImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.headerLab.text = data.task_title;
    self.moneyLab.text = [NSString stringWithFormat:@"%@%@",data.payment_money,data.unit];
    self.infoLab1.text = data.user_nickname;
    if (data.snapshot_cityName == nil) {
        self.infoLab2.text = @"不限地区";
    }else{
        self.infoLab2.text = data.snapshot_cityName;
    }
    //职位标签
    NSMutableArray *industryNameArray = [NSMutableArray array];
    for (JMTaskOrderIndustryModel *IndustryData in data.industry) {
        [industryNameArray addObject:IndustryData.name];
    }
    NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
    self.infoLab3.text = [NSString stringWithFormat:@" %@   ",industryStr];
    
}
//------B下半部分

-(void)setBButton_data:(JMTaskOrderListCellData *)data{
    [self.leftBtn setHidden:NO];
    [self.rightBtn setHidden:NO];
    //------待处理
    if ([data.status isEqualToString:Task_WaitDealWith]) {
        [self.leftBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.leftBtn.backgroundColor = TEXT_GRAYmin_COLOR;
        self.leftBtn.layer.borderWidth = 0;
        self.leftBtn.layer.borderColor = TEXT_GRAYmin_COLOR.CGColor;
        
        if ([data.payment_method isEqualToString:@"1"] ) {
            
            [self.rightBtn setTitle:@"通过" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.rightBtn.backgroundColor = MASTER_COLOR;
        }else{
            NSString *str;
            if ([data.front_money isEqualToString:@"0"]) {
                str = @"通过";
            }else{
                str = @"通过&支付定金";
   
                
            }
            [self.rightBtn setTitle:str forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.rightBtn.backgroundColor = MASTER_COLOR;
        }
        //进行中: 已通过
    }else if ([data.status isEqualToString:Task_Pass]) {
        
        if ([data.payment_method isEqualToString:@"1"] ) {
            //销售任务
            [self.leftBtn setHidden:NO];
            [self.rightBtn setHidden:NO];
            [self.leftBtn setTitle:@"和他聊聊" forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            self.leftBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
            self.leftBtn.layer.borderWidth = 0.5;
            self.leftBtn.layer.borderColor = MASTER_COLOR.CGColor;
            
            [self.rightBtn setTitle:@"结束任务" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.rightBtn.backgroundColor = MASTER_COLOR;
            
            
        }else{
            [self.leftBtn setHidden:NO];
            [self.rightBtn setHidden:NO];
            
            [self.leftBtn setTitle:@"和他聊聊" forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            self.leftBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
            self.leftBtn.layer.borderWidth = 0.5;
            self.leftBtn.layer.borderColor = MASTER_COLOR.CGColor;
            
            [self.rightBtn setTitle:@"进行中" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            self.rightBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
            self.rightBtn.layer.borderWidth = 0.5;
            self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
            
        }
        
        //进行中: 对方已完成
    }else if([data.status isEqualToString:Task_Finish]){
        [self.leftBtn setHidden:NO];
        [self.rightBtn setHidden:NO];
        
        [self.leftBtn setTitle:@"和他聊聊" forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        self.leftBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
        self.leftBtn.layer.borderWidth = 0.5;
        self.leftBtn.layer.borderColor = MASTER_COLOR.CGColor;
        NSString *titleStr;
   
    
        if ([data.front_money isEqualToString:@"0"]) {
            titleStr = @"确认对方完成&支付全款";
        }else{
            titleStr = @"确认对方完成&支付尾款";
            
        }
        
        
        
        [self.rightBtn setTitle:titleStr forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightBtn.backgroundColor = MASTER_COLOR;
        
        
        //已结束
    }else if([data.status isEqualToString:Task_DidComfirm]){
        if (![data.payment_method isEqualToString:@"1"]) {
            //            [self.leftBtn setTitle:@"发票申请中..." forState:UIControlStateNormal];
            //            [self.leftBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            //            self.leftBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
            //            self.leftBtn.layer.borderWidth = 0.5;
            //            self.leftBtn.layer.borderColor = MASTER_COLOR.CGColor;
            //            [self.leftBtn setHidden:YES];
            //
            //        }else{
            [self.leftBtn setHidden:YES];
            
        }
        [self.leftBtn setHidden:YES];
        
        //雇员是否评价：0:否 1:是
        if ([data.is_comment_boss isEqualToString:@"0"]) {
            [self.rightBtn setTitle:@"去评价" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.rightBtn.backgroundColor = MASTER_COLOR;
            
        }else{
            [self.rightBtn setTitle:@"已评价" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            self.rightBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
            self.rightBtn.layer.borderWidth = 0.5;
            self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
        }
        
        
    }else if([data.status isEqualToString:Task_Refuse]){
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:NO];
        
        [self.rightBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightBtn.backgroundColor = TEXT_GRAYmin_COLOR;
        self.rightBtn.layer.borderWidth = 0;
        self.rightBtn.layer.borderColor = TEXT_GRAYmin_COLOR.CGColor;
        
    }
    
}



//C端上部分赋值
-(void)setCHeaderView_data:(JMTaskOrderListCellData *)data{
    
    NSURL *url = [NSURL URLWithString:data.snapshot_companyLogo_path];
    [self.iconImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.headerLab.text = data.task_title;
    self.moneyLab.text = [NSString stringWithFormat:@"%@%@",data.payment_money,data.unit];
    if ([data.payment_method isEqualToString:@"1"] ) {
        //网络销售
        self.infoLab1.text = data.goodsTitle;
        self.infoLab2.text = @" 即结  ";
        if (data.snapshot_cityName == nil) {
            self.infoLab3.text =  @" 不限地区  ";
        }else{
            
            self.infoLab3.text =  [NSString stringWithFormat:@" %@  ", data.snapshot_cityName];
        }
    }else{
        //其他兼职
        self.infoLab1.text = data.snapshot_companyName;
        if (data.snapshot_cityName == nil) {
            self.infoLab2.text = @" 不限地区  ";
        }else{
            
            self.infoLab2.text = [NSString stringWithFormat:@" %@  ", data.snapshot_cityName];
        }
        self.infoLab3.text = @" 完工结  ";
    }
    
    
}


//C端下部分按钮状态

-(void)setCButton_data:(JMTaskOrderListCellData *)data{
    
    //------待处理
    if ([data.status isEqualToString:Task_WaitDealWith]) {
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:YES];
        //进行中：已通过
    }else if (([data.status isEqualToString:Task_Pass])){
        
        [self.leftBtn setHidden:NO];
        [self.rightBtn setHidden:NO];
        if ([data.payment_method isEqualToString:@"1"] ) {
            
            [self.leftBtn setTitle:@"和他聊聊" forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            self.leftBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
            self.leftBtn.layer.borderWidth = 0.5;
            self.leftBtn.layer.borderColor = MASTER_COLOR.CGColor;
            
            [self.rightBtn setTitle:@"分享产品链接" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.rightBtn.backgroundColor = MASTER_COLOR;
         
        }else{
            [self.leftBtn setTitle:@"和他聊聊" forState:UIControlStateNormal];
            [self.leftBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            self.leftBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
            self.leftBtn.layer.borderWidth = 0.5;
            self.leftBtn.layer.borderColor = MASTER_COLOR.CGColor;
            [self.rightBtn setTitle:@"已完成(任务ing)" forState:UIControlStateNormal];
            
            self.rightBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
            self.rightBtn.layer.borderWidth = 0.5;
            [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
            
        }
        
        
        
        //进行中：已完成
    } else if ([data.status isEqualToString:Task_Finish]) {
        [self.leftBtn setHidden:NO];
        [self.rightBtn setHidden:NO];
        [self.leftBtn setTitle:@"和他聊聊" forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        self.leftBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
        self.leftBtn.layer.borderWidth = 0.5;
        self.leftBtn.layer.borderColor = MASTER_COLOR.CGColor;
      
        [self.rightBtn setTitle:@"等待对方确认付尾款" forState:UIControlStateNormal];
            
       
        self.rightBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
        self.rightBtn.layer.borderWidth = 0.5;
        [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
        self.rightBtn.enabled = NO;
        
        //已结束
    }else if([data.status isEqualToString:Task_DidComfirm]){
        [self.leftBtn setHidden:NO];
        [self.rightBtn setHidden:NO];
        
        [self.leftBtn setTitle:@"佣金已入账" forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        self.leftBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
        self.leftBtn.layer.borderWidth = 0.5;
        self.leftBtn.layer.borderColor = MASTER_COLOR.CGColor;
        if ([data.is_comment_user isEqualToString:@"0"]) {
            [self.rightBtn setTitle:@"去评价" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.rightBtn.backgroundColor = MASTER_COLOR;
            
        }else{
            [self.rightBtn setTitle:@"已评价" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            self.rightBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:253/255.0 blue:255/255.0 alpha:1.0];
            self.rightBtn.layer.borderWidth = 0.5;
            self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
        }
        
        
    }else if([data.status isEqualToString:Task_Refuse]){
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:NO];
        
        [self.rightBtn setTitle:@"已被拒绝" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightBtn.backgroundColor = TEXT_GRAYmin_COLOR;
        self.rightBtn.layer.borderWidth = 0;
        self.rightBtn.layer.borderColor = TEXT_GRAYmin_COLOR.CGColor;
        
    }
    
    
}

- (IBAction)leftBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(leftActionWithData:)]) {
        [_delegate leftActionWithData:_myData];
    }
}


- (IBAction)rightBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(rightActionWithData:)]) {
        [_delegate rightActionWithData:_myData];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
