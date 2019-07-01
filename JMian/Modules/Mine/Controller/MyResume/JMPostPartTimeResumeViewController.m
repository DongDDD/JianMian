//
//  JMPostPartTimeResumeViewController.m
//  JMian
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostPartTimeResumeViewController.h"
#import "DimensMacros.h"
#import "JMPartTimeJobResumeFooterView.h"
#import "JMIndustryWebViewController.h"
#import "JMCityListViewController.h"
#import "PositionDesiredViewController.h"
#import "Demo3ViewController.h"//上传图片
#import "JMHTTPManager+CreateAbility.h"
#import "JMUploadVideoViewController.h"//上传视频
#import "JMHTTPManager+FectchAbilityInfo.h"//获取兼职简历
#import "JMHTTPManager+UpdateAbility.h"//G更新兼职简历
#import "IQKeyboardManager.h"
#import "JMPartTimeJobTypeLabsViewController.h"
#import "JMHTTPManager+DeleteAbilityImage.h"
#import "JMHTTPManager+DeletePartTimeJobVita.h"
#import "JMChoosePartTImeJobTypeLablesViewController.h"



@interface JMPostPartTimeResumeViewController ()<UITableViewDelegate,UITableViewDataSource,JMIndustryWebViewControllerDelegate,JMCityListViewControllerDelegate,PositionDesiredDelegate,Demo3ViewControllerDelegate,JMPartTimeJobResumeFooterViewDelegate,JMUploadVideoViewDelegate,JMPartTimeJobTypeLabsViewControllerDelegate,JMUploadVideoViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *leftArray;
@property (nonatomic,strong)NSMutableArray *rightArray;
@property (nonatomic,strong)NSString *labsJson;
@property (nonatomic,strong)JMPartTimeJobResumeFooterView *footerView;
@property (nonatomic, assign)CGFloat changeHeight;
@property (nonatomic,assign)CGRect Frame;
@property (nonatomic,strong)JMAbilityCellData *myPartTimeVitaModel;
@property (nonatomic,strong)NSMutableArray *imageDataArr;
@property (nonatomic, assign)BOOL isUpLoadVideo;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

//提交请求参数
@property (nonatomic,strong)NSString *city_id;
@property (nonatomic,strong)NSString *type_label_id;
@property (nonatomic,strong)NSMutableArray *industry_arr;
@property (nonatomic,strong)NSString *myDescription;
@property (nonatomic,strong)NSString *video_path;
@property (nonatomic,strong)NSString *video_cover;
@property (nonatomic,strong)NSArray *image_arr;
//@property (nonatomic,strong)NSString *status;

@end

static NSString *cellIdent = @"cellIdent";
@implementation JMPostPartTimeResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BG_COLOR;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.footerView];
    
    if (_viewType == JMPostPartTimeResumeVieweEdit) {
        [self setRightBtnTextName:@"保存"];
        self.title = @"编辑兼职简历";
        [self.bottomView setHidden:NO];
        [self.view addSubview:self.bottomView];
    }else if (_viewType == JMPostPartTimeResumeViewAdd) {
        self.title = @"发布兼职简历";
        [self setRightBtnTextName:@"发布"];
    }
    

//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideTap)];
//    [self.tableView addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view from its nib.
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //    第二版：C端 获取个人兼职简历
    if (_viewType == JMPostPartTimeResumeVieweEdit) {
        
        [self getPartTimeInfoData];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = aNotification.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];

    CGRect keyboardRect = aValue.CGRectValue;
    CGRect frame = self.footerView.frame;
    self.changeHeight = keyboardRect.size.height - (frame.origin.y+frame.size.height);
    CGRect rect= CGRectMake(0,_changeHeight+100,SCREEN_WIDTH,SCREEN_HEIGHT);
    if (_changeHeight < 0) {
        
        [UIView animateWithDuration:0.3 animations:^ {
            self.view.frame = rect;
            
        }];
    }

}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    [UIView animateWithDuration:0.3 animations:^ {
        self.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);

    }];


}

#pragma mark - 赋值

