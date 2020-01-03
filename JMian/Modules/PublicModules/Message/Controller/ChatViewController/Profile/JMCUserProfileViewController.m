//
//  JMCUserProfileViewController.m
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCUserProfileViewController.h"
#import "JMCUserProfileConfigure.h"
#import "JMHTTPManager+GetProfileInfo.h"
#import "JMHTTPManager+FetchCompanyInfo.h"
#import "JMCompanyHomeModel.h"
#import "JMHTTPManager+DeleteFriend.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMChatViewController.h"
#import "JMHTTPManager+AddFriend.h"

@interface JMCUserProfileViewController ()<UITableViewDelegate,UITableViewDataSource,JMCUserProfileConfigureDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JMCUserProfileConfigure *cellConfigures;
@property(nonatomic,strong)JMUserInfoModel *userModel;
@property (weak, nonatomic) IBOutlet UIButton *leftBottomBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBottomBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property(nonatomic,assign)NSInteger index;
@end

@implementation JMCUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.userIM_id = [NSString stringWithFormat:@"%@a",_user_id];
    [self initView];
    [self getData];
    [self getPartTimeJobData];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)initView{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideTop).mas_offset(-60);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide).mas_offset(-self.bottomView.frame.size.height);
    }];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.bottomView];
    
    if (_isMyFriend) {
        self.leftBottomBtn.layer.cornerRadius = 5;
        self.leftBottomBtn.layer.borderWidth = 1;
        self.leftBottomBtn.layer.borderColor = UIColorFromHEX(0xF4333C).CGColor;
        self.leftBottomBtn.backgroundColor = [UIColor whiteColor];
        [self.leftBottomBtn setTitleColor:UIColorFromHEX(0xF4333C) forState:UIControlStateNormal];
        [self.leftBottomBtn setTitle:@"删除" forState:UIControlStateNormal];
        //
        self.rightBottomBtn.layer.cornerRadius = 5;
        self.rightBottomBtn.layer.borderWidth = 1;
        self.rightBottomBtn.layer.borderColor = MASTER_COLOR.CGColor;
        self.rightBottomBtn.backgroundColor = UIColorFromHEX(0xF7FDFF);
        [self.rightBottomBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [self.rightBottomBtn setTitle:@"聊一聊" forState:UIControlStateNormal];

    }else{
        
        self.leftBottomBtn.layer.cornerRadius = 5;
        self.leftBottomBtn.layer.borderWidth = 1;
        self.leftBottomBtn.layer.borderColor = MASTER_COLOR.CGColor;
        self.leftBottomBtn.backgroundColor = UIColorFromHEX(0xF7FDFF);
        [self.leftBottomBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [self.leftBottomBtn setTitle:@"聊一聊" forState:UIControlStateNormal];
        //
        self.rightBottomBtn.layer.cornerRadius = 5;
        self.rightBottomBtn.layer.borderWidth = 1;
        self.rightBottomBtn.layer.borderColor = MASTER_COLOR.CGColor;
        self.rightBottomBtn.backgroundColor = MASTER_COLOR;
        [self.rightBottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBottomBtn setTitle:@"加好友" forState:UIControlStateNormal];
        
    }
    

}

#pragma mark - action
- (IBAction)leftBottomAction:(UIButton *)sender {
    if (_isMyFriend == YES ) {
        [[JMHTTPManager sharedInstance]deleteFriendWithId:_user_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            [self.navigationController popViewControllerAnimated:YES];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
    }else{
        [self chatAction];
    
    }
}

- (IBAction)rightBottomAction:(UIButton *)sender {
       if (_isMyFriend == YES ) {
           [self chatAction];
       }else{
           [self addFriendAction];
       }
    
}

-(void)chatAction{
    [[JMHTTPManager sharedInstance]createFriendChatWithType:@"4" account:_userIM_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
            JMAllMessageTableViewCellData *data = [[JMAllMessageTableViewCellData alloc]init];
            data.convType = TConv_Type_C2C;
            messageListModel.data =data;
            JMChatViewController *vc = [[JMChatViewController alloc]init];
            vc.myConvModel = messageListModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

-(void)addFriendAction{
    [[JMHTTPManager sharedInstance]addFriendtWithRelation_id:_user_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.navigationController popViewControllerAnimated:YES];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功添加好友" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
             [alert show];
             
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
         
    }];
}

#pragma mark - Data
-(void)getData{
    [[JMHTTPManager sharedInstance]getCUserProfileWithUser_id:_user_id SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.cellConfigures.job_Arr = [JMVitaDetailModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self getUserInfo];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
         
    }];

}

-(void)getUserInfo{
    [[JMHTTPManager sharedInstance]getBUserProfileWithUser_id:_user_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
                  self.userModel = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
                [self.tableView reloadData];
            }

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

}

-(void)getPartTimeJobData{
 
    
    [[JMHTTPManager sharedInstance]getCUserProfileAbilityListWithUser_id:_user_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.cellConfigures.abilityListArr = [JMAbilityCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        }
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

-(void)addFriendRequest{
    [[JMHTTPManager sharedInstance]addFriendtWithRelation_id:_user_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.navigationController popViewControllerAnimated:YES];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功添加好友" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
             [alert show];
             
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
         
    }];
}


#pragma mark - delegate
-(void)userProfileJobTypeWithIndex:(NSInteger)index{
    _index = index;
    if (_index == 0) {
        self.cellConfigures.viewType = JMCUserProfileCellTypeJobArr;
        
    }else if (_index == 1){
        self.cellConfigures.viewType = JMCUserProfileCellTypeAbilityArr;
        
    }
    [self.tableView reloadData];
    //类似单选题的多选一、某个section的headerView的大小自适应等，需要重新刷新或布局
//    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:JMUserProfileCellTypeJob];
//    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
 
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellConfigures numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellConfigures heightForRowsInSection:indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.cellConfigures heightForFooterInSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.cellConfigures heightForHeaderInSection:section];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.cellConfigures headerViewInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case JMCUserProfileCellTypeHeader: {
            JMUserProfileHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMUserProfileHeaderTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.userModel viewType:JMUserProfileHeaderCellTypeC];
            return cell;
        }

        case JMCUserProfileCellTypePersonInfo:
        {
            JMUserProfilePersonInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMUserProfilePersonInfoTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setBirthDay:self.userModel.card_birthday email:self.userModel.email];
            return cell;
        }
        case JMCUserProfileCellTypeJob:
        {
            JMUserProfileJobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMUserProfileJobTableViewCellIdentifier
                                                                                  forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (_index == 0) {
                JMVitaDetailModel *model = self.cellConfigures.job_Arr[indexPath.row];
                [cell setVitaCModel:model];
            }else if (_index == 1){
                JMAbilityCellData *model = self.cellConfigures.abilityListArr[indexPath.row];
                [cell setAbilityCellData:model];
            }
            return cell;
        }
        case JMUserProfileCellTypeEduExp:
        {
            JMUserProfileEduExpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMUserProfileEduExpTableViewCellIdentifier forIndexPath:indexPath];
            //            [cell setExperiencesModel:self.cellConfigures.workExperienceArr[indexPath.row]];
