//
//  JMMyPictureViewController.h
//  JMian
//
//  Created by chitat on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMVitaDetailModel.h"
#import "JMCompanyInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol JMMyPictureViewControllerDelegate <NSObject>

-(void)sendArray_image_paths:(NSMutableArray *)image_paths;

@end

@interface JMMyPictureViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray *image_paths;//服务器获取的图片
@property (nonatomic, strong) NSMutableArray *filesModelArray;//用来提取公司图片的数组
@property (nonatomic, strong)JMFilesModel *model;
@property (nonatomic, weak) id<JMMyPictureViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
