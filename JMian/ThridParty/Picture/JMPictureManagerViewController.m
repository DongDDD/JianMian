//
//  Demo3ViewController.m
//  照片选择器
//
//  Created by 洪欣 on 17/2/17.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import "JMPictureManagerViewController.h"
#import "HXPhotoPicker.h"
#import "JMHTTPManager+Uploads.h"
#import "JMHTTPManager+DeleteGoodsImage.h"

//#import "SDWebImageManager.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface JMPictureManagerViewController ()<HXPhotoViewDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (weak, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
//@property (strong, nonatomic) NSMutableArray *image_arr;//选好添加的图片链接
//@property (strong, nonatomic) NSMutableArray *image_arr2;//选好添加的图片链接
//@property (strong, nonatomic) NSMutableArray *myImgUrl_arr;//

//@property(nonatomic,strong)NSMutableArray *imgModelArr1;
@property(nonatomic,strong)NSMutableArray *myPhotoModel_arr;

@property(nonatomic,assign)int isChangeCount;
@property(nonatomic,strong)NSMutableArray *delete_arr;

//@property(nonatomic,strong)NSMutableArray *imgUrl_arr;


//@property(nonatomic,strong)NSMutableArray *imageModel_arr2;

//@property (assign, nonatomic) NSInteger index;//标记选好添加图片顺序
//@property (strong, nonatomic) NSMutableArray *index_arr;//选后图片后的标记数组

//@property (nonatomic, assign)BOOL isChange;


@end

@implementation JMPictureManagerViewController
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
#ifdef __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        [self preferredStatusBarUpdateAnimation];
        [self changeStatus];
    }
#endif
}
- (UIStatusBarStyle)preferredStatusBarStyle {
#ifdef __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return UIStatusBarStyleLightContent;
        }
    }
#endif
    return UIStatusBarStyleDefault;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeStatus];
    [self setRightBtnTextName:@"保存"];
    [self showProgressHUD_view:[UIApplication sharedApplication].keyWindow];
    [self hiddenHUD];

}

- (void)changeStatus {
#ifdef __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
            return;
        }
    }
#endif
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Fallback on earlier versions
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片";
#ifdef __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return UIColor.blackColor;
            }
            return UIColor.whiteColor;
        }];
    }
#endif
//    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat width = scrollView.frame.size.width;
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(kPhotoViewMargin, kPhotoViewMargin, width - kPhotoViewMargin * 2, 0);
    photoView.lineCount = 3;
    photoView.delegate = self;
//    photoView.showAddCell = NO;
    [scrollView addSubview:photoView];
    self.photoView = photoView;
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"http://oss-cn-hangzhou.aliyuncs.com/tsnrhapp/shop/photos/857980fd0acd3caf9e258e42788e38f5_0.gif",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0034821a-6815-4d64-b0f2-09103d62630d.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0be5118d-f550-403e-8e5c-6d0badb53648.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/1466408576222.jpg", nil];
//    NSMutableArray *img_arr = [NSMutableArray array];
////    [self.myImageModel_arr addObjectsFromArray:self.imageModel_arr];
//    if (self.photoModel_arr.count > 0) {
//        for (HXPhotoModel *model in self.photoModel_arr) {
//            if (model.previewPhoto) {
//                [img_arr addObject:model.previewPhoto];
//            }else{
//                [img_arr addObject:model.networkPhotoUrl];
//            }
//        }
//        HXPhotoModel *photoModel = self.photoModel_arr[0];
//        if (photoModel.previewPhoto) {
//            //用image加载
//            NSMutableArray *assets = @[].mutableCopy;
//            for (UIImage *image in img_arr) {
//                HXCustomAssetModel *asset = [HXCustomAssetModel assetWithLocalImage:image selected:YES];
//                [assets addObject:asset];
//            }
//            [_manager addCustomAssetModel:assets];
//            //    [self.manager addNetworkingImageToAlbum:array selected:YES];
//            [self.photoView refreshView];
//        }else{
//            //用图片链接加载
//            NSMutableArray *assets = @[].mutableCopy;
//            for (NSURL *url in img_arr) {
//                HXCustomAssetModel *asset = [HXCustomAssetModel assetWithNetworkImageURL: url selected:YES];
//                [assets addObject:asset];
//            }
//            [self.manager addCustomAssetModel:assets];
//            //    [self.manager addNetworkingImageToAlbum:array selected:YES];
//        }
//
//    }
    NSMutableArray *imgUrl_arr = [NSMutableArray array];
    for (HXPhotoModel *model  in self.photoModel_arr) {
        if ([[model.networkPhotoUrl absoluteString] containsString:@"http"]) {
            [imgUrl_arr addObject:[model.networkPhotoUrl absoluteString]];
            
        }else{
            NSString *str = [NSString stringWithFormat:@"http://produce.jmzhipin.com%@",[model.networkPhotoUrl absoluteString]];
            [imgUrl_arr addObject:str];

        }
    }
    NSMutableArray *assets = @[].mutableCopy;
    for (NSString *url in imgUrl_arr) {
        HXCustomAssetModel *asset = [HXCustomAssetModel assetWithNetworkImageURL: [NSURL URLWithString: url] selected:YES];
        [assets addObject:asset];
    }
    [self.manager addCustomAssetModel:assets];
    //    [self.manager addNetworkingImageToAlbum:array selected:YES];
    [self.photoView refreshView];
    
    
    // 可以在懒加载中赋值 ,  也可以这样赋值
