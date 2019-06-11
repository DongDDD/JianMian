//
//  JMCompanyLikeViewController.m
//  JMian
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyLikeViewController.h"
#import "JMCompanyLikeTableViewCell.h"
#import "JMHTTPManager+CompanyLike.h"
#import "JMUserInfoModel.h"
#import "JMUserInfoManager.h"
#import "JMBTypeLikeModel.h"
#import "JMCTypeLikeModel.h"
#import "JMTitlesView.h"


@interface JMCompanyLikeViewController ()<UITableViewDelegate,UITableViewDataSource,JMCompanyLikeTableViewCellDelegate>
@property (nonatomic, strong) JMTitlesView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSArray *listsArray;

@end

static NSString *cellIdent = @"CellIdent";

@implementation JMCompanyLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setRightBtnTextName:@"清空"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 212;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMCompanyLikeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
//    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    [self.view addSubview:self.titleView];
    [self getListData];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)getListData{

    [[JMHTTPManager sharedInstance]fetchListWith_type:nil page:nil per_page:nil SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
             if ([userModel.type isEqualToString:B_Type_UESR]) {
             
                 self.listsArray = [JMBTypeLikeModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
             }else{
                 self.listsArray = [JMCTypeLikeModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
             
             }
        }
        [self.tableView reloadData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listsArray.count;
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JMCompanyLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[JMCompanyLikeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
    }
    cell.delegate = self;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        
        JMBTypeLikeModel *model = self.listsArray[indexPath.row];
        
        [cell setBTypeLikeModel:model];
    }else{
        
        JMCTypeLikeModel *model = self.listsArray[indexPath.row];
        
        [cell setCTypeLikeModel:model];
        
    }
    return cell;
    

}


-(void)deleteActionWithFavorite_id:(NSString *)favorite_id{
    [[JMHTTPManager sharedInstance]deleteLikeWith_Id:favorite_id SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self getListData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)chatAction{


}



#pragma mark - Getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"全职人才",@"兼职人才"]];
        __weak JMCompanyLikeViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
//            _index = index;
//            [weakSelf movePageContentView];
        };
    }
    
    return _titleView;
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
