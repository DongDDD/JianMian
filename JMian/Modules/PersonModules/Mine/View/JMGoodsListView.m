//
//  JMGoodsListView.m
//  JMian
//
//  Created by mac on 2020/2/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsListView.h"
#import "DimensMacros.h"
#import "JMOrderGoodsListTableViewCell.h"
#import "JMOrderCellData.h"

@interface JMGoodsListView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation JMGoodsListView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
    }
    return self;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 79;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMOrderGoodsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOrderGoodsListTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JMGoodsInfoCellData *data = self.goods[indexPath.row];
    [cell setValuesWithImageUrl:data.cover_path title:data.title price:data.price quantity:data.quantity];
    
//    [cell setData:self.goods[indexPath.row]];
    // Configure the cell...
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, self.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"JMOrderGoodsListTableViewCell" bundle:nil] forCellReuseIdentifier:JMOrderGoodsListTableViewCellIdentifier];

    }
    return _tableView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