-(void)setRightText_model:(JMAbilityCellData *)model{
        NSString *city = model.city_cityName;
        NSString *type_name = model.type_name;
        NSMutableArray *industryNameArray = [NSMutableArray array];
        for (JMIndustryModel *data in model.industry) {
            [industryNameArray addObject:data.name];
        }
        NSString *insdutry = [industryNameArray componentsJoinedByString:@","];
        NSString *videoStr;
        NSString *imgsStr;
        if (model.images.count > 0) {
            imgsStr = @"已上传";
        }else{
            imgsStr = @"上传图片作品";
            
        }
        if (model.video_file_path) {
            videoStr = @"已上传";
        }else{
            videoStr = @"上传视频作品";
            
        }
        self.rightArray = [NSMutableArray arrayWithObjects:city,type_name,insdutry,imgsStr,videoStr, nil];
    
    [self.footerView.contentTextView setText:model.myDescription];
    [self.footerView.placeHolder setHidden:YES];
    
   
}

#pragma mark - 点击事件

-(void)hideTap{
    [self.footerView.contentTextView resignFirstResponder];
}


-(void)rightAction{
    [self.footerView.contentTextView resignFirstResponder];

    if (_viewType == JMPostPartTimeResumeVieweEdit) {
        [self updatePartTimeResume];
    }else{
        [self createPartTimeResume];
    }
    
}

- (IBAction)deleteAction:(UIButton *)sender {
    [self showAlertWithTitle:@"提醒⚠️" message:@"删除后数据将不可恢复" leftTitle:@"返回" rightTitle:@"确认删除"];
}

