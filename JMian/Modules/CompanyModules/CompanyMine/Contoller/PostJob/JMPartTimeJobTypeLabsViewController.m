//
//  JMPartTimeJobTypeLabsViewController.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPartTimeJobTypeLabsViewController.h"
#import "JMPartTimeJobLabsCollectionViewCell.h"
#import "JMHTTPManager+GetLabels.h"
@interface JMPartTimeJobTypeLabsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong) NSArray *labsArray;
@property (nonatomic ,strong) NSString *didChooseLab;


@end
static CGFloat kMagin = 10.f;

@implementation JMPartTimeJobTypeLabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择兼职类型";
    [self.view addSubview:self.collectionView];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}


-(void)getData{
    [[JMHTTPManager sharedInstance]getLabels_Id:@"1027" mode:@"tree" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            _labsArray = [JMPartTimeJobLabsCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
            [_collectionView reloadData];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
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
    
    [cell setLabData:_labsArray[indexPath.row]];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JMPartTimeJobLabsCellData *data = _labsArray[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(didChooseWithType_id:typeName:)]) {
        [_delegate didChooseWithType_id:data.label_id typeName:data.name];
        [super fanhui];
    }
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {

        //自动网格布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat itemWidth = (self.view.frame.size.width - 4 * kMagin) / 4;
        
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(itemWidth, 33);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 10;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 10;
        //设置senction的内边距@
        flowLayout.sectionInset = UIEdgeInsetsMake(kMagin, kMagin, kMagin, kMagin);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) collectionViewLayout:flowLayout];
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
