//
//  JMPictureManagerViewController.h
//  JMian
//
//  Created by mac on 2019/12/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMImageUrlModel.h"
#import "JMCompanyInfoViewController.h"
NS_ASSUME_NONNULL_BEGIN

@protocol JMPictureManagerViewControllerDelegate <NSObject>

-(void)pictureManagerWithPhotoModel_arr:(NSMutableArray *)photoModel_arr;
-(void)pictureManagerWithDelete_arr:(NSMutableArray *)delete_arr;

@end
@interface JMPictureManagerViewController : BaseViewController
@property(nonatomic,weak)id<JMPictureManagerViewControllerDelegate>delegate;
@property(nonatomic,strong)NSArray *photoModel_arr;
@property(nonatomic,strong)JMCompanyInfoViewController *vc;
//@property(nonatomic,copy)NSMutableArray *imgUrl_arr;//用于加载图片，渲染


@end

NS_ASSUME_NONNULL_END
