//
//  Demo3ViewController.m
//  照片选择器
//
//  Created by 洪欣 on 17/2/17.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import "Demo3ViewController.h"
#import "HXPhotoPicker.h"
#import "SDWebImageManager.h"
#import "DimensMacros.h"
#import "JMHTTPManager+CompanyInfoUpdate.h"
#import "JMHTTPManager+CompanyFileDelete.h"
#import "JMUserInfoModel.h"
#import "JMUserInfoManager.h"
#import "JMHTTPManager+Uploads.h"
#import "JMHTTPManager+FetchCompanyInfo.h"
#import "JMHTTPManager+UpdateAbility.h"
#import "JMAbilityCellData.h"
#import "JMHTTPManager+DeleteAbilityImage.h"
#import "JMHTTPManager+FectchTaskInfo.h"
#import "JMTaskPartTimejobDetailModel.h"
#import "JMHTTPManager+FectchAbilityInfo.h"



static const CGFloat kPhotoViewMargin = 12.0;

@interface Demo3ViewController ()<HXPhotoViewDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (weak, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
@property (strong, nonatomic) NSArray *lastArry;
//@property (strong, nonatomic)NSMutableArray *addImgPathArray;
//@property (strong, nonatomic)NSMutableArray *addImgArray;//UIImage类型

@property (strong, nonatomic)JMCompanyInfoModel *companyInfoModel;

@property (nonatomic, strong) NSMutableArray *addImage_paths;//添加的图片（服务器返回的链接数组）

@property (nonatomic, strong) NSMutableArray *imageList;//目前展示的图片，UIImage类型
@property (nonatomic, strong) NSMutableArray *partTResumeAddImgs;//UIImage类型

@property (nonatomic, assign)BOOL isChange;

@end

@implementation Demo3ViewController
- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        //        _manager.openCamera = NO; 
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.photoMaxNum = 9; //
        _manager.configuration.videoMaxNum = 5;  //
        _manager.configuration.maxNum = 14;
        
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


- (NSMutableArray *)filesModelArray {
    if (!_filesModelArray) {
        _filesModelArray = [NSMutableArray array];
    }
    return _filesModelArray;
}

-(NSMutableArray *)addImage_paths{
    
    if (!_addImage_paths) {
        _addImage_paths = [NSMutableArray array];
    }
    return _addImage_paths;
}

-(NSMutableArray *)partTResumeAddImgs{
    
    if (!_partTResumeAddImgs) {
        _partTResumeAddImgs = [NSMutableArray array];
    }
    return _partTResumeAddImgs;
}
-(NSMutableArray *)image_paths{
    
    if (!_image_paths) {
        _image_paths = [NSMutableArray array];
    }
    return _image_paths;
}

-(NSMutableArray *)imageList{
    
    if (!_imageList) {
        _imageList = [NSMutableArray array];
    }
    return _imageList;
}
#pragma mark - 网络请求获取图片

//获取公司最新图片数据
-(void)getCompanyImagesData{
    JMUserInfoModel *_userInfoModel = [JMUserInfoManager getUserInfo];
    [[JMHTTPManager sharedInstance]fetchCompanyInfo_Id:_userInfoModel.company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.companyInfoModel = [JMCompanyInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            if (self.companyInfoModel.files.count > 0) {
                for (JMFilesModel *filesModel in self.companyInfoModel.files) {
                    if ([filesModel.type isEqualToString:@"2"]) {//过滤视频走 只要图片
                        [self.filesModelArray addObject:filesModel];
                    }
                }
            }
            
        }
        
        if (self.filesModelArray.count > 0) {//获得图片链接数组
            self.image_paths = [NSMutableArray array];
            for (JMFilesModel *filesModel in self.filesModelArray) {
                [self.image_paths addObject:filesModel.files_file_path];
            }
        }
        
        
        [self initView];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)getGoodsImageData{
    [[JMHTTPManager sharedInstance]fectchTaskInfo_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMTaskPartTimejobDetailModel *model = [JMTaskPartTimejobDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
//            //赋值
//            [self setRightBtnValues_model:model];
            for (JMImageModel *data in model.images) {
                
                [self.image_paths addObject:data.file_path];
            }
            
            [self initView];

        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
}




//获取兼职简历图片
-(void)getPartTimeJobResumeData{
    [[JMHTTPManager sharedInstance]fectchAbilityDetailInfo_Id:self.ability_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMAbilityCellData *partTimeJobModel = [JMAbilityCellData mj_objectWithKeyValues:responsObject[@"data"]];
            
            for (JMImageModel *data in partTimeJobModel.images) {
                
                [self.image_paths addObject:data.file_path];
            }
            
            [self initView];
            
            //            if (self.partTimeVitaModel.video_file_path!=nil) {
            //
            //                NSURL *url = [NSURL URLWithString:self.partTimeVitaModel.video_file_path];
            //
            //
            //
            //            }
//            [self setRightText_model:self.myPartTimeVitaModel];
//            [self.tableView reloadData];
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)initView{
    
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
    photoView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:photoView];
    self.photoView = photoView;
    [self.manager addNetworkingImageToAlbum:self.image_paths selected:YES];
    [self.photoView refreshView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片";
    [self setRightBtnTextName:@"保存"];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    //    [self initView];
    if (_viewType == Demo3ViewPartTimeResumeAdd){//个人发布兼职简历
        [self initView];
        
    }else if (_viewType == Demo3ViewPostGoodsPositionAdd) {//发布商品图片
        [self initView];
        
    }else if (_viewType == Demo3ViewPostGoodsPositionEdit) {//商品图片编辑
        [self getGoodsImageData];
        
    }else if (_viewType == Demo3ViewPartTimeResumeEdit) {//个人兼职简历编辑
        [self getPartTimeJobResumeData];
        
    }else if (_viewType == Demo3ViewCompanyInfoEdit) {//公司信息图片编辑
        [self getCompanyImagesData];//获取服务器最新图片数组
    }else if (_viewType == Demo3ViewPostPartTimeJobEdit) {//编辑任务图片
        [self getGoodsImageData];
        
    }else if (_viewType == Demo3ViewPostPartTimeJobAdd) {//发布任务图片
        [self initView];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getImage:) name:@"SendImageNotification" object:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDeleteImage:) name:@"SendDeleteImageNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteImage:) name:@"DeleteImgNotification" object:nil];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    for (UIImage *img in self.partTResumeAddImgs) {
//        [self sendRequstTest_img:img];
//    }
//    for (int i = 0; i < self.partTResumeAddImgs.count; i++) {
//        UIImage *img = self.partTResumeAddImgs[i];
//
//
//    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
#pragma mark -增加了的图片

//获取选中图片
-(void)getImage:(NSNotification *)notification{
//    UIImage * img = notification.object;
    _isChange = YES;
    HXPhotoModel *model = notification.object;
    
//    [self.partTResumeAddImgs addObject:img];
    if (model.previewPhoto) {
        [self sendRequst_img:model.previewPhoto];
    }
}

//-(void)getDeleteImage:(NSNotification *)notification{
//    UIImage * img = notification.object;
//    [self.partTResumeAddImgs removeObject:img];
//
////    [self sendRequst_img:img];
//}


#pragma mark -上传图片并返回
-(void)rightAction{
    [self.navigationController popViewControllerAnimated:YES];
    [self lookClick];
    NSLog(@"上传图片---：%@",_addImage_paths);
    if ( _addImage_paths.count > 0 ) {
        if (_viewType == Demo3ViewPartTimeResumeEdit) {

            [_delegate sendAddImgs:self.addImage_paths];//传透增加了的图片数组 直接丢给服务器 没前缀
            
        }else if (_viewType == Demo3ViewCompanyInfoEdit) {
            //公司上传图片
            [_delegate sendAddImgs:self.addImage_paths];//传透增加了的图片数组 直接丢给服务器 没前缀

//            [self uploadCompanyWithImages:_addImage_paths];
        }else if (_viewType == Demo3ViewPostGoodsPositionEdit ||_viewType == Demo3ViewPostPartTimeJobEdit) {
            
            [_delegate sendAddImgs:self.addImage_paths];//传透增加了的图片数组 直接丢给服务器 没前缀
            
        }else if (_viewType == Demo3ViewPostGoodsPositionAdd ||_viewType == Demo3ViewPostPartTimeJobAdd ) {

      
            if (_delegate && [_delegate respondsToSelector:@selector(sendArray_addImageUrls:)]) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSString *url  in self.addImage_paths) {
                    NSString *url1 = [NSString stringWithFormat:@"https://jmsp-images-1257721067.picgz.myqcloud.com%@",url];
                    [array addObject:url1];
                }
                [_delegate sendArray_addImageUrls:array];
            }
        }else if (_viewType == Demo3ViewPartTimeResumeAdd) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(sendArray_addImageUrls:)]) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSString *url  in self.addImage_paths) {
                    NSString *url1 = [NSString stringWithFormat:@"https://jmsp-images-1257721067.picgz.myqcloud.com%@",url];
                    [array addObject:url1];
                }
                
             [_delegate sendArray_addImageUrls:array];
            }
            
        }
        
    }
    
}


