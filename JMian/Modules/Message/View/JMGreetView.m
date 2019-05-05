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

@implementation JMGreetView
static NSString *cellIdent = @"CellIdent";

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



-(void)initView
{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-50)];
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
    if(_delegate && [_delegate respondsToSelector:@selector(addGreetAction:)]){
        [_delegate addGreetAction];
    }


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    static NSString *CellIdentifier = @"Cell";
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
//    if (cell == nil)
//    {
         UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
  
    cell.textLabel.text = @"你好，我对你发布的简历很感兴趣，希望我们详聊...";
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = TITLE_COLOR;
    cell.backgroundColor = BG_COLOR;;
    return cell;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
