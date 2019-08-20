//
//  JMGreetView.m
//  JMian
//
//  Created by mac on 2019/5/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMGreetView.h"
#import "JMGreetCell.h"
#import "Masonry.h"
#import "DimensMacros.h"
#import "JMHTTPManager+FectchGreetList.h"
#import "JMGreetModel.h"

@implementation JMGreetView
static NSString *cellIdent = @"CellIdent";

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
        self.backgroundColor = [UIColor whiteColor];
        [self getGreetList];
    }
    return self;
}



-(void)initView
{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-50) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.backgroundColor = BG_COLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
    _bottomBtn = [[UIButton alloc]init];
    _bottomBtn.backgroundColor = [UIColor whiteColor];
    [_bottomBtn addTarget:self action:@selector(addGreetAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBtn setTitle:@"+ 新增常用语" forState:UIControlStateNormal];
    [_bottomBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_bottomBtn];
    
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
}

-(void)addGreetAction:(UIButton *)button
{
    if(_delegate && [_delegate respondsToSelector:@selector(addGreetAction)]){
        [_delegate addGreetAction];
    }


}


-(void)getGreetList{
    [[JMHTTPManager sharedInstance]getGreetList_keyword:nil mode:nil user_id:nil page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.listArray = [JMGreetModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
         }
        [self.tableView reloadData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)deleteGreetRequest_ID:(NSString *)ID{
    [[JMHTTPManager sharedInstance]deleteGreet_ID:ID successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    JMGreetModel *model = self.listArray[indexPath.row];
    NSString *str = model.text;
    cell.textLabel.text = str;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = TITLE_COLOR;
    cell.backgroundColor = BG_COLOR;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str;
    JMGreetModel *model = self.listArray[indexPath.row];
    str = model.text;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didChooseGreetWithStr:)]) {
        [_delegate didChooseGreetWithStr:str];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        JMGreetModel *model = self.listArray[indexPath.row];
        [self deleteGreetRequest_ID:model.greet_id];
        [self.listArray removeObjectAtIndex:indexPath.row];

        [self.tableView reloadData];
        NSLog(@"UITableViewCellEditingStyleDelete");
       
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {

    return @"删除";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
