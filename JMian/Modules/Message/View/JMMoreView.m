//
//  JMMoreView.m
//  JMian
//
//  Created by mac on 2019/5/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMoreView.h"
#import "JMMoreCollectionViewCell.h"

@implementation JMMoreView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageNameArr = @[@"paizhao",@"Photo"];
        self.labelStrArr = @[@"拍照",@"相册"];
        [self addSubview:self.collectionView];
        self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return self;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageNameArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMMoreCollectionViewCell *cell = (JMMoreCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.imageNameArr[indexPath.row]];
    //    [cell.iconBtn setImage:[UIImage imageNamed:self.imageNameArr[indexPath.row]] forState:UIControlStateNormal];
    cell.titleLabel.text = self.labelStrArr[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemWithRow:)] ) {
//        [self.delegate didSelectItemWithRow:indexPath.row];
//    }
//
    NSLog(@"666");
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:)]) {
    //        [self.delegate didSelectItemAtIndexPath:indexPath withContent:self.dataAry[indexPath.row]];
    //    }
    
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 50) / 4;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.itemSize = CGSizeMake(width, 118);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JMMoreCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.borderWidth = 0;
    }
    return _collectionView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