//公司上传图片
-(void)uploadCompanyWithImages:(NSArray *)images{
    
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    [[JMHTTPManager sharedInstance]updateCompanyInfo_Id:userModel.company_id company_name:nil nickname:nil abbreviation:nil logo_path:nil video_path:nil  video_cover:nil work_time:nil work_week:nil type_label_id:nil industry_label_id:nil financing:nil employee:nil address:nil url:nil longitude:nil latitude:nil description:nil image_path:images label_id:nil subway:nil corporate:nil reg_capital:nil reg_date:nil reg_address:nil unified_credit_code:nil business_scope:nil license_path:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片上传成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}


//获取网络链接
-(void)sendRequst_img:(UIImage *)img{
    NSArray *array = @[img];
    [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSLog(@"img------%@",responsObject[@"data"]);
             NSString *url = responsObject[@"data"][0];
            [self.addImage_paths addObject:url];

            //            if (_delegate && [_delegate respondsToSelector:@selector(sendArray_addImageUrls:)]) {
            //                [_delegate sendArray_addImageUrls:array];
            //            }
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

}


-(void)sendRequstTest_img:(UIImage *)img{
    NSArray *array = @[img];
    if (array.count > 0) {
        [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            if (responsObject[@"data"]) {
                NSLog(@"Test666%@",responsObject[@"data"]);
                NSString *url = responsObject[@"data"][0];
                [self.addImage_paths addObject:url];
                
                //            if (_delegate && [_delegate respondsToSelector:@selector(sendArray_addImageUrls:)]) {
                //                [_delegate sendArray_addImageUrls:array];
                //            }
//                if () {
//                    <#statements#>
//                }
            }
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }
    
}


//-(void)sendRequst2_imgArray:(NSArray *)imgArray{
//
//    [[JMHTTPManager sharedInstance]uploadsImageWithFiles:imgArray successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        if (responsObject[@"data"]) {
//            NSLog(@"2222222%@",responsObject[@"data"]);
//
//            //            if (_delegate && [_delegate respondsToSelector:@selector(sendArray_addImageUrls:)]) {
//            //                [_delegate sendArray_addImageUrls:array];
//            //            }
//        }
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//}
//
//-(void)sendRequst3_imgArray:(NSArray *)imgArray{
//
//    [[JMHTTPManager sharedInstance]uploadsWithFiles:imgArray successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        if (responsObject[@"data"]) {
//            NSLog(@"----33333--%@",responsObject[@"data"]);
////            NSString *url = responsObject[@"data"][0];
////            [self.addImage_paths addObject:url];
//
//            //            if (_delegate && [_delegate respondsToSelector:@selector(sendArray_addImageUrls:)]) {
//            //                [_delegate sendArray_addImageUrls:array];
//            //            }
//        }
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//}

-(void)fanhui{
    [super fanhui];
    
}

- (void)lookClick { 
//    [[YYWebImageManager sharedManager].cache.diskCache removeAllObjects];
//    [[YYWebImageManager sharedManager].cache.memoryCache removeAllObjects];

//    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
//
//    }];
//    [[SDImageCache sharedImageCache] clearMemory];
//#if SDWebImageEmbed
//#endif
    return;
}
//- (void)addNetworkPhoto {
//    if (self.manager.afterSelectPhotoCountIsMaximum) {
////        [self.view hx_showImageHUDText:@"图片已达到最大数"];
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
//    [self.manager addNetworkingImageToAlbum:@[url] selected:YES];
//    [self.photoView refreshView];
//}



- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
//    self.addImgPathArray = [NSMutableArray array];
    [self.toolManager writeSelectModelListToTempPathWithList:allList requestType:0 success:^(NSArray<NSURL *> *allURL, NSArray<NSURL *> *photoURL, NSArray<NSURL *> *videoURL) {
//        NSSLog(@"allURLallURL%@",allURL);
//        for (NSURL *url in allURL) {
//            NSString *str1 = [url absoluteString];
//            if (![str1 hasPrefix:@"http"]) {
//
//                NSLog(@"string 包含 http");
//                [self.addImgPathArray addObject:str1];
//
//            }
//        }
//        NSSLog(@"addUrlStrImg%@",self.addImgPathArray);
//        NSSLog(@"photoURL%@",photoURL);
    } failed:^{

    }];
    
    
//    [self.view showLoadingHUDText:nil];
    __weak typeof(self) weakSelf = self;
    [self.toolManager getSelectedImageList:allList success:^(NSArray<UIImage *> *imageList) {
//        [weakSelf.view handleLoading];
        NSSLog(@"imageListimageList%@",imageList);
        if (_viewType == Demo3ViewPartTimeResumeAdd || _viewType == Demo3ViewPostGoodsPositionAdd || _viewType == Demo3ViewPostPartTimeJobAdd) {
//        if (_isChange) {
        
//
//        NSArray * arr2 = _imageList;
//        NSArray * arr1 = imageList.mutableCopy;
//        //找到在arr2中不在数组arr1中的数据
//        NSPredicate * filterPredicate1 = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr1];
//        NSArray * filter1 = [arr2 filteredArrayUsingPredicate:filterPredicate1];
//        //找到在arr1中不在数组arr2中的数据
//        NSPredicate * filterPredicate2 = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr2];
//        NSArray * filter2 = [arr1 filteredArrayUsingPredicate:filterPredicate2];
//        //拼接数组
//        NSMutableArray *array = [NSMutableArray arrayWithArray:filter1];
//        [array addObjectsFromArray:filter2];
//        NSLog(@"增加了%@",array);
            _imageList = imageList.mutableCopy;
            [self.addImage_paths removeAllObjects];
            for (UIImage *img in _imageList) {
                [self sendRequstTest_img:img];
            }
            
//        }
        }
//        [self sendRequst2_imgArray:imageList];
//        [self sendRequst3_imgArray:imageList];
    } failed:^{
//        [weakSelf.view handleLoading];
    }];
    
    
}

- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame
{
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
}

#pragma mark -删除图片
-(void)deleteImage:(NSNotification *)notification{
    NSIndexPath *indexPath = notification.object;
    [self deleteSend_index:indexPath.item];
}

- (void)deleteSend_index:(NSInteger)index{
    NSSLog(@"删除图片下标%ld",(long)index);
    if (_viewType == Demo3ViewPartTimeResumeEdit) {
        //            [self deletePartTimeJobImgRequestWithFile_id:fileModel.file_id];
        //image_paths服务器获取的图片
        if (index > self.image_paths.count - 1) {
            NSLog(@"addImage_paths:%@",self.addImage_paths);
            NSInteger addImageIndex = index - self.image_paths.count;
            [self.addImage_paths removeObjectAtIndex:addImageIndex];
        }else{
            if (self.image_paths.count > 0) {
                if (_delegate && [_delegate respondsToSelector:@selector(deletePartTimeJobResumeImageWithIndex:)]) {
                    //            JMFilesModel *fileModel = self.filesModelArray[index];
                    [_delegate deletePartTimeJobResumeImageWithIndex:index];
                }
                
                [self.image_paths removeObjectAtIndex:index];
                
            }else{
                [self.addImage_paths removeObjectAtIndex:index];

            }
            
        }
    }else if (_viewType == Demo3ViewCompanyInfoEdit) {
        if (index > self.image_paths.count - 1) {
            NSLog(@"addImage_paths:%@",self.addImage_paths);
            NSInteger addImageIndex = index - self.image_paths.count;
            [self.addImage_paths removeObjectAtIndex:addImageIndex];
        }else{
            if (self.image_paths.count > 0) {
                if (_delegate && [_delegate respondsToSelector:@selector(deleteCompanyImageWithIndex:)]) {
                    //            JMFilesModel *fileModel = self.filesModelArray[index];
                    [_delegate deleteCompanyImageWithIndex:index];
                }
                
                [self.image_paths removeObjectAtIndex:index];
                
            }else{
                [self.addImage_paths removeObjectAtIndex:index];
                
            }
//            if (_delegate && [_delegate respondsToSelector:@selector(deleteCompanyImageWithIndex:)]) {
//                //            JMFilesModel *fileModel = self.filesModelArray[index];
//                [_delegate deleteCompanyImageWithIndex:index];
//            }
//            [self.image_paths removeObjectAtIndex:index];
//
        }
        
        
    }else if (_viewType == Demo3ViewPostGoodsPositionEdit || _viewType == Demo3ViewPostPartTimeJobEdit ) {
        if (index > self.image_paths.count - 1) {
            NSLog(@"addImage_paths:%@",self.addImage_paths);
            NSInteger addImageIndex = index - self.image_paths.count;
            [self.addImage_paths removeObjectAtIndex:addImageIndex];
        }else{
            if (self.image_paths.count > 0) {
                if (_delegate && [_delegate respondsToSelector:@selector(deleteSalePositionImageWithIndex:)]) {
                    //            JMFilesModel *fileModel = self.filesModelArray[index];
                    [_delegate deleteSalePositionImageWithIndex:index];
                }
                
                [self.image_paths removeObjectAtIndex:index];
                
            }else{
                [self.addImage_paths removeObjectAtIndex:index];
                
            }
            //            if (_delegate && [_delegate respondsToSelector:@selector(deleteCompanyImageWithIndex:)]) {
            //                //            JMFilesModel *fileModel = self.filesModelArray[index];
            //                [_delegate deleteCompanyImageWithIndex:index];
            //            }
            //            [self.image_paths removeObjectAtIndex:index];
            //
        }
        
//        [self.image_paths removeObjectAtIndex:index];
        
    }else if (_viewType == Demo3ViewPostGoodsPositionAdd || _viewType == Demo3ViewPostPartTimeJobAdd) {
        [self.image_paths removeObjectAtIndex:index];
        
    }else if (_viewType == Demo3ViewPartTimeResumeAdd) {
        [self.image_paths removeObjectAtIndex:index];
        
    }else if (_viewType == Demo3ViewPartTimeResumeAdd) {
        [self.image_paths removeObjectAtIndex:index];
        
    }
    
    
//    if (index < self.filesModelArray.count) {
//
//      if (_viewType == Demo3ViewCompanyInfoEdit){
//            JMFilesModel *fileModel = self.filesModelArray[index];
//            [self deleteCompanyImageWithIndex:fileModel.file_id];
//
//        }
//
//
////        [self.filesModelArray removeObject:fileModel];
//        [self.filesModelArray removeObjectAtIndex:index];
//    }
    
}
//-(void)deleteCompanyImgRequestWithFile_id:(NSString *)file_id{
//    [[JMHTTPManager sharedInstance]deleteCompanyFile_Id:file_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//        //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片删除成功"
//        //                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//        //            [alert show];
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//
//}


//-(void)deletePartTimeJobImgRequestWithFile_id:(NSString *)file_id{
//    [[JMHTTPManager sharedInstance]deleteAbilityImage_Id:file_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片删除成功"
//                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//        [alert show];
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//}


@end
