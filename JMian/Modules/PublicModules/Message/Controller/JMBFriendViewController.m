//
//  JMBFriendViewController.m
//  JMian
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBFriendViewController.h"
#import "JMHTTPManager+GetFriendLists.h"
#import "JMFriendListData.h"
#import "JMBCFriendTableViewCell.h"
#import "NSString+Common.h"

@interface JMBFriendViewController ()<UITableViewDelegate,UITableViewDataSource,JMBCFriendTableViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *groupList;
@property NSDictionary<NSString *, NSArray<JMFriendListData *> *> *dataDict;



@end
static NSString *cellIdent = @"BfriendID";

@implementation JMBFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
//    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
}

-(void)getData{
    [[JMHTTPManager sharedInstance]getFriendListWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSArray *arr =  [JMFriendListData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            self.dataArray = [NSMutableArray array];
            self.groupList = [NSMutableArray array];
            NSMutableDictionary *dataDict = @{}.mutableCopy;

            for (JMFriendListData *data in arr) {
                NSInteger step = [data.friend_enterprise_step integerValue];
                if (step > 4) {
                    NSString *group = [[data.friend_agency_company_name firstPinYin] uppercaseString];
                    NSMutableArray *list = [dataDict objectForKey:group];
                    if (!list) {
                        list = @[].mutableCopy;
                        dataDict[group] = list;
                        [self.groupList addObject:group];
                    }
                    [list addObject:data];
                    [self.dataArray addObject:data];
                }
                
            }
            
            self.dataDict = dataDict;
            [self.tableView reloadData];
            
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
         
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
         return self.groupList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *group = self.groupList[section];
    NSArray *list = self.dataDict[group];
    return list.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (section == 0)
//        return nil;

#define TEXT_TAG 1
    static NSString *headerViewId = @"ContactDrawerView";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
    if (!headerView)
    {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerViewId];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.tag = TEXT_TAG;
        textLabel.font = [UIFont systemFontOfSize:17.5];
        textLabel.textColor = RGB(0x80, 0x80, 0x80);
        [headerView addSubview:textLabel];
        textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    UILabel *label = [headerView viewWithTag:TEXT_TAG];
    label.text = [NSString stringWithFormat:@"         %@", self.groupList[section]];

    return headerView;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *array = [NSMutableArray arrayWithObject:@""];
    [array addObjectsFromArray:self.groupList];
    return array;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMBCFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JMBCFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    //        cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.viewType = JMBFriendTableViewCell;
    cell.delegate = self;
    NSString *group = self.groupList[indexPath.section];
    NSArray *list = self.dataDict[group];
    if (_viewType == JMBFriendViewControllerViewTypeGroup) {
        cell.viewType2 = JMFriendTableViewCellCreateGroup;
    }
    if (_viewType == JMBFriendViewControllerViewTypeFriendList) {
        cell.viewType2 = JMFriendTableViewCellFriendList;
    }
    JMFriendListData *data = list[indexPath.row];
    //        [cell setModel:self.dataArray[indexPath.row]];
    [cell setData:data];
    
    return cell;
}
#pragma mark - myDelegate

-(void)didSelectedFriendWithModel:(JMFriendListData *)data{
       if (_delegate && [_delegate respondsToSelector:@selector(BFriendViewControllerDidSelectedFriendWithModel:)]) {
             [_delegate BFriendViewControllerDidSelectedFriendWithModel:data];
         }
}

-(void)didCancelFriendWithModel:(JMFriendListData *)data{
       if (_delegate && [_delegate respondsToSelector:@selector(BFriendViewControllerDidCancelFriendWithModel:)]) {
             [_delegate BFriendViewControllerDidCancelFriendWithModel:data];
         }
}


#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height-BottomHeight_Status) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 25;
        _tableView.sectionFooterHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.tableView registerNib:[UINib nibWithNibName:@"JMBCFriendTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
        self.tableView.rowHeight = 79;
//        self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    }
    return _tableView;
}

//-(NSMutableArray *)dataArray{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
//
//-(NSMutableArray *)groupList{
//    if (!_groupList) {
//        _groupList = [NSMutableArray array];
//    }
//    return _groupList;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