//    self.manager.networkPhotoUrls = ;
    
//    photoView.manager = self.manager;
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"添加网络" style:UIBarButtonItemStylePlain target:self action:@selector(addNetworkPhoto)];
//
//    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"清空缓存" style:UIBarButtonItemStylePlain target:self action:@selector(lookClick)];
//
//    self.navigationItem.rightBarButtonItems = @[item1,item2];
}



-(void)rightAction{
    NSLog(@"%@",self.myPhotoModel_arr);
    if (_isChangeCount > 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(pictureManagerWithPhotoModel_arr:)]) {
            [_delegate pictureManagerWithPhotoModel_arr:self.myPhotoModel_arr];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(pictureManagerWithDelete_arr:)]) {
               [_delegate pictureManagerWithDelete_arr:self.delete_arr];
           }
        [self.navigationController popViewControllerAnimated:YES];

    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

//-(void)yanchidiaoyong{
//    self.myImgUrl_arr = [NSMutableArray array];
//    [self.myImgUrl_arr addObjectsFromArray:self.imgUrl_arr];
////    [self.myImgUrl_arr addObjectsFromArray:self.image_arr2];
//    NSLog(@"self.myImgUrl_arr%@",self.myImgUrl_arr);
//}
//- (void)lookClick {
//    [[YYWebImageManager sharedManager].cache.diskCache removeAllObjects];
//    [[YYWebImageManager sharedManager].cache.memoryCache removeAllObjects];
////    [[SDWebImageManager sharedManager] cancelAll];
////    [[SDWebImageManager sharedManager].imageCache clearWithCacheType:SDImageCacheTypeAll completion:^{
////
////    }];
////    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
//
////    }];
////    [[SDImageCache sharedImageCache] clearMemory];
////#if SDWebImageEmbed
////#endif
//    return;
//}
//- (void)addNetworkPhoto {
//    if (self.manager.afterSelectPhotoCountIsMaximum) {
//        [self.view hx_showImageHUDText:@"图片已达到最大数"];
//        return;
//    }
//    int x = arc4random() % 4;
//    NSString *url;
//    if (x == 0) {
//        url = @"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0034821a-6815-4d64-b0f2-09103d62630d.jpg";
//    }else if (x == 1) {
//        url = @"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0be5118d-f550-403e-8e5c-6d0badb53648.jpg";
//    }else {
//        url = @"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/1466408576222.jpg";
//    }
//    HXCustomAssetModel *asset = [HXCustomAssetModel assetWithLocalVideoURL:[NSURL URLWithString:url] selected:YES];
//    [self.manager addCustomAssetModel:@[asset]];
////    [self.manager addNetworkingImageToAlbum:@[url] selected:YES];
//    [self.photoView refreshView];
//}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    _isChangeCount++;

    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    [self.toolManager writeSelectModelListToTempPathWithList:allList requestType:0 success:^(NSArray<NSURL *> *allURL, NSArray<NSURL *> *photoURL, NSArray<NSURL *> *videoURL) {
        NSSLog(@"allURL--%@",allURL);
        
        
    } failed:^{

    }];
    
    [self.toolManager getSelectedImageList:allList success:^(NSArray<UIImage *> *imageList) {
        NSLog(@"getSelectedImageList");
        [self.myPhotoModel_arr removeAllObjects];
        //1 制作model:匹配file_id  file_id用于识别该图片是原来的还是新添加的
        for (HXPhotoModel *model1 in allList) {
            for (HXPhotoModel *model2 in self.photoModel_arr) {
                if ([[model1.networkPhotoUrl absoluteString] containsString:[model2.networkPhotoUrl absoluteString]]) {
                    model1.file_id = model2.file_id;

                }
            }
            [self.myPhotoModel_arr addObject:model1];
        }
        //2 制作好model了，把新增加的图片上传到服务器
        for (HXPhotoModel *photoModel in self.myPhotoModel_arr) {
            if (![[photoModel.networkPhotoUrl absoluteString] containsString:@"http"] && ![[photoModel.networkPhotoUrl absoluteString] containsString:@"storage"]) {
                [self getUrlRequestWithModel:photoModel];
            }
            
        }
                
    } failed:^{
        //        [weakSelf.view handleLoading];
    }];
            
    

}

- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
    for (HXPhotoModel *model in self.photoModel_arr) {
        if (model.file_id && [[model.networkPhotoUrl absoluteString] containsString:networkPhotoUrl]) {
//            [self.delete_arr addObject:model.localIdentifier];
            [self deleteGoodsImageRequsetWithFile_id:model.file_id];
        }
    }
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame
{
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
}

#pragma mark -上传图片到服务器

-(void)getUrlRequestWithModel:(HXPhotoModel *)model{
    [self showHUD];
    UIImage *img = model.previewPhoto;
    NSArray *array = @[img];
    if (array.count > 0) {
        [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            if (responsObject[@"data"]) {
                NSString *url = responsObject[@"data"][0];
//                NSString *url2 = [NSString stringWithFormat:@"https://jmsp-images-1257721067.picgz.myqcloud.com%@",url];
                
//                [self.image_arr2 replaceObjectAtIndex:index withObject:url2];
                [self hiddenHUD];
//                for (HXPhotoModel *model  in self.myImageModel_arr) {
//                    if (index == model.selectedIndex) {
                        model.networkPhotoUrl = [NSURL URLWithString:url];
                
                [self.myPhotoModel_arr replaceObjectAtIndex:model.selectedIndex withObject:model];
//                    }
//                }
                
                
//                self.image_arr = self.image_arr2;
//                if (index == self.image_arr2.count-1) {
//                    [self.myImgUrl_arr addObjectsFromArray:self.image_arr2];
//                    NSLog(@"添加的图片链接（顺序正确的）%@",self.myImgUrl_arr);
////                    [self.photoView refreshView]
//
//                }
//                self.image_arr = self.image_arr2;
            }
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

        }];

    }

}

-(void)deleteGoodsImageRequsetWithFile_id:(NSString *)file_id{
    [self showHUD];
    [[JMHTTPManager sharedInstance]deleteGoodsImageWithFile_id:file_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除成功" preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        }])];
//        [self presentViewController:alertController animated:YES completion:nil];
        [self hiddenHUD];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}



#pragma mark -lazy

//-(NSMutableArray *)image_arr{
//
//    if (!_image_arr) {
//        _image_arr = [NSMutableArray array];
//    }
//    return _image_arr;
//}

//-(NSMutableArray *)myImgUrl_arr{
//
//    if (!_myImgUrl_arr) {
//        _myImgUrl_arr = [NSMutableArray array];
//    }
//    return _myImgUrl_arr;
//}

-(NSMutableArray *)myPhotoModel_arr{

    if (!_myPhotoModel_arr) {
        _myPhotoModel_arr = [NSMutableArray array];
    }
    return _myPhotoModel_arr;
}

-(NSMutableArray *)delete_arr{

    if (!_delete_arr) {
        _delete_arr = [NSMutableArray array];
    }
    return _delete_arr;
}



//-(NSMutableArray *)image_arr2{
//
//    if (!_image_arr2) {
//        _image_arr2 = [NSMutableArray array];
//    }
//    return _image_arr2;
//}


//-(NSMutableArray *)imgUrl_arr{
//
//    if (!_imgUrl_arr) {
//        _imgUrl_arr = [NSMutableArray array];
//    }
//    return _imgUrl_arr;
//}

- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        //        _manager.openCamera = NO;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.photoMaxNum = 9; //
        _manager.configuration.videoMaxNum = 5;  //
        _manager.configuration.maxNum = 5;
        _manager.configuration.navBarBackgroudColor =MASTER_COLOR;
        _manager.configuration.showOriginalBytes = YES;
        _manager.configuration.themeColor = [UIColor whiteColor];
        _manager.configuration.statusBarStyle = UIStatusBarStyleLightContent;
        _manager.configuration.navigationTitleColor = [UIColor whiteColor];
        _manager.configuration.cellSelectedBgColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
        _manager.configuration.cellSelectedTitleColor = [UIColor whiteColor];
        _manager.configuration.selectedTitleColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
        _manager.configuration.navBarTranslucent = NO;
        _manager.configuration.bottomViewBgColor = MASTER_COLOR;
//        _manager.networkPhotoUrls = [NSMutableArray arrayWithObjects:@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/003d86db-b140-4162-aafa-d38056742181.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0034821a-6815-4d64-b0f2-09103d62630d.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0be5118d-f550-403e-8e5c-6d0badb53648.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/1466408576222.jpg", nil];
    }
    return _manager;
}
- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}
@end
