//
//  JMCUserProfileConfigure.m
//  JMian
//
//  Created by mac on 2019/12/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCUserProfileConfigure.h"
#import "JMTitlesView.h"

@interface JMCUserProfileConfigure ()
@property(nonatomic,strong)JMTitlesView *titleView;
@property(nonatomic,assign)NSInteger index;
 
@end
@implementation JMCUserProfileConfigure
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)initDataWithSection:(NSInteger)section {
    switch (section) {
        case JMCUserProfileCellTypeHeader:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 240;
            self.cellId = JMUserProfileHeaderTableViewCellIdentifier;
            break;
        case JMCUserProfileCellTypePersonInfo:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 83;
            self.cellId = JMUserProfileImageTableViewCellIdentifier;
            break;
        case JMCUserProfileCellTypeJob:
            if (_viewType == JMCUserProfileCellTypeJobArr) {
                self.rowsNum = self.job_Arr.count;
            }else{
                self.rowsNum = self.abilityListArr.count;
            }
            self.footerheight = 0;
            self.height = 65;
            self.cellId = JMUserProfileJobTableViewCellIdentifier;
            //            self.footerView = [self getFooterView_title:@"添加期望职位"];
            break;
            //
        case JMUserProfileCellTypeEduExp:
            if (self.job_Arr.count > 0) {
                self.rowsNum = 1;
            }else{
                self.rowsNum = 0;
            }
            self.footerheight = 10;
            self.height = 110;
            self.cellId = JMUserProfileEduExpTableViewCellIdentifier;
            break;
        case JMCUserProfileCellTypeIntroduce:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 55;
            self.cellId = JMUserProfileIntroduceTableViewCellIdentifier;
            break;
        default:
            break;
    }

}



- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.rowsNum;
}

- (CGFloat)heightForFooterInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.footerheight;
}

- (CGFloat)heightForRowsInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.height;
}

- (NSString *)cellIdForSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.cellId;
}

-(UIView *)headerViewInSection:(NSInteger)section{
    if (section == JMCUserProfileCellTypePersonInfo) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"    个人信息";
        lab.backgroundColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:16];
        
        return lab;
    }else if (section == JMCUserProfileCellTypeJob) {
        return self.titleView;
//        UILabel *lab = [[UILabel alloc]init];
//        lab.text = @"    公司介绍";
//        lab.backgroundColor = [UIColor whiteColor];
//        lab.font = [UIFont systemFontOfSize:16];
//        return lab;
    }else if (section == JMUserProfileCellTypeEduExp) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"   教育经历";
        lab.backgroundColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:16];
        
        return lab;
    }else if (section == JMCUserProfileCellTypeIntroduce) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"   自我评价";
        lab.backgroundColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:16];
        
        return lab;
    }
    return [UIView new];
}

-(CGFloat)heightForHeaderInSection:(NSInteger)section{
 
    return 55;
}

- (void)didSelectedRowAtSection:(NSInteger)section {
    
}

-(void)showPageContentView{
    if (_delegate && [_delegate respondsToSelector:@selector(userProfileJobTypeWithIndex:)]) {
        [_delegate userProfileJobTypeWithIndex:_index];
    }
    
}

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH/2, 43} titles:@[@"招聘职位", @"兼职任务"]];
        __weak JMCUserProfileConfigure *weakSelf = self;
        _titleView.viewType = JMTitlesViewBlackText;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf showPageContentView];
        };
    }
    
    return _titleView;
}

@end