//            NSString *Introduce = self.cellConfigures.model.comDescription;
            if (self.cellConfigures.job_Arr.count > 0) {
                JMVitaDetailModel *model = self.cellConfigures.job_Arr[0];
                [cell setModel:model];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case JMCUserProfileCellTypeIntroduce:
        {
            JMUserProfileIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMUserProfileIntroduceTableViewCellIdentifier forIndexPath:indexPath];
            //            [cell setExperiencesModel:self.cellConfigures.workExperienceArr[indexPath.row]];
//            NSString *Introduce = self.cellConfigures.model.comDescription;
            if (self.cellConfigures.job_Arr.count > 0) {
                JMVitaDetailModel *model = self.cellConfigures.job_Arr[0];
                [cell setIntroduceStr:model.myDescription];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
//        case JMCUserProfileCellTypeIntroduce:
//        {
//
//            JMUserProfileIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMUserProfileIntroduceTableViewCellIdentifier forIndexPath:indexPath];
//            //            [cell setExperiencesModel:self.cellConfigures.workExperienceArr[indexPath.row]];
////            [cell setModel:self.cellConfigures.model];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//
        default:
            break;
    }
    
    return [UITableViewCell new];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//
//
//}

#pragma mark - tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 

}

#pragma mark - Lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
//        _tableView.sectionHeaderHeight = 0;

        [_tableView registerNib:[UINib nibWithNibName:@"JMUserProfileHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMUserProfileHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMUserProfilePersonInfoTableViewCell" bundle:nil] forCellReuseIdentifier:JMUserProfilePersonInfoTableViewCellIdentifier];
                [_tableView registerNib:[UINib nibWithNibName:@"JMUserProfileJobTableViewCell" bundle:nil] forCellReuseIdentifier:JMUserProfileJobTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMUserProfileEduExpTableViewCell" bundle:nil] forCellReuseIdentifier:JMUserProfileEduExpTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMUserProfileIntroduceTableViewCell" bundle:nil] forCellReuseIdentifier:JMUserProfileIntroduceTableViewCellIdentifier];
        

    }
    return _tableView;
}

-(JMCUserProfileConfigure *)cellConfigures{
    if (!_cellConfigures) {
        _cellConfigures = [[JMCUserProfileConfigure alloc]init];
        _cellConfigures.delegate = self;
    }
    return _cellConfigures;
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
