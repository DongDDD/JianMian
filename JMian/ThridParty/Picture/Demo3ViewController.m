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
#import "JMPartTimeJobModel.h"
static const CGFloat kPhotoViewMargin = 12.0;

@interface Demo3ViewController ()<HXPhotoViewDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (weak, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
@property (strong, nonatomic) NSArray *lastArry;
@property (strong, nonatomic)NSMutableArray *addImgPathArray;
@property (strong, nonatomic)NSMutableArray *addImgArray;//UIImage类型

@property (strong, nonatomic)JMCompanyInfoModel *companyInfoModel;
@property (strong, nonatomic)JMPartTimeJobModel *partTimeJobModel;


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

- (NSMutableArray *)addImgArray {
    if (!_addImgArray) {
        _addImgArray = [NSMutableArray array];
    }
    return _addImgArray;
}

//获取最新图片数据
-(void)getData{
     JMUserInfoModel *_userInfoModel = [JMUserInfoManager getUserInfo];
    [[JMHTTPManager sharedInstance]fetchCompanyInfo_Id:_userInfoModel.company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.companyInfoModel = [JMCompanyInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            if (self.companyInfoModel.files.count > 0) {
                for (JMFilesModel *filesModel in self.companyInfoModel.files) {
                    if ([filesModel.files_type isEqualToString:@"2"]) {//过滤视频走 只要图片
                        [self.filesModelArray addObject:filesModel];
                    }
                }
            }
            
        }
        
        if (self.filesModelArray.count > 0) {
            self.image_paths = [NSMutableArray array];
            for (JMFilesModel *filesModel in self.filesModelArray) {
                [self.image_paths addObject:filesModel.files_file_path];
            }
        }
        
        
        [self initView];
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
    // 可以在懒加载中赋值 ,  也可以这样赋值
    //    self.manager.networkPhotoUrls = ;
    
    //    photoView.manager = self.manager;
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"添加网络" style:UIBarButtonItemStylePlain target:self action:@selector(addNetworkPhoto)];
    
//    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"清空缓存" style:UIBarButtonItemStylePlain target:self action:@selector(lookClick)];
    
//    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公司图片";
    [self setRightBtnTextName:@"保存"];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    if (self.filesModelArray.count > 0) {
        self.image_paths = [NSMutableArray array];
        for (JMFilesModel *filesModel in self.filesModelArray) {
            [self.image_paths addObject:filesModel.files_file_path];
        }
    }
//    [self initView];
    if (_viewType == Demo3ViewPartTime) {
         [self initView];
    }else{
        
        [self getData];//获取服务器最新图片数组
    }
   
    
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"http://oss-cn-hangzhou.aliyuncs.com/tsnrhapp/shop/photos/857980fd0acd3caf9e258e42788e38f5_0.gif",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0034821a-6815-4d64-b0f2-09103d62630d.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0be5118d-f550-403e-8e5c-6d0badb53648.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/1466408576222.jpg", nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAddImg:) name:@"Notification_addImg" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAddImgArray:) name:@"Notification_addImgArray" object:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
#pragma mark -增加了的图片

-(void)getAddImg:(NSNotification *)notification{
    UIImage * img = notification.object;
    NSLog(@"imgimg%@",img);
    [self.addImgArray addObject:img];

}

//-(void)getAddImgArray:(NSNotification *)notification{
//    if (notification.object) {
//        self.addImgArray = notification.object;
//    }
//
//
//}

#pragma mark -上传图片并返回
-(void)rightAction{
    [self.navigationController popViewControllerAnimated:YES];
    [self lookClick];
    if (self.addImgArray.count>0) {
  
        [self sendRequst];
      
    }
    
}
//兼职上传图片
-(void)uploadPartTimePicWithImages:(NSArray *)images{
    [[JMHTTPManager sharedInstance]updateAbility_Id:self.ability_id city_id:nil type_label_id:nil industry_arr:nil myDescription:nil video_path:nil video_cover:nil image_arr:images status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片上传成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}
//公司上传图片
-(void)uploadCompanyWithImages:(NSArray *)images{
    
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    [[JMHTTPManager sharedInstance]updateCompanyInfo_Id:userModel.company_id company_name:nil nickname:nil abbreviation:nil logo_path:nil video_path:nil work_time:nil work_week:nil type_label_id:nil industry_label_id:nil financing:nil employee:nil address:nil url:nil longitude:nil latitude:nil description:nil image_path:images label_id:nil subway:nil corporate:nil reg_capital:nil reg_date:nil reg_address:nil unified_credit_code:nil business_scope:nil license_path:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片上传成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}


//获取网络链接
-(void)sendRequst{
    
    [[JMHTTPManager sharedInstance]uploadsWithFiles:self.addImgArray successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSLog(@"------%@",responsObject[@"data"]);
            NSArray *array = responsObject[@"data"];
            //            上传partTimeJob图片
            if (_viewType == Demo3ViewPartTime) {
                [self uploadPartTimePicWithImages:array];
            }else{
                //公司上传图片
                [self uploadCompanyWithImages:array];
            }
            //            if (_delegate && [_delegate respondsToSelector:@selector(sendArray_addImageUrls:)]) {
            //                [_delegate sendArray_addImageUrls:array];
            //            }
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)fanhui{
    [super fanhui];
    
}

- (void)lookClick { 
//    [[YYWebImageManager sharedManager].cache.diskCache removeAllObjects];
//    [[YYWebImageManager sharedManager].cache.memoryCache removeAllObjects];

    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{

    }];
    [[SDImageCache sharedImageCache] clearMemory];
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
    self.addImgPathArray = [NSMutableArray array];
    [self.toolManager writeSelectModelListToTempPathWithList:allList requestType:0 success:^(NSArray<NSURL *> *allURL, NSArray<NSURL *> *photoURL, NSArray<NSURL *> *videoURL) {
        NSSLog(@"allURLallURL%@",allURL);
        for (NSURL *url in allURL) {
            NSString *str1 = [url absoluteString];
            if (![str1 hasPrefix:@"http"]) {
                
                NSLog(@"string 包含 http");
                [self.addImgPathArray addObject:str1];
                
            }
        }
        NSSLog(@"addUrlStrImg%@",self.addImgPathArray);
        NSSLog(@"photoURL%@",photoURL);
    } failed:^{

    }];
    
    
    [self.view showLoadingHUDText:nil];
    __weak typeof(self) weakSelf = self;
    [self.toolManager getSelectedImageList:allList success:^(NSArray<UIImage *> *imageList) {
        [weakSelf.view handleLoading];
        NSSLog(@"imageListimageList%@",imageList);
    } failed:^{
        [weakSelf.view handleLoading];
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

- (void)deleteSend_index:(NSInteger)index{
    NSSLog(@"删除图片下标%ld",(long)index);
    if (index < self.filesModelArray.count) {
        JMFilesModel *fileModel = self.filesModelArray[index];
        [[JMHTTPManager sharedInstance]deleteCompanyFile_Id:fileModel.file_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片删除成功"
//                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//            [alert show];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
        [self.filesModelArray removeObjectAtIndex:index];
        
    }else{
        
        NSInteger addImgArrayIndex = (index + 1) - self.filesModelArray.count;
        [self.addImgArray removeObjectAtIndex:addImgArrayIndex];
        
    }
    
}






@end
