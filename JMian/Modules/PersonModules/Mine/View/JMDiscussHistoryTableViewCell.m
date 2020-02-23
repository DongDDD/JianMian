//
//  JMDiscussHistoryTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMDiscussHistoryTableViewCell.h"
#import "DimensMacros.h"
#import "JMDiscussHistoryImageCollectionViewCell.h"
#import "APIStringMacros.h"
NSString *const JMDiscussHistoryTableViewCellIdentifier = @"JMDiscussHistoryTableViewCellIdentifier";

@implementation JMDiscussHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.msgLab.mas_bottom);
        make.height.mas_equalTo(60);
    }];
}

-(void)setData:(JMDiscussHistoryCellData *)data{
    self.timeLab.text = data.created_at;
    if ([data.sender_id isEqualToString:data.boss_id]) {
        self.nameLab.text = @"卖家";
    }else{
        self.nameLab.text = @"买家";

    }
    self.msgLab.text = data.message;
    self.imageArr = data.files;
    [self.collectionView reloadData];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ====== UICollectionViewDelegate ======

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMDiscussHistoryImageCollectionViewCell *cell = (JMDiscussHistoryImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //    [cell.iconBtn setImage:[UIImage imageNamed:self.imageNameArr[indexPath.row]] forState:UIControlStateNormal];
    NSString *url = [NSString stringWithFormat:@"%@%@",IMG_BASE_URL_STRING,_imageArr[indexPath.row]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 50) / 6;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.itemSize = CGSizeMake(width, 40);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JMDiscussHistoryImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.borderWidth = 0;
    }
    return _collectionView;
}
@end
