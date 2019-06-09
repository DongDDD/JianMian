//
//  JMPartTimeJobTypeLabsViewController.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPartTimeJobTypeLabsViewController.h"
#import "JMPartTimeJobLabsCollectionViewCell.h"

@interface JMPartTimeJobTypeLabsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSArray *labsArray;
@end
static CGFloat kMagin = 10.f;

@implementation JMPartTimeJobTypeLabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择兼职类型";
    _labsArray = @[@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"家庭导师",@"家庭导师",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"家庭导师",@"家庭导师",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师",@"家庭导师",@"家庭导师",@"设计",@"模特",@"设计",@"模特",@"家庭导师"];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ====== UICollectionViewDelegate ======

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _labsArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMPartTimeJobLabsCollectionViewCell *cell = (JMPartTimeJobLabsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.labName.text = _labsArray[indexPath.row];
    
    return cell;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 50) / 4;
//        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
//        layout.itemSize = CGSizeMake(width, 100);
//        layout.minimumInteritemSpacing = 0;
//        layout.minimumLineSpacing = 10;
        
        //自动网格布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat itemWidth = (self.view.frame.size.width - 4 * kMagin) / 4;
        
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(itemWidth, 33);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 10;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 10;
        //设置senction的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(kMagin, kMagin, kMagin, kMagin);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JMPartTimeJobLabsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.borderWidth = 0;
        _collectionView.bounces = YES;
    }
    return _collectionView;
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
