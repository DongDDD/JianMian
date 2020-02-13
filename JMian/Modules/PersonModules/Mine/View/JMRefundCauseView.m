//
//  JMRefundCauseView.m
//  JMian
//
//  Created by mac on 2020/2/4.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMRefundCauseView.h"
#import "DimensMacros.h"
#import "JMRefundGoodsStatusTableViewCell.h"
#import "JMPartTimeJobResumeFooterView.h"
@interface JMRefundCauseView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JMPartTimeJobResumeFooterView *otherCauseTextView;
@end
@implementation JMRefundCauseView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self.titleArray = @[@"不喜欢/不想要",@"货物破损" ,@"卖家发错货",@"生产日期/保质与商品描述不符",@"其他原因"];
        [self initView];
    }
    return self;
}

-(void)initView{
    self.titleLab =[[UILabel alloc]init];
    self.titleLab.text = @"退款原因";
    self.titleLab.textColor = TITLE_COLOR;
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(20);
        make.height.mas_equalTo(17);
    }];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.right.mas_equalTo(self);
    }];
//    [self addSubview:self.otherCauseTextView];
//    [self.otherCauseTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_tableView.mas_bottom);
//        make.bottom.mas_equalTo(self.mas_bottom);
//        make.left.right.mas_equalTo(self);
//    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMRefundGoodsStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMRefundGoodsStatusTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.font = kFont(15);
    // Configure the cell...
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.otherCauseTextView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 200;
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height+380, SCREEN_WIDTH, 460) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"JMRefundGoodsStatusTableViewCell" bundle:nil] forCellReuseIdentifier:JMRefundGoodsStatusTableViewCellIdentifier];

    }
    return _tableView;
}

-(JMPartTimeJobResumeFooterView *)otherCauseTextView{
    if (_otherCauseTextView == nil) {
        _otherCauseTextView = [JMPartTimeJobResumeFooterView new];
        _otherCauseTextView.frame = CGRectMake(10, -50, SCREEN_WIDTH-20, 200);
        _otherCauseTextView.delegate = self;
//        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
//        _otherCauseTextView.titleLab.text = @"商品描述";
//        _otherCauseTextView.wordsLenghLabel.text = @"0/200";
        _otherCauseTextView.contentTextView.backgroundColor = BG_COLOR;
//        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeGroup];
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _otherCauseTextView;
}
@end
