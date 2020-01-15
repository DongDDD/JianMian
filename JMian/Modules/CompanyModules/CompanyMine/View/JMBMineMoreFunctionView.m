//
//  JMBMineMoreFunctionView.m
//  JMian
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBMineMoreFunctionView.h"
#import "DimensMacros.h"
@interface JMBMineMoreFunctionView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSArray *imageNameArr,*labelStrArr;
@property (nonatomic, strong) UIView *BGView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;

@end
static NSString *cellId = @"FunctionCell";

@implementation JMBMineMoreFunctionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
//        @"subscribe"我的店铺"
        
        self.imageNameArr = @[@"mine_share",@"burse",@"autonym"];
        self.labelStrArr = @[@"分享APP",@"我的钱包",@"实名认证"];
        
        [self initView];
        [self initLayout];
        
    }
    return self;
}

-(void)initView{
    _titleLab = [[UILabel alloc]init];
    _titleLab.textColor = TITLE_COLOR;
    _titleLab.font = kFont(16);
    _titleLab.text = @"更多功能";
    [self addSubview:_titleLab];
        
    _imgView = [[UIImageView alloc]init];
    _imgView.image = [UIImage imageNamed:@"tiao"];
    [self addSubview:_imgView];
    
    self.BGView = [[UIView alloc]init];
    self.BGView.layer.shadowColor = [UIColor colorWithRed:20/255.0 green:31/255.0 blue:87/255.0 alpha:0.1].CGColor;
    self.BGView.layer.shadowOffset = CGSizeMake(0,1);
    self.BGView.layer.shadowOpacity = 1;
    self.BGView.layer.shadowRadius = 6;
    self.BGView.layer.cornerRadius = 10;
    self.BGView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.BGView];
    [self.BGView addSubview:self.tableView];
    
}

-(void)initLayout{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17);
        make.left.mas_equalTo(self).offset(30);
        make.top.mas_equalTo(self);
        
    }];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(4);
        make.right.mas_equalTo(_titleLab.mas_left).offset(-10);
        make.centerY.mas_equalTo(_titleLab);
    }];
    
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(13);
        make.right.mas_equalTo(self).offset(-13);
        make.height.mas_equalTo(200);
        make.top.mas_equalTo(_titleLab.mas_bottom).offset(13);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.BGView).offset(5);
        make.right.mas_equalTo(self.BGView).offset(-5);
        make.top.mas_equalTo(self.BGView).offset(5);
        make.bottom.mas_equalTo(self.BGView).offset(-5);

    }];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.labelStrArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.labelStrArr[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:14];
    cell.textLabel.textColor = UIColorFromHEX(0x4d4d4d);
    cell.imageView.image = [UIImage imageNamed:self.imageNameArr[indexPath.row]];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectCellWithRow:)]) {
        [_delegate didSelectCellWithRow:indexPath.row];
    }
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 65;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
}

@end
