//
//  JMProductSpecificationViewController.m
//  JMian
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMProductSpecificationViewController.h"
#import "JMProductSpecicationConfigures.h"

@interface JMProductSpecificationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)JMProductSpecicationConfigures *cellConfigures;

@end

@implementation JMProductSpecificationViewController
static CGFloat kMagin = 10.f;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    JMProductColorData *data1 = [[JMProductColorData alloc]init];
    data1.colorName = @"红色";
    JMProductColorData *data2 = [[JMProductColorData alloc]init];
    data2.colorName = @"蓝色";
    JMProductColorData *data3 = [[JMProductColorData alloc]init];
    data3.colorName = @"绿色";
    JMProductColorData *data4 = [[JMProductColorData alloc]init];
    data4.colorName = @"黄色";
    JMProductColorData *data5 = [[JMProductColorData alloc]init];
    data5.colorName = @"紫色";
    self.cellConfigures.colorDataArr = @[data1,data2,data3,data4,data5];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.cellConfigures numberOfRowsInSection:section];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMProductSpefiColorCollectionViewCell *cell = (JMProductSpefiColorCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:JMProductSpefiColorCollectionViewCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];//取消选中
    NSLog(@"asdf");
    //    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:nil];
}

//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = MASTER_COLOR;
//
//}
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
//}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//
//return YES;
//}

#pragma mark - Navigation

- (UICollectionView *)collectionView {
    if (!_collectionView) {

        //自动网格布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat itemWidth = (self.view.frame.size.width) / 4;
        
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(itemWidth, 30);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 10;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 20;
        //设置senction的内边距@
        flowLayout.sectionInset = UIEdgeInsetsMake(kMagin, 20, kMagin, 20);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"JMProductSpefiColorCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:JMProductSpefiColorCollectionViewCellIdentifier];

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

-(JMProductSpecicationConfigures *)cellConfigures{
    if (!_cellConfigures) {
        _cellConfigures = [[JMProductSpecicationConfigures alloc]init];
    }
    return _cellConfigures;
}

@end
