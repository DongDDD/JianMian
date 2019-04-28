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

@interface JMMyPictureViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) NSMutableArray *picArr,*imageArray;
@property (nonatomic, strong) NSData *imageData;


@end

@implementation JMMyPictureViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[JMHTTPManager sharedInstance] updateVitaWith_work_status:nil education:nil work_start_date:nil description:nil video_path:nil image_paths:self.imageArray successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"图片作品";
    [self setRightBtnTextName:@"删除"];
    [self setupView];
}

- (void)setupView {
    
    CGFloat padding = 15;
    CGFloat width = (SCREEN_WIDTH-60-3*padding)/3;
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.mas_topLayoutGuide).offset(15);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    
    if (self.image_paths.count > 0) {

        for (JMMyFilesModel *model in self.image_paths) {

            if (!self.picArr) self.picArr = [NSMutableArray array];

            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.file_path]];
            [self.addBtn.superview addSubview:imageView];
            [self.picArr addObject:imageView];
//            NSInteger ids = [self.picArr indexOfObject:imageView];
//            [self.imageArray setObject:[model.file_path atIndexedSubscript:ids];

            CGFloat padding = 15;
            CGFloat width = (SCREEN_WIDTH-60-3*padding)/3;
            CGFloat top =  width*((self.picArr.count)/3 )+padding*((self.picArr.count)/3+1);

            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(20+((width+padding)*((self.picArr.count)%3)));
                make.top.equalTo(self.mas_topLayoutGuide).offset(top);
                make.size.mas_equalTo(CGSizeMake(width, width));
            }];
            [imageView.superview layoutIfNeeded];


        }
    }
}

- (void)rightAction {
    
}

- (void)addPic {
    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
    vc.delegate = self;
//    vc.sourceType = UIImagePickerControllerSourceTypeCamera;
    vc.allowsEditing = YES;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
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
    CGFloat width = (SCREEN_WIDTH-60-3*padding)/3;
    CGFloat top =  width*((self.picArr.count)/3 )+padding*((self.picArr.count)/3+1);
    //    CGFloat Btntop = self.picArr.count / 3 * width + 10;
    CGFloat Btntop = width*((self.picArr.count)/3 )+padding*((self.picArr.count)/3+1);
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20+((width+padding)*((self.picArr.count)%3)));
        make.top.equalTo(self.mas_topLayoutGuide).offset(top);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    [imageView.superview layoutIfNeeded];
    
    [[JMHTTPManager sharedInstance] uploadsImageWithFiles:@[image] successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        NSString *filePath = responsObject[@"data"][0];
        if (filePath) {
//            [self.imageArray setObject:filePath atIndexedSubscript:ids];
            [self.imageArray addObject:filePath];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = ({
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [addBtn setImage:[UIImage imageNamed:@"tjzp"] forState:UIControlStateNormal];
            [addBtn setTitle:@"+" forState:UIControlStateNormal];
            [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            addBtn.layer.borderWidth = 1;
            addBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
            [addBtn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];
            addBtn;
        });
    }
    return _addBtn;
}
@end
