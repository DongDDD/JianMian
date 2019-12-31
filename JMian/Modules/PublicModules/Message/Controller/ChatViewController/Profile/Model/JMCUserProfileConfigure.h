//
//  JMCUserProfileConfigure.h
//  JMian
//
//  Created by mac on 2019/12/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMUserProfileHeaderTableViewCell.h"//头部信息
#import "JMUserProfileImageTableViewCell.h"//公司图片
//#import "JMScrollviewTableViewCell.h"//公司图片
#import "JMUserProfilePersonInfoTableViewCell.h"//个人信息
#import "JMUserProfileJobTableViewCell.h"//全职/兼职
//#import "JMUserProfilePartimeJobTableViewCell.h"//兼职
#import "JMUserProfileEduExpTableViewCell.h"//教育经历
#import "JMUserProfileIntroduceTableViewCell.h"//个人介绍/公司简介
//#import "JMUserProfileAdressTableViewCell.h"
//#import "JMCompanyInfoModel.h"
#import "JMTaskListCellData.h"
//#import "JMVitaDetailModel.h"


NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMCUserProfileCellType){
    JMCUserProfileCellTypeHeader = 0 ,
    JMCUserProfileCellTypePersonInfo,
//    JMCUserProfileCellTypeImage,
    JMCUserProfileCellTypeJob,
    JMUserProfileCellTypeEduExp,
    JMCUserProfileCellTypeIntroduce,
//    JMCUserProfileCellTypeAdress
};
typedef NS_ENUM(NSInteger, JMCUserProfileCellJobType){
    JMCUserProfileCellTypeJobArr = 0 ,
    JMCUserProfileCellTypeAbilityArr,

};
@protocol JMCUserProfileConfigureDelegate <NSObject>

-(void)userProfileJobTypeWithIndex:(NSInteger)index;

@end

@interface JMCUserProfileConfigure : NSObject
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat footerheight;
@property (nonatomic,assign)JMCUserProfileCellJobType viewType;
@property (assign, nonatomic) NSInteger rowsNum;
@property (assign, nonatomic) NSInteger section;
@property (copy, nonatomic) NSString *cellId;
@property(nonatomic,weak)id<JMCUserProfileConfigureDelegate>delegate;
@property(nonatomic,strong)NSArray *job_Arr;//全职
@property(nonatomic,strong)NSArray *abilityListArr;//兼职

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (UIView *)headerViewInSection:(NSInteger)section;

- (CGFloat)heightForRowsInSection:(NSInteger)section;

- (NSString *)cellIdForSection:(NSInteger)section;


- (void)didSelectedRowAtSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
