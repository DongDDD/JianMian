//
//  JMMyPictureViewController.m
//  JMian
//
//  Created by chitat on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyPictureViewController.h"
#import "JMHTTPManager+Uploads.h"
#import "JMHTTPManager+Vita.h"
#import <UIImageView+WebCache.h>
#import "JMHTTPManager+CompanyInfoUpdate.h"
#import "JMHTTPManager+CompanyFileDelete.h"
@interface JMMyPictureViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *picArr;

//@property (nonatomic, strong) NSMutableArray *image_paths;//服务器获取的图片
@property (nonatomic, strong) NSMutableArray *addImageArray;//增加了的图片
@property (nonatomic, strong) NSMutableArray *deleteImageArray;
@property (nonatomic, strong) NSMutableArray *deleteFileModelArray;//删除了的图片下标

@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, assign)BOOL isDeleteStatus;
@property (nonatomic, assign)NSInteger picCount;
@property (nonatomic, strong)NSMutableArray *needShowPic;

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation JMMyPictureViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
//    [[JMHTTPManager sharedInstance] updateVitaWith_work_status:nil education:nil work_start_date:nil description:nil video_path:nil image_paths:self.imageArray successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公司图片";
    [self setRightBtnTextName:@"删除"];
//    self.needShowPic = [NSMutableArray array];
    
    if (self.filesModelArray.count > 0) {
        self.image_paths = [NSMutableArray array];
        for (JMFilesModel *filesModel in self.filesModelArray) {
            [self.image_paths addObject:filesModel.files_file_path];
        }
    }
    
    [self.needShowPic addObjectsFromArray:self.image_paths];
    [self setupView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    
    
}
//重写父类导航栏按钮
-(void)setRightBtnTextName:(NSString *)rightLabName{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(50, 0, 70, 30);
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:rightLabName forState:UIControlStateNormal];
    [rightBtn setTitle:@"确认删除" forState:UIControlStateSelected];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    
    [rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
#pragma mark -确认删除
-(void)rightAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    for (int i = 0 ; i < self.needShowPic.count; i++) {
        UIButton *selectBtn = [self.view viewWithTag:1000+i];
        if (sender.selected) {
            [selectBtn setHidden:NO];
            _isDeleteStatus = YES;
        }else{
            //点击确认删除按钮
            [selectBtn setHidden:YES];
            if (selectBtn.selected) {
                
                NSLog(@"打勾了的按钮tag%ld",(long)selectBtn.tag);
                NSInteger index = selectBtn.tag - 1000;
                if (self.filesModelArray.count > 0) {
                    [self.deleteFileModelArray addObject:self.filesModelArray[index]];
                    
                }
                //更新显示的图片，把要删除的去掉
                [self.needShowPic removeObjectAtIndex:index];
                
            }
            _isDeleteStatus = NO;
            
        }
        
        
    }
    
    
    if(!sender.selected){
//        [self refreshUI];
        //修改服务器的图片 选择了删除图片
        if (self.deleteFileModelArray) {
            for (int i = 0; i < self.deleteFileModelArray.count; i++) {
                JMFilesModel *model = self.deleteFileModelArray[i];
                [[JMHTTPManager sharedInstance]deleteCompanyFile_Id:model.file_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//                    if (i == self.deleteFileModelArray.count) {
//                        [self.progressHUD showAnimated:NO];
//                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除成功"
//                                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//                        [alert show];
//                    }
//                    if (i == self.deleteFileModelArray.count - 1) {
//                        [self.progressHUD showAnimated:NO];
//
//                    }

                  
                } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                    
                }];
            }
            
        }
        
    }

    
    
//    
//    [[JMHTTPManager sharedInstance]updateCompanyInfo_Id:nil company_name:nil nickname:nil abbreviation:nil logo_path:nil video_path:nil work_time:nil work_week:nil type_label_id:nil industry_label_id:nil financing:nil employee:nil address:nil url:nil longitude:nil latitude:nil description:nil image_path:nil label_id:nil subway:nil corporate:nil reg_capital:nil reg_date:nil reg_address:nil unified_credit_code:nil business_scope:nil license_path:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片删除成功"
//                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//        [alert show];
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//        
//    }];
    
    
    
