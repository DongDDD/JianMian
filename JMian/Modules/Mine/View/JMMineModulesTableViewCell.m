//
//  JMMineModulesTableViewCell.m
//  JMian
//
//  Created by Chitat on 2019/3/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMineModulesTableViewCell.h"
#import <Masonry.h>
#import "JMMineModulesCollectionViewCell.h"
#import "DimensMacros.h"

@interface JMMineModulesTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *imageNameArr,*labelStrArr;

@end

@implementation JMMineModulesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            JMUserInfoModel *model = [JMUserInfoManager getUserInfo];

        if ([model.type isEqualToString:@"2"]) {
            self.imageNameArr = @[@"company_information",@"interview",@"enshrine",@"share2"];
            self.labelStrArr = @[@"公司信息",@"面试管理",@"人才收藏",@"分享APP"];
            
        }else if ([model.type isEqualToString:@"1"]){
        
            self.imageNameArr = @[@"myResume",@"C_videos",@"interview",@"enshrine"];
            self.labelStrArr = @[@"我的简历",@"视频简历",@"面试管理",@"职位收藏"];
        
        }
      
        
        [self.contentView addSubview:self.collectionView];
        self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 118);
    }
    return self;
}

#pragma mark ====== UICollectionViewDelegate ======

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageNameArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMMineModulesCollectionViewCell *cell = (JMMineModulesCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.imageNameArr[indexPath.row]];
//    [cell.iconBtn setImage:[UIImage imageNamed:self.imageNameArr[indexPath.row]] forState:UIControlStateNormal];
    cell.titleLabel.text = self.labelStrArr[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemWithRow:)] ) {
        [self.delegate didSelectItemWithRow:indexPath.row];
    }
    

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
        [_collectionView registerClass:[JMMineModulesCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.borderWidth = 0;
    }
    return _collectionView;
}


@end
