//
//  Demo2ViewController.m
//  照片选择器
//
//  Created by 洪欣 on 17/2/17.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import "JMPictureAddViewController.h"
#import "HXPhotoPicker.h"
#import "JMHTTPManager+Uploads.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface JMPictureAddViewController ()<HXPhotoViewDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;

@property (strong, nonatomic) UIButton *bottomView;

@property (assign, nonatomic) BOOL needDeleteItem;

@property (assign, nonatomic) BOOL showHud;

@property (strong, nonatomic) NSMutableArray *imageUrl_arr;

@end

@implementation JMPictureAddViewController
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
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self changeStatus];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeStatus];
    [self setRightBtnTextName:@"保存"];

}

-(void)rightAction{
    if (_delegate && [_delegate respondsToSelector:@selector(pictureAddWithImage_arr:)]) {
//        [_delegate pictureAddWithImg_arr:self.image_url];
        //self.imageUrl_arr用于上传服务器，self.image_arr用于保存当前临时数据（用户返回后再进来展现的图片）
        [_delegate pictureAddWithImage_arr:self.image_arr];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
- (UIButton *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomView setTitle:@"删除" forState:UIControlStateNormal];
        [_bottomView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomView setBackgroundColor:[UIColor redColor]];
        _bottomView.frame = CGRectMake(0, self.view.hx_h - 50, self.view.hx_w, 50);
        _bottomView.alpha = 0;
    }
    return _bottomView;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    HXWeakSelf
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools savePhotoToCustomAlbumWithName:self.manager.configuration.customAlbumName photo:image location:nil complete:^(HXPhotoModel *model, BOOL success) {
                if (success) {
                    if (weakSelf.manager.configuration.useCameraComplete) {
                        weakSelf.manager.configuration.useCameraComplete(model);
                    }
                }else {
                    [weakSelf.view hx_showImageHUDText:@"保存图片失败"];
                }
            }];
        }else {
            HXPhotoModel *model = [HXPhotoModel photoModelWithImage:image];
            if (self.manager.configuration.useCameraComplete) {
                self.manager.configuration.useCameraComplete(model);
            }
        }
    }else  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *url = info[UIImagePickerControllerMediaURL];
        
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools saveVideoToCustomAlbumWithName:self.manager.configuration.customAlbumName videoURL:url location:nil complete:^(HXPhotoModel *model, BOOL success) {
                if (success) {
                    if (weakSelf.manager.configuration.useCameraComplete) {
                        weakSelf.manager.configuration.useCameraComplete(model);
                    }
                }else {
                    [weakSelf.view hx_showImageHUDText:@"保存视频失败"];
                }
            }];
        }else {
            HXPhotoModel *model = [HXPhotoModel photoModelWithVideoURL:url];
            if (self.manager.configuration.useCameraComplete) {
                self.manager.configuration.useCameraComplete(model);
            }
        }
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Fallback on earlier versions
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat width = scrollView.frame.size.width;
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager scrollDirection:UICollectionViewScrollDirectionVertical];
    photoView.frame = CGRectMake(0, kPhotoViewMargin, width, 0);
    photoView.collectionView.contentInset = UIEdgeInsetsMake(0, kPhotoViewMargin, 0, kPhotoViewMargin);
//    photoView.spacing = kPhotoViewMargin;
    photoView.delegate = self;
    photoView.outerCamera = YES;
    photoView.previewStyle = HXPhotoViewPreViewShowStyleDark;
    photoView.previewShowDeleteButton = YES;
    photoView.showAddCell = YES;
//    photoView.adaptiveDarkness = NO;
    [photoView.collectionView reloadData];
    [scrollView addSubview:photoView];
    self.photoView = photoView;
    

    [self.view addSubview:self.bottomView];
//    [UINavigationBar appearance].translucent = NO;
}
- (void)dealloc {
    NSSLog(@"dealloc");
}

#pragma mark -delegate

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    [self changeStatus];
    //    NSSLog(@"%@",[videos.firstObject videoURL]);
    //    HXPhotoModel *photoModel = allList.firstObject;
    
    [allList hx_requestImageWithOriginal:isOriginal completion:^(NSArray<UIImage *> * _Nullable imageArray, NSArray<HXPhotoModel *> * _Nullable errorArray) {
        // imageArray 获取成功的image数组
        // errorArray 获取失败的model数组
        NSSLog(@"\nimage: %@\nerror: %@",imageArray,errorArray);
        self.image_arr = imageArray;
//        [self.imageUrl_arr removeAllObjects];
//        for (UIImage *img in imageArray) {
//            [self getUrlRequestWithImg:img];
//        }
    }];
}
- (void)photoViewCurrentSelected:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
//    NSMutableArray *imageList = [NSMutableArray array];
//    for (HXPhotoModel *photoModel in allList) {
//        NSSLog(@"当前选择----> %@", photoModel.selectIndexStr);
//        [imageList addObject:photoModel.previewPhoto];
//
//    }
//
//    [self.image_url removeAllObjects];
//    for (UIImage *img in imageList) {
////        [self getUrlRequestWithImg:img];
//    }
    
}

- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
}

- (void)photoViewPreviewDismiss:(HXPhotoView *)photoView {
    [self changeStatus];
}
- (void)photoViewDidCancel:(HXPhotoView *)photoView {
    [self changeStatus];
}
- (void)photoView:(HXPhotoView *)photoView currentDeleteModel:(HXPhotoModel *)model currentIndex:(NSInteger)index {
    NSSLog(@"%@ --> index - %ld",model,index);
}
- (BOOL)photoView:(HXPhotoView *)photoView collectionViewShouldSelectItemAtIndexPath:(NSIndexPath *)indexPath model:(HXPhotoModel *)model {
    return YES;
}

