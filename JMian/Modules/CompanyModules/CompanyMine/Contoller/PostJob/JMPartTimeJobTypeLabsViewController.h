//
//  JMPartTimeJobTypeLabsViewController.h
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMPartTimeJobTypeLabsViewControllerDelegate <NSObject>

-(void)didChooseWithType_id:(NSString *)type_id typeName:(NSString *)typeName;

@end

@interface JMPartTimeJobTypeLabsViewController : BaseViewController

@property(nonatomic,weak)id<JMPartTimeJobTypeLabsViewControllerDelegate>delegate;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