//    if (sender.selected) {
//
//        _isDeleteStatus = YES;
//    }else{
//        _isDeleteStatus = NO;
//
//
//    }
 
}
//刷新页面

-(void)refreshUI{
    //清楚所有视图
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.needShowPic = [NSMutableArray array];
    //重新加载
    //服务器图片要显示出来
    if (self.filesModelArray.count > 0) {
        self.image_paths = [NSMutableArray array];
        for (JMFilesModel *filesModel in self.filesModelArray) {
            [self.image_paths addObject:filesModel.files_file_path];
        }
    }
    if (self.image_paths.count > 0) {
        [self.needShowPic addObjectsFromArray:self.image_paths];
    }
    //新添加的要显示出来
    [self.needShowPic addObjectsFromArray:self.addImageArray];
    
    [self setupView];
    
}
-(void)selectedAction:(UIButton *)sender{
    sender.selected = !sender.selected;
//    [self.image_paths removeObjectAtIndex:sender.tag-1000];
//    if (sender.selected) {
//        NSString *url = self.needShowPic[sender.tag - 1000];
//        [self.deleteImageArray addObject:url];
//        NSLog(@"选择删除的图片%@",self.deleteImageArray);
//    }else{
//        [self.deleteImageArray removeObjectAtIndex:sender.tag - 1000];
//        NSLog(@"选择删除的图片%@",self.deleteImageArray);
//
//    }
    

}

-(void)fanhui{
    [super fanhui];
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendArray_image_paths:)]) {
        [_delegate sendArray_image_paths:self.addImageArray];
    }
}


- (void)setupView {
    CGFloat padding = 15;
    CGFloat width = (SCREEN_WIDTH-20-3*padding)/3;
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.mas_topLayoutGuide).offset(15);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    if (self.needShowPic.count > 0) {
        for (int i = 0; i < self.needShowPic.count; i++) {
            
            //        for (NSString *url in self.image_paths) {
            NSString *url = self.needShowPic[i];
            if (!self.picArr) self.picArr = [NSMutableArray array];
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
            [self.addBtn.superview addSubview:imageView];
            [self.picArr addObject:imageView];
            //            NSInteger ids = [self.picArr indexOfObject:imageView];
            //            [self.imageArray setObject:[model.file_path atIndexedSubscript:ids];
            
            CGFloat padding = 15;
            
            CGFloat width = (SCREEN_WIDTH-20-3*padding)/3;
            CGFloat top =  width*((self.picArr.count)/3 )+padding*((self.picArr.count)/3+1);
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(20+((width+padding)*((self.picArr.count)%3)));
                make.top.equalTo(self.mas_topLayoutGuide).offset(top);
                make.size.mas_equalTo(CGSizeMake(width, width));
            }];
            [imageView.superview layoutIfNeeded];
            
            self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.selectedBtn.hidden = YES;
            self.selectedBtn.tag = 1000+i;
            [self.selectedBtn setImage:[UIImage imageNamed:@"Unselected_Vertices"] forState:UIControlStateNormal];
            [self.selectedBtn setImage:[UIImage imageNamed:@"pitch_on"] forState:UIControlStateSelected];
            [self.selectedBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
            //            selectedBtn.frame = CGRectMake(imageView.frame.origin.x+6, imageView.frame.origin.y+6, 20,20);
            [self.addBtn.superview addSubview:self.selectedBtn];
            [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(imageView).offset(-6);
                make.top.equalTo(imageView).offset(6);
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];
            
        }
    }
}


- (void)addPic {
    if (self.image_paths.count <= 10) {
        
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.delegate = self;
        //    vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        vc.allowsEditing = YES;
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"公司图片最多只能上传十张"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
    }
}

