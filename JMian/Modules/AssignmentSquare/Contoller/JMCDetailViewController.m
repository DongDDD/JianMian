//
//  JMCDetailViewController.m
//  JMian
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailViewController.h"
#import "JMTaskDetailHeaderView.h"
#import "JMTitlesView.h"
#import "JMTaskDetailHeaderTableViewCell.h"
#import "JMCDetailCellConfigures.h"
#import "JMHTTPManager+FectchTaskInfo.h"
#import "JMHTTPManager+FectchCommentInfo.h"
#import "JMVideoPlayManager.h"
#import "JMPlayerViewController.h"

@interface JMCDetailViewController ()<UITableViewDelegate,UITableViewDataSource,JMCDetailVideoTableViewCellDelegate>
@property (strong, nonatomic) UITableView *tableView;

//@property (nonatomic, strong) UIView *headerTitleView;
@property (nonatomic, strong) JMTaskDetailHeaderView *taskDetailHeaderView;

@property (nonatomic, strong) JMTitlesView *titleView;
@property (assign, nonatomic) NSUInteger index;
@property (nonatomic, strong) JMCDetailCellConfigures *configures;

@end

@implementation JMCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务详情";
    [self ininView];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -- Data

-(void)getData{
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]fectchTaskInfo_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.configures.model = [JMCDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
//
//            
//            NSDictionary *dic = responsObject[@"data"];
//            //判断是否有被收藏过
//            if (![dic[@"favorites"] isEqual:[NSNull null]]) {
//                self.favorites_id = dic[@"favorites"][@"favorite_id"];
//                [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
//                
//            }
            [self getCommentInfo];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


-(void)getCommentInfo{
    [[JMHTTPManager sharedInstance]fectchCommentInfoWithTask_order_id:nil order_id:nil user_id:nil company_id:self.configures.model.user_company_id page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.configures.commentListArray = [JMCommentCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
            [self hiddenHUD];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

-(void)ininView{
//    [self.view addSubview:self.taskDetailHeaderView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
    }];

}

#pragma mark - myDelegate
-(void)playVideoActionWithUrl:(NSString *)url{
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:url];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    [[JMVideoPlayManager sharedInstance] play];
}


#pragma mark - UITableViewDataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        return  5;
//    }else if(section == 1) {
//        return  5;
//    }
//    return 5;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
//        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor redColor];
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.configures numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self.configures heightForRowsInSection:indexPath];;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.titleView;
    }else if (section == 2) {
        if (self.configures.model.images.count > 0) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
            lab.text = @"     图片介绍";
            lab.font = [UIFont boldSystemFontOfSize:16];
            lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            lab.backgroundColor = [UIColor whiteColor];
            return lab;
        }else{
            return [UIView new];
        }
    }else if (section == 3) {
        if (self.configures.model.latitude.length > 0 && self.configures.model.longitude.length > 0) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
            lab.font = [UIFont boldSystemFontOfSize:16];
            lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            lab.backgroundColor = [UIColor whiteColor];
            lab.text = @"     公司地址";
            return lab;
            
        }else{
            return [UIView new];
        }
  
    }else if (section == 4) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        lab.backgroundColor = [UIColor whiteColor];
        lab.text = @"     信誉评价";
        
        return lab;
    }
//    else if (section == 2) {
//        return self.titleView;
//
//    }
    return [UIView new];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }else if (section == 2) {
        if (self.configures.model.images.count > 0) {
            return 44;
        }else{
            return 1;
        }
    }else if (section == 3) {
        if (self.configures.model.latitude.length > 0 && self.configures.model.longitude.length > 0) {
            return 44;
        }else{
            return 1;
            
        }
        
    }else if (section == 4) {
        return 44;
        
    }
    return 1;

}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return 10;
//    }
//    return 0;
//}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        JMTaskDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMTaskDetailHeaderTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setModel:self.configures.model];
        return cell;
        
    }else if (indexPath.section == 1){
        //任务描述/产品描述
        if (indexPath.row == 0) {
            JMCDetailTaskDecriTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailTaskDecriTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.configures.model];
            return cell;
            
        }else if (indexPath.row == 1) {
            if ([self.configures.model.payment_method isEqualToString:@"1"]) {

                JMCDetailProduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailProduceTableViewCellIdentifier forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setData:self.configures.model];
                return cell;
            }else {
                JMCDetailTaskDecri2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailTaskDecri2TableViewCellIdentifier forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setModel:self.configures.model];
                return cell;
            }
        }else if (indexPath.row == 2) {
             JMCDetailVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailVideoTableViewCellIdentifier forIndexPath:indexPath];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.configures.model];
//            cell.backgroundColor = [UIColor redColor];
            //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
        }
    
    }else if (indexPath.section == 2) {
        //图片
        JMCDetailImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailImageTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        JMCDetailImageModel *imgModel = self.configures.model.images[indexPath.row];
        [cell setUrl:imgModel.file_path];
        
        //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
        return cell;
    }else if (indexPath.section == 3) {
        //公司地址
        JMMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMapTableViewCellIdentifier forIndexPath:indexPath];
//        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.configures.model];
        //            cell.backgroundColor = [UIColor redColor];
        //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
        return cell;
    }else if (indexPath.section == 4) {
        //评论
        if (self.configures.commentListArray.count > 0) {
            JMCDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailCommentTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            JMCommentCellData *data = self.configures.commentListArray[indexPath.row];
            [cell setData:data];
            //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
            
        }else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nilCell"];
            
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"nilCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"  暂无评论";
            cell.textLabel.font = kFont(14);
            cell.textLabel.textColor = TEXT_GRAY_COLOR;
            return cell;

        }
    }

    return nil;
}


-(void)showPageContentView{
    switch (_index) {
        case 0:
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        case 1:
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        default:
            break;
    }

}

#pragma mark - lazy
-(JMTaskDetailHeaderView *)taskDetailHeaderView{
    if (!_taskDetailHeaderView) {
        _taskDetailHeaderView = [[JMTaskDetailHeaderView alloc]init];
    }
    return _taskDetailHeaderView;
    
}

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"任务描述", @"信誉评价"]];
        __weak JMCDetailViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf showPageContentView];
        };
    }
    
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 5;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
                _tableView.sectionFooterHeight = 5;
        [_tableView registerNib:[UINib nibWithNibName:@"JMTaskDetailHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMTaskDetailHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecriTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailTaskDecriTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecri2TableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailTaskDecri2TableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailVideoTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailVideoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailImageTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailImageTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailCommentTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailCommentTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailProduceTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailProduceTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMapTableViewCell" bundle:nil] forCellReuseIdentifier:JMMapTableViewCellIdentifier];

        
    }
    return _tableView;
}

-(JMCDetailCellConfigures *)configures{
    if (!_configures) {
        _configures = [[JMCDetailCellConfigures alloc]init];
    }
    return _configures;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