- (BOOL)photoViewShouldDeleteCurrentMoveItem:(HXPhotoView *)photoView gestureRecognizer:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    return self.needDeleteItem;
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerBegan:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.alpha = 0.5;
    }];
    NSSLog(@"长按手势开始了 - %ld",indexPath.item);
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerChange:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    CGPoint point = [longPgr locationInView:self.view];
    if (point.y >= self.bottomView.hx_y) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomView.alpha = 1;
        }];
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomView.alpha = 0.5;
        }];
    }
    NSSLog(@"长按手势改变了 %@ - %ld",NSStringFromCGPoint(point), indexPath.item);
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerEnded:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    CGPoint point = [longPgr locationInView:self.view];
    if (point.y >= self.bottomView.hx_y) {
        self.needDeleteItem = YES;
        [self.photoView deleteModelWithIndex:indexPath.item];
    }else {
        self.needDeleteItem = NO;
    }
    NSSLog(@"长按手势结束了 - %ld",indexPath.item);
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.alpha = 0;
    }];
}

#pragma mark -上传图片到服务器

-(void)getUrlRequestWithImg:(UIImage *)img{
    NSArray *array = @[img];
    if (array.count > 0) {
        [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            if (responsObject[@"data"]) {
                NSString *url = responsObject[@"data"][0];
                [self.imageUrl_arr addObject:url];
            }
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }
    
}

#pragma mark -lazy

- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.openCamera = YES;
        // 暗黑风格
//        _manager.configuration.photoStyle = HXPhotoStyleDark;
//        _manager.configuration.showOriginalBytesLoading = YES;
        _manager.configuration.lookLivePhoto = YES;
        _manager.configuration.photoMaxNum = 9;
        _manager.configuration.videoMaxNum = 1;
        _manager.configuration.maxNum = 9;
        _manager.configuration.videoMaximumSelectDuration = 15;
        _manager.configuration.videoMinimumSelectDuration = 0;
        _manager.configuration.videoMaximumDuration = 15.f;
        _manager.configuration.creationDateSort = NO;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.showOriginalBytes = YES;
        _manager.configuration.selectTogether = NO;
        _manager.configuration.requestImageAfterFinishingSelection = YES;
        _manager.configuration.navBarBackgroudColor =MASTER_COLOR;
        _manager.configuration.themeColor = [UIColor whiteColor];
        _manager.configuration.statusBarStyle = UIStatusBarStyleLightContent;
        _manager.configuration.navigationTitleColor = [UIColor whiteColor];
        _manager.configuration.cellSelectedBgColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
        _manager.configuration.cellSelectedTitleColor = [UIColor whiteColor];
        _manager.configuration.selectedTitleColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
        _manager.configuration.navBarTranslucent = NO;
        _manager.configuration.bottomViewBgColor = MASTER_COLOR;
        _manager.configuration.bottomViewTranslucent = NO;
        _manager.configuration.selectVideoBeyondTheLimitTimeAutoEdit = YES;
        NSMutableArray *assets = [NSMutableArray array];;
        for (UIImage *image in self.image_arr) {
            HXCustomAssetModel *asset = [HXCustomAssetModel assetWithLocalImage:image selected:YES];
            [assets addObject:asset];
        }
        [_manager addCustomAssetModel:assets];
        //        _manager.configuration.navBarBackgroundImage = [UIImage imageNamed:@"APPCityPlayer_bannerGame"];
        HXWeakSelf
        _manager.configuration.photoListBottomView = ^(HXPhotoBottomView *bottomView) {
            //            bottomView.bgView.translucent = NO;
            //            if ([HXPhotoCommon photoCommon].isDark) {
            //                bottomView.bgView.barTintColor = [UIColor blackColor];
            //            }else {
            //                bottomView.bgView.barTintColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
            //            }
        };
        _manager.configuration.previewBottomView = ^(HXPhotoPreviewBottomView *bottomView) {
            //            bottomView.bgView.translucent = NO;
            //            bottomView.tipView.translucent = NO;
            //            if ([HXPhotoCommon photoCommon].isDark) {
            //                bottomView.bgView.barTintColor = [UIColor blackColor];
            //                bottomView.tipView.barTintColor = [UIColor blackColor];
            //            }else {
            //                bottomView.bgView.barTintColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
            //                bottomView.tipView.barTintColor = [UIColor colorWithRed:60.f / 255.f green:131.f / 255.f blue:238.f / 255.f alpha:1];
            //            }
        };
        _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager) {
            
            // 这里拿使用系统相机做例子
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
            NSString *requiredMediaTypeImage = ( NSString *)kUTTypeImage;
            NSString *requiredMediaTypeMovie = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes;
            if (cameraType == HXPhotoConfigurationCameraTypePhoto) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage,nil];
            }else if (cameraType == HXPhotoConfigurationCameraTypeVideo) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeMovie,nil];
            }else {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediaTypeMovie,nil];
            }
            [imagePickerController setMediaTypes:arrMediaTypes];
            // 设置录制视频的质量
            [imagePickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [imagePickerController setVideoMaximumDuration:60.f];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}

-(NSMutableArray *)imageUrl_arr{

    if (!_imageUrl_arr) {
        _imageUrl_arr = [NSMutableArray array];
    }
    return _imageUrl_arr;
}


@end
