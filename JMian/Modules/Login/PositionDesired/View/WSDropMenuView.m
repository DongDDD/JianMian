//
//  TWDropMenuView.m
//  WLMenu
//

//

#import "WSDropMenuView.h"
#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width [[UIScreen mainScreen] bounds].size.width
#define KBgMaxHeight  Main_Screen_Height
#define KTableViewMaxHeight 300

#define KTopButtonHeight 44



@implementation WSIndexPath

+ (instancetype)twIndexPathWithColumn:(NSInteger)column
                                  row:(NSInteger)row
                                 item:(NSInteger)item
                                 rank:(NSInteger)rank{
    
    WSIndexPath *indexPath = [[self alloc] initWithColumn:column row:row item:item rank:rank];
    
    return indexPath;
}


- (instancetype)initWithColumn:(NSInteger )column
                           row:(NSInteger )row
                          item:(NSInteger )item
                          rank:(NSInteger )rank{
    
    if (self = [super init]) {
        
        self.column = column;
        self.row = row;
        self.item = item;
        self.rank = rank;
        
    }
    
    return self;
}


@end


static NSString *cellIdent = @"cellIdent";

@interface WSDropMenuView ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger _currSelectColumn;
    NSInteger _currSelectRow;
    NSInteger _currSelectItem;
    NSInteger _currSelectRank;
    
    CGFloat _rightHeight;
    BOOL _isRightOpen;
    BOOL _isLeftOpen;
    
}

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *leftTableView_1;
@property (nonatomic,strong) UITableView *leftTableView_2;
@property (nonatomic,strong) UITableView *rightTableView;



@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@end


@implementation WSDropMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        [self _initialize];
        [self _setSubViews];
        [self _showLeftTableViews];
    }
    return self;
}


- (void)_initialize{
    
    _currSelectColumn = 0;
    _currSelectItem = WSNoFound;
    _currSelectRank = WSNoFound;
    _currSelectRow = WSNoFound;
    _isLeftOpen = NO;
    _isRightOpen = NO;
}



- (void)_setSubViews{
    
//    [self addSubview:self.bgButton];
    [self addSubview:self.leftTableView];
    [self addSubview:self.leftTableView_1];
    [self addSubview:self.leftTableView_2];
    [self addSubview:self.rightTableView];
    
}


#pragma mark -- public fun --
- (void)reloadLeftTableView{
    
    [self.leftTableView reloadData];
}

- (void)reloadRightTableView;
{
    
    [self.rightTableView reloadData];
}

#pragma mark -- getter --
- (UITableView *)leftTableView{
    
    if (!_leftTableView) {
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        _leftTableView.frame = CGRectMake(0, 0, Main_Screen_Width/3.0, 0);
        _leftTableView.tableFooterView = [[UIView alloc]init];
    }
    
    return _leftTableView;
}

- (UITableView *)leftTableView_1{
    
    if (!_leftTableView_1) {
        
        _leftTableView_1 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView_1.delegate = self;
        _leftTableView_1.dataSource = self;
        [_leftTableView_1 registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        _leftTableView_1.frame = CGRectMake( Main_Screen_Width/3.0, 0 , Main_Screen_Width/3.0, 0);
        _leftTableView_1.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        _leftTableView_1.tableFooterView = [[UIView alloc]init];
        
        
    }
    
    return _leftTableView_1;
    
}

- (UITableView *)leftTableView_2{
    
    
    
    if (!_leftTableView_2) {
        
        _leftTableView_2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView_2.delegate = self;
        _leftTableView_2.dataSource = self;
        [_leftTableView_2 registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
        _leftTableView_2.frame = CGRectMake( Main_Screen_Width/3.0 * 2, 0 , Main_Screen_Width/3.0, 0);
        _leftTableView_2.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        _leftTableView_2.tableFooterView = [[UIView alloc]init];
        
    }
    
    return _leftTableView_2;
    
    
    
}

- (void)_showLeftTableViews{
    
    self.leftTableView.frame = CGRectMake(self.leftTableView.frame.origin.x, self.leftTableView.frame.origin.y, self.leftTableView.frame.size.width, Main_Screen_Height-116);
    self.leftTableView_1.frame = CGRectMake(self.leftTableView_1.frame.origin.x, self.leftTableView_1.frame.origin.y, self.leftTableView_1.frame.size.width, Main_Screen_Height-111);
    self.leftTableView_2.frame = CGRectMake(self.leftTableView_2.frame.origin.x, self.leftTableView_2.frame.origin.y, self.leftTableView_2.frame.size.width, Main_Screen_Height-111);
   
}



#pragma mark -- DataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    WSIndexPath *twIndexPath =[self _getTwIndexPathForNumWithtableView:tableView];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dropMenuView:numberWithIndexPath:)]) {
        
        NSInteger count =  [self.dataSource dropMenuView:self numberWithIndexPath:twIndexPath];

        return count;
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WSIndexPath *twIndexPath = [self _getTwIndexPathForCellWithTableView:tableView indexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor =  [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:36/255.0 green:191/255.0 blue:255/255.0 alpha:1.0];
    //    [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dropMenuView:titleWithIndexPath:)]) {
        
        cell.textLabel.text =  [self.dataSource dropMenuView:self titleWithIndexPath:twIndexPath];
    }else{
        
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    
    
    return cell;
    
}


#pragma mark - tableView delegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    [self _changeTopButton:cell.textLabel.text ];
    
    if (tableView == self.leftTableView) {
        _currSelectRow = indexPath.row;
        _currSelectItem = WSNoFound;
        _currSelectRank = WSNoFound;
        
        [self.leftTableView_1 reloadData];
        [self.leftTableView_2 reloadData];
    }
    if (tableView == self.leftTableView_1) {
        _currSelectRank = WSNoFound;
        _currSelectItem = indexPath.row;
        [self.leftTableView_2 reloadData];
    }
    
    
  
    
    
}



- (WSIndexPath *)_getTwIndexPathForNumWithtableView:(UITableView *)tableView{
    
    
    if (tableView == self.leftTableView) {
        
        return  [WSIndexPath twIndexPathWithColumn:_currSelectColumn row:WSNoFound item:WSNoFound rank:WSNoFound];
        
    }
    
    if (tableView == self.leftTableView_1 && _currSelectRow != WSNoFound) {
        
        
        return [WSIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:WSNoFound rank:WSNoFound];
    }
    
    if (tableView == self.leftTableView_2 && _currSelectRow != WSNoFound && _currSelectItem != WSNoFound) {
        return [WSIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:_currSelectItem  rank:WSNoFound];
    }
    
    if (tableView == self.rightTableView) {
        
        return [WSIndexPath twIndexPathWithColumn:1 row:WSNoFound item:WSNoFound  rank:WSNoFound];
    }
    
    
    return  0;
}

- (WSIndexPath *)_getTwIndexPathForCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.leftTableView) {
        
        return  [WSIndexPath twIndexPathWithColumn:0 row:indexPath.row item:WSNoFound rank:WSNoFound];
        
    }
    
    if (tableView == self.leftTableView_1) {
        
        
        return [WSIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:indexPath.row rank:WSNoFound];
    }
    
    if (tableView == self.leftTableView_2) {
        return [WSIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:_currSelectItem  rank:indexPath.row];
    }
    
    if (tableView == self.rightTableView) {
        
        return [WSIndexPath twIndexPathWithColumn:1 row:indexPath.row item:WSNoFound  rank:WSNoFound];
    }
    
    
    return  [WSIndexPath twIndexPathWithColumn:0 row:indexPath.row item:WSNoFound rank:WSNoFound];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
}



@end