#pragma mark -UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (!self.picArr) {
        self.picArr = [NSMutableArray array];
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    //    @weakify(imageView);
    //    @weakify(self);
    //    imageView.closeBlock = ^(UIImage *image) {
    //        @strongify(imageView);
    //        @strongify(self);
    //        NSInteger index = [self.picArr indexOfObject:imageView];
    //        [imageView removeFromSuperview];
    //        [self.picArr removeObjectAtIndex:index];
    //        [self.viewModel.imageArray removeObjectAtIndex:index];
    //        [self reLayoutPics:index];
    //    };
    //
    [self.addBtn.superview addSubview:imageView];
    [self.picArr addObject:imageView];
    //    NSInteger ids = [self.picArr indexOfObject:imageView];
    //    [self.imageArray setObject:[NSNull null] atIndexedSubscript:ids];
    
    CGFloat padding = 15;
    CGFloat width = (SCREEN_WIDTH-20-3*padding)/3;
    CGFloat top =  width*((self.picArr.count)/3 )+padding*((self.picArr.count)/3+1);
    //    CGFloat Btntop = self.picArr.count / 3 * width + 10;
//    CGFloat Btntop = width*((self.picArr.count)/3 )+padding*((self.picArr.count)/3+1);
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20+((width+padding)*((self.picArr.count)%3)));
        make.top.equalTo(self.mas_topLayoutGuide).offset(top);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    [imageView.superview layoutIfNeeded];
    self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_isDeleteStatus){
        self.selectedBtn.hidden = NO;
    }else{
        self.selectedBtn.hidden = YES;

    }
    
    self.selectedBtn.tag = 1000 + self.needShowPic.count;
    [self.selectedBtn setImage:[UIImage imageNamed:@"Unselected_Vertices"] forState:UIControlStateNormal];
    [self.selectedBtn setImage:[UIImage imageNamed:@"pitch_on"] forState:UIControlStateSelected];
    [self.selectedBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn.superview addSubview:self.selectedBtn];
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageView).offset(-6);
        make.top.equalTo(imageView).offset(6);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
    [[JMHTTPManager sharedInstance] uploadsWithFiles:@[image] successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        NSString *filePath = responsObject[@"data"][0];
        if (filePath) {
//            [self.imageArray setObject:filePath atIndexedSubscript:ids];
            [self.addImageArray addObject:filePath];
            
            
            NSString *url = [NSString stringWithFormat:@"https://jmsp-images-1257721067.picgz.myqcloud.com%@",filePath];
//            self.needShowPic = [NSMutableArray array];
            [self.needShowPic addObjectsFromArray:self.image_paths];//服务器保存好的图片
            [self.needShowPic addObject:url];//在此界面添加的图片
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
//    [self setupView];

}

- (NSMutableArray *)image_paths {
    if (!_image_paths) {
        _image_paths = [NSMutableArray array];
    }
    return _image_paths;
}

- (NSMutableArray *)addImageArray {
    if (!_addImageArray) {
        _addImageArray = [NSMutableArray array];
    }
    return _addImageArray;
}

- (NSMutableArray *)needShowPic {
    if (!_needShowPic) {
        _needShowPic = [NSMutableArray array];
    }
    return _needShowPic;
}
- (NSMutableArray *)deleteImageArray {
    if (!_deleteImageArray) {
        _deleteImageArray = [NSMutableArray array];
    }
    return _deleteImageArray;
}
- (NSMutableArray *)deleteFileModelArray {
    if (!_deleteFileModelArray) {
        _deleteFileModelArray = [NSMutableArray array];
    }
    return _deleteFileModelArray;
}
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = ({
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [addBtn setImage:[UIImage imageNamed:@"accretion"] forState:UIControlStateNormal];
            addBtn.imageView.contentMode = UIViewContentModeScaleToFill;
            [addBtn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];
            addBtn;
        });
    }
    return _addBtn;
}

-(MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.progress = 0.6;
        _progressHUD.dimBackground = NO; //设置有遮罩
        [_progressHUD showAnimated:YES]; //显示进度框
    }
    return _progressHUD;
}
//- (UIButton *)selectedBtn {
//    if (!_selectedBtn) {
//        _selectedBtn = ({
//            UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [selectedBtn setImage:[UIImage imageNamed:@"Unselected_Vertices"] forState:UIControlStateNormal];
//            [selectedBtn setImage:[UIImage imageNamed:@"pitch_on"] forState:UIControlStateSelected];
//            [selectedBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
//            selectedBtn;
//        });
//    }
//    return _selectedBtn;
//}
@end
