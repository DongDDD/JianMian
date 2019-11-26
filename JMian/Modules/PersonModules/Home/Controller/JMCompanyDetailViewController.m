//
//  JMCompanyDetailViewController.m
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyDetailViewController.h"
#import "JMTitlesView.h"
#import "JMVideoPlayManager.h"
#import "JMPlayerViewController.h"
#import "JMComDetailCellConfigures.h"
#import "JMHTTPManager+FetchCompanyInfo.h"

@interface JMCompanyDetailViewController ()<UITableViewDelegate,UITableViewDataSource,JMComDetailVideoTableViewCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) JMTitlesView *titleView;
@property (strong, nonatomic) JMComDetailCellConfigures *configures;
@property (assign, nonatomic) NSInteger index;


@end

@implementation JMCompanyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公司介绍";
    [self getData];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
    }];
}

#pragma mark - data
-(void)getData{
    [[JMHTTPManager sharedInstance]fetchCompanyInfo_Id:self.company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                if (responsObject[@"data"]) {
                    self.configures.model = [JMCompanyInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
                    [self.tableView reloadData];
                }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 4;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.configures heightForRowsInSection:indexPath];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.titleView;
    }else{
        return [UIView new];

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }else{
        return 0;

    }
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        JMComDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMComDetailHeaderTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.configures.model];
        return cell;

    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //公司介绍
            JMComDetailContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMComDetailContentTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.configures.model];
            return cell;
        }else if (indexPath.row == 1) {
            //公司图片
            JMScrollviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMScrollviewTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.configures.model];
            return cell;
        }else if (indexPath.row == 2) {
            JMMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMapTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.latitude = self.configures.model.latitude;
            cell.longitude = self.configures.model.longitude;
            cell.address = self.configures.model.address;
            [cell setComModel:self.configures.model];
            return cell;
        }else if (indexPath.row == 3) {
            JMComDetailVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMComDetailVideoTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            [cell setModel:self.configures.model];
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
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        default:
            break;
    }
    
}

#pragma mark - myDelegate

-(void)playVideoActionWithUrl:(NSString *)url{
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:url videoID:@""];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [JMVideoPlayManager sharedInstance].viewType = JMVideoPlayManagerTypeDefault;
    [self presentViewController:playVC animated:YES completion:nil];

}

#pragma mark - lazy

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"公司详情", @"公司视频"]];
        __weak JMCompanyDetailViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf showPageContentView];
        };
    }
    
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
//        _tableView.sectionHeaderHeight = 5;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
//        _tableView.sectionFooterHeight = 5;
         [_tableView registerNib:[UINib nibWithNibName:@"JMComDetailHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMComDetailHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMComDetailContentTableViewCell" bundle:nil] forCellReuseIdentifier:JMComDetailContentTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMScrollviewTableViewCell" bundle:nil] forCellReuseIdentifier:JMScrollviewTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMScrollviewTableViewCell" bundle:nil] forCellReuseIdentifier:JMComDetailVideoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMComDetailVideoTableViewCell" bundle:nil] forCellReuseIdentifier:JMComDetailVideoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMapTableViewCell" bundle:nil] forCellReuseIdentifier:JMMapTableViewCellIdentifier];

//        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecri2TableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailTaskDecri2TableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailVideoTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailVideoTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailImageTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailImageTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailCommentTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailCommentTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailProduceTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailProduceTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMapTableViewCell" bundle:nil] forCellReuseIdentifier:JMMapTableViewCellIdentifier];
        
    }
    return _tableView;
}

-(JMComDetailCellConfigures *)configures{
    if (!_configures) {
        _configures = [[JMComDetailCellConfigures alloc]init];
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
