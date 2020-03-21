//
//  JMPostProductViewController.m
//  JMian
//
//  Created by mac on 2020/1/11.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMPostProductViewController.h"
#import "JMPostProductConfigures.h"
#import "JMProductSpecificationViewController.h"
#import "JMRichTextViewController.h"
#import "ZSSDemoViewController.h"
#import "RichTextEditViewController.h"

@interface JMPostProductViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JMPostProductConfigures *cellConfigures;
@end

@implementation JMPostProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布宝贝";
    [self.view addSubview:self.tableView];
    [self setRightBtnTextName:@"测试按钮"];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)rightAction{
    RichTextEditViewController* controller = [RichTextEditViewController new];
       [self.navigationController pushViewController:controller animated:YES];
//    ZSSDemoViewController *demo1 = [[ZSSDemoViewController alloc] init];
//    [self.navigationController pushViewController:demo1 animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
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
        case JMPostProductTypeHeader: {
            JMPostProductHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPostProductHeaderTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //        self.userModel.company_real_company_name = self.cellConfigures.model.company_name;
            //        [cell setModel:self.userModel viewType:JMUserProfileHeaderCellTypeB];
            return cell;
        }
        case JMPostProductTypeParam: {
            JMPostProductParamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPostProductParamTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //        self.userModel.company_real_company_name = self.cellConfigures.model.company_name;
            //        [cell setModel:self.userModel viewType:JMUserProfileHeaderCellTypeB];
            return cell;
        }
        case JMPostProductTypeDesc: {
            JMPostProductDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPostProductDescTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case JMPostProductTypePostBtn: {
            JMPostProductBottomBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPostProductBottomBtnTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        default:
            break;
    }
    
    return [UITableViewCell new];
    
}


#pragma mark - Lazy
-(JMPostProductConfigures *)cellConfigures{
    if (!_cellConfigures) {
        _cellConfigures = [[JMPostProductConfigures alloc]init];
    }
    return _cellConfigures;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
//        _tableView.rowHeight = 48;
        [_tableView registerNib:[UINib nibWithNibName:@"JMPostProductParamTableViewCell" bundle:nil] forCellReuseIdentifier:JMPostProductParamTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPostProductHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMPostProductHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPostProductDescTableViewCell" bundle:nil] forCellReuseIdentifier:JMPostProductDescTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPostProductBottomBtnTableViewCell" bundle:nil] forCellReuseIdentifier:JMPostProductBottomBtnTableViewCellIdentifier];

        
        
    }
    return _tableView;
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
