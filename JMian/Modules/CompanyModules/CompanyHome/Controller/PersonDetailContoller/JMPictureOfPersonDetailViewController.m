//
//  JMPictureOfPersonDetailViewController.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPictureOfPersonDetailViewController.h"
#import "Masonry.h"
#import "DimensMacros.h"


static NSString * identifier = @"cxCellID";

@interface JMPictureOfPersonDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)UICollectionView *collectionView;


@end

@implementation JMPictureOfPersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.picArry) {
        [self.view addSubview:self.collectionView];
        
    }
    // Do any additional setup after loading the view from its nib.
}

//-(void)setCollectionViewUI{
//    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//    //设置布局方向为垂直流布局
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    //设置每个item的大小为100*100
//    layout.itemSize = CGSizeMake(109, 109);
//    //创建collectionView 通过一个布局策略layout来创建
//    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-40, 300) collectionViewLayout:layout];
//    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
//    [self.view addSubview:self.collectionView];
//
//
//
//}

#pragma mark - deleDate
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;

}
//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.picArry.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据identifier从缓冲池里去出cell
    UICollectionViewCell * cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = MASTER_COLOR;
    
    return cell;
    
}
#pragma mark - lazy


- (UICollectionView *)collectionView {
    if (!_collectionView) {
//
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 50) / 4;
//        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
//        layout.itemSize = CGSizeMake(width, 118);
//        layout.minimumInteritemSpacing = 0;
//        layout.minimumLineSpacing = 10;

        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小为100*100
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 50) /2;

        layout.itemSize = CGSizeMake(width, width);
        //创建collectionView 通过一个布局策略layout来创建
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-40, SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
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
