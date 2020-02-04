//
//  JMCSaleTypeDetailGoodsTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMCSaleTypeDetailGoodsTableViewCell.h"
#import "JMGoodsCollectionViewCell.h"
#import "DimensMacros.h"
NSString *const JMCSaleTypeDetailGoodsTableViewCellIdentifier = @"JMCSaleTypeDetailGoodsTableViewCellIdentifier";

@interface JMCSaleTypeDetailGoodsTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *myGoodsArray;

@end

@implementation JMCSaleTypeDetailGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(void)setGoodsArray:(NSArray *)goodsArray{
    _myGoodsArray = goodsArray;
    [self addSubview:self.collectionView];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myGoodsArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMGoodsCollectionViewCell *cell = (JMGoodsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:JMGoodsCollectionViewCellIdentifier forIndexPath:indexPath];
    JMGoodsData *data = self.myGoodsArray[indexPath.row];
    [cell setData:data];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedGoodsItemsWithModel:)]) {
        JMGoodsData *data = self.myGoodsArray[indexPath.row];
        [_delegate didSelectedGoodsItemsWithModel:data];
    }
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
        
//        CGFloat itemWidth = (SCREEN_WIDTH) / 3;
        
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(157, 207);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 10;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 20;
        //设置senction的内边距@
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"JMGoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:JMGoodsCollectionViewCellIdentifier];

        _collectionView.backgroundColor = BG_COLOR;
        _collectionView.layer.borderWidth = 0;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

@end
