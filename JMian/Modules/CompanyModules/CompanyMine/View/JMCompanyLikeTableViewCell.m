//
//  JMCompanyLikeTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyLikeTableViewCell.h"
#import "DimensMacros.h"
#import "Masonry.h"
#import "JMUserInfoModel.h"
#import "JMUserInfoManager.h"

@implementation JMCompanyLikeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   if( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] )
   {
       JMUserInfoModel *userinfoModel = [JMUserInfoManager getUserInfo];
       
       if ([userinfoModel.type isEqualToString:C_Type_USER]) {
           
           
       }else if ([userinfoModel.type isEqualToString:B_Type_UESR]){
           
           
       }
       
   }
    
    return self;
}

//C端面试列表状态
-(void)init_C_TypeViewWith:(NSString *)status
{
    
    
    
}


//C端面试列表状态
-(void)init_B_TypeViewWith:(NSString *)status
{
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
