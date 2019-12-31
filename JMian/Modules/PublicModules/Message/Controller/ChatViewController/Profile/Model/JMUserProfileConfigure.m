//
//  JMUserProfileConfigure.m
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserProfileConfigure.h"
#import "JMTitlesView.h"

@interface JMUserProfileConfigure ()
@property(nonatomic,strong)JMTitlesView *titleView;
@property(nonatomic,assign)NSInteger index;
 
@end
@implementation JMUserProfileConfigure
//JMUserProfileCellTypeHeader = 0 ,
//JMUserProfileCellTypePersonInfo,
//JMUserProfileCellTypeImage,
//JMUserProfileCellTypeJob,
//JMUserProfileCellTypePartimeJob,
//JMUserProfileCellTypeEduExp,
//JMUserProfileCellTypeIntroduce,
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)initDataWithSection:(NSInteger)section {
    switch (section) {
        case JMUserProfileCellTypeHeader:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 260;
            self.cellId = JMUserProfileHeaderTableViewCellIdentifier;
            break;
        case JMUserProfileCellTypeImage:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 228;
            self.cellId = JMUserProfileImageTableViewCellIdentifier;
            break;
        case JMUserProfileCellTypeJob:
            if (_viewType == JMUserProfileCellTypeJobArr) {
                self.rowsNum = self.model.work.count;
            }else{
                self.rowsNum = self.taskListArr.count;
            }
            self.footerheight = 0;
            self.height = 65;
            self.cellId = JMUserProfileJobTableViewCellIdentifier;
//            self.footerView = [self getFooterView_title:@"添加期望职位"];
            break;
//
        case JMUserProfileCellTypeIntroduce:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 55;
            self.cellId = JMUserProfileIntroduceTableViewCellIdentifier;
            break;
        case JMUserProfileCellTypeAdress:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 60;
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
    if (section == JMUserProfileCellTypeImage) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"    公司图片";
        lab.backgroundColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:16];
        
        return lab;
    }else if (section == JMUserProfileCellTypeIntroduce) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"    公司介绍";
        lab.backgroundColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:16];
        return lab;
    }else if (section == JMUserProfileCellTypeJob) {
        return self.titleView;
//        UILabel *lab = [[UILabel alloc]init];
//        lab.text = @"    公司介绍";
//        lab.backgroundColor = [UIColor whiteColor];
//        lab.font = [UIFont systemFontOfSize:16];
//        return lab;
    }
    return [UIView new];
}

-(CGFloat)heightForHeaderInSection:(NSInteger)section{
    if (section == JMUserProfileCellTypeImage) {
        return 55;
    }else if (section == JMUserProfileCellTypeIntroduce) {
        return 55;
    }else if (section == JMUserProfileCellTypeJob) {
        return 55;
    }
    return 0;
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
        __weak JMUserProfileConfigure *weakSelf = self;
        _titleView.viewType = JMTitlesViewBlackText;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf showPageContentView];
        };
    }
    
    return _titleView;
}

@end
