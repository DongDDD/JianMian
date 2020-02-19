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
@property(nonatomic,copy)NSString *msg;
@end
@implementation JMRefundCauseView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self.titleLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 70)];
        self.titleLab.font = kFont(20);
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.textColor = [UIColor blackColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [self addSubview:view];
    [self addSubview:self.tableView];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    btn.backgroundColor = MASTER_COLOR;
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [view addGestureRecognizer:tap];
}

-(void)submit{
    [self hide];
    if (_delegate && [_delegate respondsToSelector:@selector(submitActionWithMsg:)]) {
        [_delegate submitActionWithMsg:self.msg];
    }
    
}

-(void)show{
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.frame = CGRectMake(0, self.frame.size.height-500, self.frame.size.width, 500);
        [self setHidden:NO];

    }];
}

-(void)hide{
    [self setHidden:YES];
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.frame = CGRectMake(0, self.frame.size.height + 500, self.frame.size.width, 500);
    }];
    
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
    return 160;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return self.titleLab;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.msg = self.titleArray[indexPath.row];
    
}


#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height+380, SCREEN_WIDTH, 600) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = 34;
        _tableView.scrollEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"JMRefundGoodsStatusTableViewCell" bundle:nil] forCellReuseIdentifier:JMRefundGoodsStatusTableViewCellIdentifier];

    }
    return _tableView;
}

-(JMPartTimeJobResumeFooterView *)otherCauseTextView{
    if (_otherCauseTextView == nil) {
        _otherCauseTextView = [JMPartTimeJobResumeFooterView new];
        _otherCauseTextView.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 200);
        _otherCauseTextView.delegate = self;
//        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
//        _otherCauseTextView.titleLab.text = @"请输入";
//        _otherCauseTextView.wordsLenghLabel.text = @"0/200";
        _otherCauseTextView.contentTextView.backgroundColor = BG_COLOR;
//        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeGroup];
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _otherCauseTextView;
}

@end
