//
//  JMTitleToLabelsTableViewCell.m
//  JMian
//
//  Created by mac on 2019/7/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTitleToLabelsTableViewCell.h"
#import "DimensMacros.h"
#import "JMPartTimeJobLabsCollectionViewCell.h"
#import "JMAssignmentSquareViewController.h"
#import "JMBUserPostPartTimeJobViewController.h"
#import "JMPostPartTimeResumeViewController.h"
@interface JMTitleToLabelsTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *labelsStrArr;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) JMLabsData *myLabData;



@end
static CGFloat kMagin = 10.f;
static NSString *cellID = @"conllectionCellLab";

@implementation JMTitleToLabelsTableViewCell
-(void)prepareForReuse{
    [super prepareForReuse];
    [self.collectionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

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
        [self initView];
    
    }
    return self;
}

-(void)initView{
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 27, 80, 20)];
    self.titleLab.text = @"行业";
    self.titleLab.textColor = TITLE_COLOR;
    self.titleLab.font = kFont(16);
    self.titleLab.textAlignment = NSLayoutAttributeCenterX;
    [self addSubview:self.titleLab];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab).offset(-20);
        make.left.mas_equalTo(self).offset(88);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];
}

-(void)setLabsData:(JMLabsData *)labsData myVc:(UIViewController *)myVc{
    _myLabData = labsData;
    self.titleLab.text = labsData.name;
    NSMutableArray *array = [NSMutableArray array];
    for (JMLabsData *data in labsData.children) {
        if ([myVc isKindOfClass:[JMBUserPostPartTimeJobViewController class]]) {
            if (![data.label_id isEqualToString:@"1091"]) {
                [array addObject:data.name];
            }
        }else if ([myVc isKindOfClass: [JMAssignmentSquareViewController class]]) {
                [array addObject:data.name];
            
        }else if ([myVc isKindOfClass: [JMPostPartTimeResumeViewController class]]) {
            [array addObject:data.name];
            
        }
        
    }
    self.labelsStrArr = array;
    [self.collectionView reloadData];
    
}

#pragma mark ====== UICollectionViewDelegate ======

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.labelsStrArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMPartTimeJobLabsCollectionViewCell *cell = (JMPartTimeJobLabsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.labName.text = self.labelsStrArr[indexPath.row];
  
//    cell.labName.text = self.labelsStrArr[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:self.imageNameArr[indexPath.row]];
    //    [cell.iconBtn setImage:[UIImage imageNamed:self.imageNameArr[indexPath.row]] forState:UIControlStateNormal];
//    cell.titleLabel.text = self.labelStrArr[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemWithData:)]) {
        [self.delegate didSelectItemWithData:_myLabData.children[indexPath.row]];
    }
    
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //自动网格布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
//        CGFloat itemWidth = (self.frame.size.width - 88  - 3 * kMagin) / 3;
        
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(82, 33);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 10;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 10;
        //设置senction的内边距@
        flowLayout.sectionInset = UIEdgeInsetsMake(kMagin, kMagin, kMagin, kMagin);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JMPartTimeJobLabsCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.borderWidth = 0;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

@end
