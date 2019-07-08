//
//  JMBMineInfoView.m
//  JMian
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBMineInfoView.h"
#import "JMMineModulesCollectionViewCell.h"
#import "DimensMacros.h"

@interface JMBMineInfoView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *imageNameArr,*labelStrArr;
@property (nonatomic, strong) UIView *BGView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation JMBMineInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
//
//        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.imageNameArr = @[@"post_a_job_pitch_up",@"company_information",@"interview",@"enshrine"];
        self.labelStrArr = @[@"职位管理",@"公司信息",@"面试管理",@"人才收藏"];
        [self initView];
        [self initLayout];

    }
    return self;
}

-(void)initView{
    _BGView = [[UIView alloc]init];
    
    _imgView = [[UIImageView alloc]init];
    _imgView.image = [UIImage imageNamed:@"tiao"];
    [self addSubview:_imgView];

    
    _titleLab = [[UILabel alloc]init];
    _titleLab.textColor = TITLE_COLOR;
    _titleLab.font = kFont(16);
    _titleLab.text = @"公司信息";
    [self addSubview:_titleLab];

    
    [self addSubview:self.BGView];
    [self.BGView addSubview:self.collectionView];
    
    self.BGView.layer.shadowColor = [UIColor colorWithRed:20/255.0 green:31/255.0 blue:87/255.0 alpha:0.1].CGColor;
    self.BGView.layer.shadowOffset = CGSizeMake(0,1);
    self.BGView.layer.shadowOpacity = 1;
    self.BGView.layer.shadowRadius = 6;
    self.BGView.layer.cornerRadius = 10;
    self.BGView.backgroundColor = [UIColor whiteColor];
}

-(void)initLayout{
    
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17);
        make.left.mas_equalTo(self).offset(30);
        make.top.mas_equalTo(self).offset(10);
        
    }];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(4);
        make.right.mas_equalTo(_titleLab.mas_left).offset(-10);
        make.centerY.mas_equalTo(_titleLab);
    }];
    
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(13);
        make.right.mas_equalTo(self).offset(-13);
        make.height.mas_equalTo(95);
        make.top.mas_equalTo(_titleLab.mas_bottom).offset(13);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.BGView).offset(5);
        make.right.mas_equalTo(self.BGView).offset(-5);
        make.top.mas_equalTo(self.BGView).offset(5);
        make.bottom.mas_equalTo(self.BGView).offset(-5);
        
    }];


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
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 50-40) / 4;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.itemSize = CGSizeMake(width, 118);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[JMMineModulesCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.borderWidth = 0;
    }
    return _collectionView;
}


@end