-(void)alertRightAction{
    [[JMHTTPManager sharedInstance]deleteAbilityVita_Id:self.ability_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.navigationController popViewControllerAnimated:YES];
        [self showAlertSimpleTips:@"提示" message:@"已删除" btnTitle:@"好的"];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

- (IBAction)saveAction:(UIButton *)sender {
    [self rightAction];
}

#pragma mark - 数据请求
//获取兼职简历
-(void)getPartTimeInfoData{
    [[JMHTTPManager sharedInstance]fectchAbilityDetailInfo_Id:self.ability_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.myPartTimeVitaModel = [JMAbilityCellData mj_objectWithKeyValues:responsObject[@"data"]];
            //            if (self.partTimeVitaModel.video_file_path!=nil) {
            //
            //                NSURL *url = [NSURL URLWithString:self.partTimeVitaModel.video_file_path];
            //
            //
            //
            //            }
            self.imageDataArr = self.myPartTimeVitaModel.images.mutableCopy;
            [self setRightText_model:self.myPartTimeVitaModel];
            [self.tableView reloadData];
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
-(void)updatePartTimeResume{
    [[JMHTTPManager sharedInstance]updateAbility_Id:self.ability_id city_id:_city_id type_label_id:_type_label_id industry_arr:_industry_arr myDescription:_myDescription video_path:_video_path video_cover:_video_cover image_arr:nil status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
//        [self.progressHUD setHidden:YES];
        
        //        if (_delegate && [_delegate respondsToSelector:@selector(isUploadVideo:)]) {
        //            [_delegate isUploadVideo:YES];
        //        }
        //
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];


}

-(void)createPartTimeResume{
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSString *url in _image_arr) {
        
        NSString *strUrl = [url stringByReplacingOccurrencesOfString:@"https://jmsp-images-1257721067.picgz.myqcloud.com" withString:@""];
        [imageArr addObject:strUrl];
    }
    
     NSString *videoUrl = [_video_path stringByReplacingOccurrencesOfString:@"https://jmsp-videos-1257721067.cos.ap-guangzhou.myqcloud.com" withString:@""];
    [[JMHTTPManager sharedInstance]createAbility_city_id:_city_id type_label_id:_type_label_id industry_arr:_industry_arr myDescription:_myDescription video_path:videoUrl video_cover:_video_cover image_arr:imageArr status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"创建成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

//兼职上传图片
-(void)uploadPartTimeJobImgRequestWithImages:(NSArray *)images{
    [[JMHTTPManager sharedInstance]updateAbility_Id:self.ability_id city_id:nil type_label_id:nil industry_arr:nil myDescription:nil video_path:nil video_cover:nil image_arr:images status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片上传成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

-(void)deletePartTimeJobImgRequestWithFile_id:(NSString *)file_id{
    [[JMHTTPManager sharedInstance]deleteAbilityImage_Id:file_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"图片删除成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

#pragma mark - delegate

- (void)didSelectedCity_id:(nonnull NSString *)city_id city_name:(nonnull NSString *)city_name {
    [self.rightArray replaceObjectAtIndex:0 withObject:city_name];
    [self.tableView reloadData];
    _city_id = city_id;
    NSLog(@"%@%@",city_id,city_name);
}

//职位类型
-(void)didChooseWithType_id:(NSString *)type_id typeName:(NSString *)typeName{
    _type_label_id = type_id;
    [self.rightArray replaceObjectAtIndex:1 withObject:typeName];
    [self.tableView reloadData];
    
    NSLog(@"%@%@",typeName,type_id);
    
}
//- (void)sendPositoinData:(NSString * _Nullable)labStr labIDStr:(NSString * _Nullable)labIDStr {
//    [self.rightArray replaceObjectAtIndex:1 withObject:labStr];
//    [self.tableView reloadData];
//    _type_label_id = labIDStr;
//    NSLog(@"%@%@",labStr,labIDStr);
//
//}

//H5交互数据
-(void)sendlabsWithJson:(NSString *)json{
    self.labsJson = json;
    //NSString -> NSData
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arrayData = [self toArrayOrNSDictionary:data];
    NSLog(@"arrayData%@",arrayData);
    NSMutableArray *arrayName = [NSMutableArray array];//用于展示给用户
    _industry_arr = [NSMutableArray array];//用于提交服务器
    
    for (NSDictionary *dic in arrayData) {
        [arrayName addObject:dic[@"name"]];
        [_industry_arr addObject:dic[@"label_id"]];
        
    }
    NSLog(@"_industry_arr%@",_industry_arr);
    
    NSLog(@"arrayName%@",arrayName);
    NSString *rightStr = [arrayName componentsJoinedByString:@","];
    [self.rightArray replaceObjectAtIndex:2 withObject:rightStr];
    [self.tableView reloadData];
}

- (void)sendArray_addImageUrls:(NSArray *)addImageUrls {
    _image_arr = addImageUrls;
    NSLog(@"addImageUrls%@",addImageUrls);
    if (addImageUrls) {
        [self.rightArray replaceObjectAtIndex:3 withObject:@"已上传"];
        [self.tableView reloadData];
        
    }

 
}

-(void)sendAddImgs:(NSMutableArray *)Imgs{
    [self uploadPartTimeJobImgRequestWithImages:Imgs.mutableCopy];
}

//已上传视频
//-(void)isUploadVideo:(BOOL)isUploadVideo{
//    _isUpLoadVideo = isUploadVideo;
//    if (isUploadVideo) {
//        [self.rightArray replaceObjectAtIndex:4 withObject:@"已上传"];
//        [self.tableView reloadData];
//    }
//
//}

-(void)didPostVideoWithUrl:(NSString *)url video_cover:(nonnull NSString *)video_cover{
    if (url != nil) {
        _isUpLoadVideo = YES;
        _video_path = url;//请求参数和用于传值
        _video_cover = video_cover;
        [self.rightArray replaceObjectAtIndex:4 withObject:@"已上传"];
        [self.tableView reloadData];
    }
}

//删除兼职图片
-(void)deletePartTimeJobResumeImageWithIndex:(NSInteger)index{
    if (self.imageDataArr.count > 0) {
        JMImageModel *model = self.imageDataArr[index];
        if (index < self.myPartTimeVitaModel.images.count) {
            [self deletePartTimeJobImgRequestWithFile_id:model.file_id];
            [self.imageDataArr removeObject:model];
            //        [self.image_arr.mutableCopy removeObjectAtIndex:index];
        }
        
    }

}



#pragma mark - UITextViewDelegate
-(void)sendContent:(NSString *)content{
    _myDescription = content;
    NSLog(@"_myDescription%@",_myDescription);

}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.leftArray[indexPath.row];
    cell.textLabel.font = kFont(14);
    cell.textLabel.textColor = TEXT_GRAY_COLOR;
    cell.detailTextLabel.text = self.rightArray[indexPath.row];
    cell.detailTextLabel.font = kFont(17);
    cell.detailTextLabel.textColor = TITLE_COLOR;
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.footerView.contentTextView resignFirstResponder];

    if (indexPath.row == 0) {
        JMCityListViewController *vc =  [[JMCityListViewController alloc]init];
        vc.delegate = self;
        vc.viewType = JMCityListViewPartTime;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1) {
        JMChoosePartTImeJobTypeLablesViewController *vc =  [[JMChoosePartTImeJobTypeLablesViewController alloc]init];
        vc.delegate = self;
        vc.myVC = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2) {
        JMIndustryWebViewController *vc =  [[JMIndustryWebViewController alloc]init];
        vc.delegate = self;
        vc.labsJson = self.labsJson;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 3) {
        Demo3ViewController *vc = [[Demo3ViewController alloc]init];
        vc.delegate = self;
        if (_viewType == JMPostPartTimeResumeVieweEdit) {//编辑兼职简历
//            vc.filesModelArray = self.myPartTimeVitaModel.images.mutableCopy;
//            if (_image_arr.count == 0) {
//                //还没进去编辑图片 _image_arr为空
//                vc.image_paths = [self getImagList_imgArray:self.myPartTimeVitaModel.images];
//
//            }else{
//                //进去编辑了图片 _image_arr不为空了
//                vc.image_paths = _image_arr.mutableCopy;
//            }
            vc.ability_id = self.ability_id;
            vc.viewType = Demo3ViewPartTimeResumeEdit;
        }else if (_viewType == JMPostPartTimeResumeViewAdd){//添加兼职简历
            vc.viewType = Demo3ViewPartTimeResumeAdd;
            //选好的图片_image_arr
            vc.image_paths = _image_arr.mutableCopy;
       
        }
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 4) {
        JMUploadVideoViewController *vc = [[JMUploadVideoViewController alloc]init];
        vc.delegate = self;
        if (_viewType == JMPostPartTimeResumeViewAdd) {
            vc.viewType = JMUploadVideoViewTypePartTimeAdd;
            if (_video_path) {
                vc.videoUrl = _video_path;
            }
        }else if (_viewType == JMPostPartTimeResumeVieweEdit) {
            vc.ability_id = self.ability_id;
            vc.viewType = JMUploadVideoViewTypePartTimeEdit;
        }
        [self.navigationController pushViewController:vc animated:YES];
        
    }

}

//从数据提取图片链接
-(NSMutableArray *)getImagList_imgArray:(NSArray *)imgArray{
    NSMutableArray *array = [NSMutableArray array];
    for (JMImageModel *model in imgArray) {
        [array addObject:model.file_path];
    }
    return array;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.footerView.contentTextView resignFirstResponder];

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 229;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    return self.footerView;
//}



#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height+100) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
       
    }
    return _tableView;
}

- (NSMutableArray *)leftArray{
    if (_leftArray == nil) {
        _leftArray = [NSMutableArray arrayWithObjects:@"城市地域",@"职位类型",@"理想行业",@"图片作品(选填)",@"视频简历(选填)", nil];
    }
    return _leftArray;
}

- (NSMutableArray *)rightArray{
    if (_rightArray == nil) {
        _rightArray = [NSMutableArray arrayWithObjects:@"选择城市",@"选择职位类型",@"选择行业",@"上传图片作品",@"上传视频简历", nil];
        
    }
    return _rightArray;
}

- (JMPartTimeJobResumeFooterView *)footerView{
    if (_footerView == nil) {
        _footerView = [JMPartTimeJobResumeFooterView new];
        _footerView.frame = CGRectMake(0, 350 , SCREEN_WIDTH, 229);
        _footerView.viewType = JMPartTimeJobResumeFooterViewTypeDefault;
        _footerView.delegate = self;
//        _footerView.contentTextView.delegate = self;
        
    }
    return _footerView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
