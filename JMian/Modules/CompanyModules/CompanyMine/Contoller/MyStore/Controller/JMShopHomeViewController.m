//
//  JMShopHomeViewController.m
//  JMian
//
//  Created by mac on 2020/2/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMShopHomeViewController.h"
#import "DimensMacros.h"
#import "JMShopHomeConfigures.h"
#import "JMHTTPManager+GetMyShopInfo.h"
#import "JMHTTPManager+GetGoodsList.h"

@interface JMShopHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JMShopHomeConfigures *cellConfigures;

@end

@implementation JMShopHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺首页";
    [self.view addSubview:self.tableView];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - data
-(void)getData{
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];

    [[JMHTTPManager sharedInstance]getMyShopInfoWithShop_id:model.shop_shop_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject) {
            self.cellConfigures.model = [JMShopInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [self.tableView reloadData];
            [self getGoodsListWithShop_id:self.shop_id];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

-(void)getGoodsListWithShop_id:(NSString *)shop_id{
    [[JMHTTPManager sharedInstance]getGoodsListWithShop_id:shop_id status:@"1" keyword:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

        if (responsObject[@"data"]) {
            NSArray *arr = [JMGoodsData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
//            NSMutableArray *goodsList = [NSMutableArray array];
//            for (JMGoodsData *data in arr) {
//                if (data.goods_id != self.goods_id) {
//                    [goodsList addObject:data];
//                }
//            }
            self.cellConfigures.goodsListArray = arr.copy;
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
     return [self.cellConfigures numberOfRowsInSection:section];
 }

 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return [self.cellConfigures heightForRowsInSection:indexPath.section];
 }

 - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
     return [self.cellConfigures heightForFooterInSection:section];
 }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case JMShopHomeTypeTitleHeader: {
            JMShopHomeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMShopHomeHeaderTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setValuesWithImageUrl:self.cellConfigures.model.shop_logo shopName:self.cellConfigures.model.shop_name goodsCount:self.cellConfigures.model.sort];
            return cell;
        }
        case JMShopHomeTypeGoodsList: {
            JMCSaleTypeDetailGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCSaleTypeDetailGoodsTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.viewType = JMCSaleTypeDetailGoodShopHomeType;
            [cell setGoodsArray:self.cellConfigures.goodsListArray];
            return cell;
        }

        default:
            break;
    }
    
    return [UITableViewCell new];
    
}

#pragma mark - Lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
//        _tableView.backgroundColor = [UIColor whiteColor];;

        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        
        [_tableView registerNib:[UINib nibWithNibName:@"JMCSaleTypeDetailGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:JMCSaleTypeDetailGoodsTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMShopHomeHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMShopHomeHeaderTableViewCellIdentifier];
        
        
        
        
    }
    return _tableView;
}

-(JMShopHomeConfigures *)cellConfigures{
    if (!_cellConfigures) {
        _cellConfigures = [[JMShopHomeConfigures alloc]init];
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
