//
//  JMBUserPostPartTimeJobViewController.m
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserPostPartTimeJobViewController.h"
#import "JMBUserPartTimeJobDetailView.h"
#import "JMPartTimeJobResumeFooterView.h"
#import "JMMakeOutBillView.h"
#import "JMMakeOutBillHeaderView.h"
#import "JMComfirmPostBottomView.h"
#import "JMCityListViewController.h"
#import "JMIndustryWebViewController.h"
#import "JMPartTimeJobTypeLabsViewController.h"
#import "JMHTTPManager+CreateTask.h"
#import "JMHTTPManager+FectchTaskInfo.h"
#import "JMTaskPartTimejobDetailModel.h"
#import "JMTaskGoodsDetailModel.h"
#import "JMHTTPManager+UpdateTask.h"
#import "JMHTTPManager+DeleteTask.h"
#import "JMGetCompanyLocationViewController.h"
#import "JMHTTPManager+FectchInvoiceInfo.h"
#import "JMInvoiceModel.h"
#import "JMChoosePartTImeJobTypeLablesViewController.h"
#import "JMServiceProtocolWebViewController.h"
#import "JMBUserPositionVideoView.h"
#import "Demo3ViewController.h"
#import "JMVideoPlayManager.h"
#import "JMHTTPManager+Uploads.h"
#import "JMHTTPManager+DeleteGoodsImage.h"
#import "JMPictureManagerViewController.h"
#import "JMPictureAddViewController.h"
#import "HXPhotoTools.h"

#define RightTITLE_COLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]
@interface JMBUserPostPartTimeJobViewController ()<JMPartTimeJobResumeFooterViewDelegate,JMMakeOutBillHeaderViewDelegate,JMBUserPartTimeJobDetailViewDelegate,JMCityListViewControllerDelegate,JMIndustryWebViewControllerDelegate,JMPartTimeJobTypeLabsViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,JMComfirmPostBottomViewDelegate,UIScrollViewDelegate,JMMakeOutBillHeaderViewDelegate,JMMakeOutBillViewDelegate,UITextFieldDelegate,JMChoosePartTImeJobTypeLablesViewControllerDelegate,JMBUserPositionVideoViewDelegate,UIImagePickerControllerDelegate,Demo3ViewControllerDelegate,JMPictureAddViewControllerDelegate,JMPictureManagerViewControllerDelegate>
@property(nonatomic, strong)JMBUserPartTimeJobDetailView *partTimeJobDetailView;
@property (strong, nonatomic)NSArray *leftTextArray;
@property (strong, nonatomic)UIScrollView *scrollView;
@property (nonatomic,strong)JMPartTimeJobResumeFooterView *decriptionTextView;
@property (nonatomic,strong)JMBUserPositionVideoView *videoView;
@property (strong, nonatomic)Demo3ViewController *demo3ViewVC;

@property (nonatomic,strong)JMMakeOutBillView *makeOutBillView;
@property (nonatomic,strong)JMMakeOutBillHeaderView *makeOutBillHeaderView;
@property (nonatomic,strong)JMComfirmPostBottomView *comfirmPostBottomView;
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)NSArray *quantityArray;;
@property (nonatomic,strong)UIDatePicker *dataPickerView;
@property (weak, nonatomic) IBOutlet UIView *twoBtnBottomView;
@property (nonatomic ,assign)BOOL isChange;
@property (nonatomic, strong)AMapPOI *POIModel;
@property (nonatomic, strong)JMInvoiceModel *invoiceModel;
//@property (weak, nonatomic) IBOutlet UIButton *bottomLeftBtn;
@property (nonatomic, strong)JMTaskPartTimejobDetailModel *partTimejobDetailModel;
@property (nonatomic,strong)NSMutableArray *photoModel_arr;

//请求参数
@property (copy, nonatomic)NSString *type_label_id;//职位ID
@property (copy, nonatomic)NSString *task_title;//职位名称
@property (copy, nonatomic)NSString *unit;//计价单位
@property (copy, nonatomic)NSString *payment_money;//任务金额
@property (copy, nonatomic)NSString *front_money;//任务定金
@property (copy, nonatomic)NSString *quantity_max;//招募人数
@property (strong, nonatomic)NSMutableArray *industry_arr;//适合行业
@property (copy, nonatomic)NSString *city_id;//城市
@property (copy, nonatomic)NSString *adress;//地区名称
@property (copy, nonatomic)NSString *longitude;
@property (copy, nonatomic)NSString *latitude;
@property (copy, nonatomic)NSString *myDecription;//职位描述
@property (copy, nonatomic)NSString *deadline;//有效日期

@property (copy, nonatomic)NSString *video_path;
@property (copy, nonatomic)NSString *video_cover;
@property (strong, nonatomic)NSMutableArray *imageUrl_arr;//图片链接
@property (strong, nonatomic)NSMutableArray *imageUrl_arr2;//正确顺序

@property (strong, nonatomic)NSArray *image_arr;//增加的图片
@property (strong, nonatomic)NSMutableArray *ids;//图片链接(增加的)或者图片file_id(原来的)
@property (strong, nonatomic)NSMutableArray *sorts;//排序


@property (copy, nonatomic)NSString *is_invoice;//是否有发票
@property (copy, nonatomic)NSString *invoice_title;//发票抬头
@property (copy, nonatomic)NSString *invoice_tax_number;//税务编号
@property (copy, nonatomic)NSString *invoice_email;//邮箱
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomH;

//
@property (copy, nonatomic)NSString *cityName;//地区
@property (nonatomic,copy)NSString *labsJson;
@property (assign, nonatomic)BOOL isReadProtocol;//是否阅读了协议

@end

@implementation JMBUserPostPartTimeJobViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getInvoiceInfo];//获取发票信息
    [self initView];
    [self initLayout];
    
    if (_viewType == JMBUserPostPartTimeJobTypeEdit) {
        
        [self setRightBtnTextName:@"删除"];
        self.title = @"编辑任务";

    }else if (_viewType == JMBUserPostPartTimeJobTypeAdd || _viewType == JMBUserPostPartTimeJobTypeHistory) {
        self.title = @"发布任务";
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePickView)];
    [self.view addGestureRecognizer:tap];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tap2];
    self.bottomH.constant = 61 + SafeAreaBottomHeight;
    [self showProgressHUD_view:self.view];
    [self hiddenHUD];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.comfirmPostBottomView.frame.origin.y+self.comfirmPostBottomView.frame.size.height+100);
}

-(void)initView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.partTimeJobDetailView];//资料填写
    [self.scrollView addSubview:self.decriptionTextView];//职位描述
    [self.scrollView addSubview:self.videoView];
    [self.scrollView addSubview:self.makeOutBillHeaderView];//选择是否需要开发票
    [self.scrollView addSubview:self.makeOutBillView];//发票填写
    [self.scrollView addSubview:self.comfirmPostBottomView];//确认发布
    if (_viewType == JMBUserPostPartTimeJobTypeEdit) {
        [self getData];
        self.twoBtnBottomView.hidden = NO;
        [self.view addSubview:self.twoBtnBottomView];
        [self.comfirmPostBottomView setHidden:YES];
    }else if (_viewType == JMBUserPostPartTimeJobTypeAdd) {
        [self.comfirmPostBottomView setHidden:NO];
    }else if (_viewType == JMBUserPostPartTimeJobTypeHistory) {
        [self getData];
        [self.comfirmPostBottomView setHidden:NO];

    }
}

-(void)initLayout{
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.partTimeJobDetailView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 446);
    self.decriptionTextView.frame = CGRectMake(0, _partTimeJobDetailView.frame.origin.y+_partTimeJobDetailView.frame.size.height+10, SCREEN_WIDTH, 222);
    self.videoView.frame = CGRectMake(0, _decriptionTextView.frame.origin.y+_decriptionTextView.frame.size.height+10, SCREEN_WIDTH, 331);
    self.makeOutBillHeaderView.frame = CGRectMake(0, _videoView.frame.origin.y+_videoView.frame.size.height+10, SCREEN_WIDTH, 106);
    self.makeOutBillView.frame = CGRectMake(0, _makeOutBillHeaderView.frame.origin.y+_makeOutBillHeaderView.frame.size.height, SCREEN_WIDTH, 314);
    self.comfirmPostBottomView.frame = CGRectMake(0, _makeOutBillView.frame.origin.y+_makeOutBillView.frame.size.height, SCREEN_WIDTH, 127);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.comfirmPostBottomView.frame.origin.y+self.comfirmPostBottomView.frame.size.height+100);
}
#pragma mark - myAction

//- (IBAction)bottomLeftAction:(UIButton *)sender {
//    if ([_partTimejobDetailModel.status isEqualToString:Position_Online]) {
//
//
//        //下线
//        [self updateTaskInfoRequest_status:Position_Downline];
//
//    }else if ([_partTimejobDetailModel.status isEqualToString:Position_Downline]){
//        //上线
//        [self updateTaskInfoRequest_status:Position_Online];
//
//
//    }
//
//}

- (IBAction)bottomRightAction:(UIButton *)sender {
    //保存编辑
    if (_isChange) {
        [self updateTaskInfoRequest_status:@"1"];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)doneClicked{
    [self.decriptionTextView.contentTextView resignFirstResponder];
}
#pragma mark - MyDelegate
-(void)didChooseWithType_id:(NSString *)type_id typeName:(NSString *)typeName{
    _isChange = YES;
    _type_label_id = type_id;
    [self.partTimeJobDetailView.jobTypeBtn setTitle:typeName forState:UIControlStateNormal];
    [self.partTimeJobDetailView.jobTypeBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];

}

- (void)sendlabsWithJson:(nonnull NSString *)json {
    _isChange = YES;
    self.labsJson = json;
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
    NSString *rightStr = [arrayName componentsJoinedByString:@","];
    [self.partTimeJobDetailView.industryBtn setTitle:rightStr forState:UIControlStateNormal];
    [self.partTimeJobDetailView.industryBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];

    NSLog(@"_industry_arr%@",rightStr);

}

- (void)didSelectedCity_id:(nonnull NSString *)city_id city_name:(nonnull NSString *)city_name {
    _isChange = YES;
    
    _city_id = city_id;
    [self.partTimeJobDetailView.cityBtn setTitle:city_name forState:UIControlStateNormal];
    [self.partTimeJobDetailView.cityBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
}

- (void)sendContent:(nonnull NSString *)content {
    _isChange = YES;

    _myDecription = content;
}

//信息填写DetailView点击事件
-(void)didClickRightBtnWithTag:(NSInteger)tag{
    switch (tag) {
        case 1000://职位类型
            [self gotoLabsVC];
            break;
        case 1001://任务有效期
            [self showDataPickView];
            break;
        case 1002://发布城市
            [self gotoCityListVC];
            break;
        case 1003://招募人数
//            [self showPickView];
            break;
        case 1004://适合行业
            [self gotoIndustryVC];

            break;
        case 1005://上传图片
            [self gotoImageVCAction];
            
            break;
        default:
            break;
    }
}

//信息填写DetailView的textField
-(void)didWriteRightTextFieldWithtag:(NSInteger)tag text:(nonnull NSString *)text{
    _isChange = YES;

    switch (tag) {
        case 100://职位名称
            _task_title = text;
            break;
        case 101://基本工资
            _payment_money = text;
            break;
        case 102://定金
            if (text.length > 0) {
                _front_money = text;
                
            }else{
                _front_money = @"0";

            }
            break;

        case 103://招募人数
            _quantity_max = text;
            break;
        default:
            break;
    }
    
}

-(void)chooseAdressAction{
    [self.decriptionTextView.contentTextView resignFirstResponder];
    JMGetCompanyLocationViewController *vc = [[JMGetCompanyLocationViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];


}

-(void)sendAdress_Data:(AMapPOI *)data
{
    _isChange = YES;
    self.POIModel = data;
    NSString *adress = [NSString stringWithFormat:@"%@-%@-%@-%@",data.city,data.district,data.name,data.address];
    [self.makeOutBillHeaderView.adressBtn setTitle:adress forState:UIControlStateNormal];
    if (adress.length > 0) {
        _adress = adress;
     }
    _longitude = [NSString stringWithFormat:@"%f",data.location.longitude];
    _latitude = [NSString stringWithFormat:@"%f",data.location.latitude];

}
    
//是否需要开发票
-(void)didClickBillActionWithTag:(NSInteger)tag isChange:(BOOL)isChange{
    _isChange = isChange;
  
    switch (tag) {
        case 1000://需要发票
            [self.makeOutBillView setHidden:NO];
            [self changeMakeOutBillViewNeed];
            [_makeOutBillHeaderView.NOBtn setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
            [_makeOutBillHeaderView.YESBtn setImage:[UIImage imageNamed:@"组 54"] forState:UIControlStateNormal];
            self.is_invoice = @"1";
            //判断是否有写好的默认发票信息
            if (_invoiceModel) {
                [_makeOutBillView.invoiceTitleTextField setText:_invoiceModel.invoice_title];
                [_makeOutBillView.invoiceTaxNumTextField setText:_invoiceModel.invoice_tax_number];
                [_makeOutBillView.invoiceEmailTextField setText:_invoiceModel.invoice_email];
                _invoice_title = _invoiceModel.invoice_title;
                _invoice_tax_number = _invoiceModel.invoice_tax_number;
                _invoice_email = _invoiceModel.invoice_email;
            }
            break;
        case 1001://不需要发票
            [self.makeOutBillView setHidden:YES];
            [self changeMakeOutBillViewNONeed];
            [_makeOutBillHeaderView.NOBtn setImage:[UIImage imageNamed:@"组 54"] forState:UIControlStateNormal];
            [_makeOutBillHeaderView.YESBtn setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
            self.is_invoice = @"0";
         
            break;
        default:
            break;
    }
    
}

-(void)invoiceTextFieldDidEditingEndWithTextField:(UITextField *)textField{
    _isChange = YES;

    switch (textField.tag) {
        case 100:
            _invoice_title = textField.text;
            break;
        case 101:
            _invoice_tax_number = textField.text;
            break;
        case 102:
            _invoice_email = textField.text;
            break;

        default:
            break;
    }

}
//-(void)invoiceTextRerurnActionWithTextField:(UITextField *)textField{
//    [textField resignFirstResponder];
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)gotoLabsVC{
    if (_viewType == JMBUserPostPartTimeJobTypeEdit) {
        
        return;
    }else if (_viewType == JMBUserPostPartTimeJobTypeAdd || _viewType == JMBUserPostPartTimeJobTypeHistory) {
    
        JMChoosePartTImeJobTypeLablesViewController *vc =  [[JMChoosePartTImeJobTypeLablesViewController alloc]init];
        vc.delegate = self;
        vc.myVC = self;
        //    vc.viewType = JMChoosePartTImeJobTypeLablesViewTypePartTimeJob;
        [self.navigationController pushViewController:vc animated:YES];
    
    }
}

-(void)gotoIndustryVC{
    JMIndustryWebViewController *vc =  [[JMIndustryWebViewController alloc]init];
    vc.delegate = self;
    vc.labsJson = self.labsJson;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoCityListVC{
    JMCityListViewController *vc =  [[JMCityListViewController alloc]init];
    vc.delegate = self;
    vc.viewType = JMCityListViewPartTime;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)gotoImageVCAction{
    
    if (_viewType == JMBUserPostPartTimeJobTypeEdit) {
        //编辑状态
//        _demo3ViewVC = [[Demo3ViewController alloc]init];
//        _demo3ViewVC.delegate = self;
//        _demo3ViewVC.task_id = self.task_id;//进入界面重新调用接口获得最新图片
//        _demo3ViewVC.viewType = Demo3ViewPostPartTimeJobEdit;
//        if (_image_arr.count > 0) {
//            //选好的图片_image_arr
//            _demo3ViewVC.image_paths = _image_arr.mutableCopy;
//        }
        JMPictureManagerViewController *vc = [[JMPictureManagerViewController alloc]init];
//        vc.imgUrl_arr = self.imageUrl_arr;
        vc.delegate = self;
        vc.photoModel_arr = self.photoModel_arr;
        [self.navigationController pushViewController:vc animated:YES];

    }else if (_viewType == JMBUserPostPartTimeJobTypeAdd || _viewType == JMBUserPostPartTimeJobTypeHistory) {
        //添加状态
//        _demo3ViewVC.viewType = Demo3ViewPostPartTimeJobAdd;
//        JMPictureManagerViewController *vc = [[JMPictureManagerViewController alloc]init];
        JMPictureAddViewController *vc = [[JMPictureAddViewController alloc]init];
        vc.delegate = self;
        vc.image_arr = self.image_arr;
        [self.navigationController pushViewController:vc animated:YES];

    }

    
}


-(void)pictureAddWithImage_arr:(NSArray *)image_arr{
    _image_arr = image_arr;//用户选择后的图片数组
    //self.imageUrl_arr2//用来正确排序的数组，装服务器返回的链接
    for (int i = 0; i < self.image_arr.count; i++) {
        [self.imageUrl_arr2 addObject:[NSNull null]];
        UIImage *img = self.image_arr[i];
        [self uploadImgRequest:img index:i];//上传图片请求
    }
    
     [self.partTimeJobDetailView.postImgBtn setTitle:@"已上传" forState:UIControlStateNormal];
     [self.partTimeJobDetailView.postImgBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
}


-(void)pictureManagerWithPhotoModel_arr:(NSMutableArray *)photoModel_arr{
    _isChange = YES;
    self.photoModel_arr = photoModel_arr;
    
    self.ids = [NSMutableArray array];
    self.sorts = [NSMutableArray array];
    self.imageUrl_arr = [NSMutableArray array];
    for (int i = 0; i < photoModel_arr.count; i++) {
        HXPhotoModel *model = photoModel_arr[i];
        //self.sorts 用于服务器排序
        [self.sorts addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        //self.ids用于服务器排序，没有(file_id)就是新增加的图片数据
        if (model.file_id) {
            //旧图
            [self.ids addObject:model.file_id];
        }else if(model.networkPhotoUrl){
            //新图
            [self.ids addObject:[model.networkPhotoUrl absoluteString]];
            //self.imageUrl_arr新增加的图片，用于上传给服务器新增图片
            [self.imageUrl_arr addObject:[model.networkPhotoUrl absoluteString]];
        }
  
    }
     [self.partTimeJobDetailView.postImgBtn setTitle:@"已上传" forState:UIControlStateNormal];
     [self.partTimeJobDetailView.postImgBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
}

//-(void)pictureManagerWithDelete_arr:(NSMutableArray *)delete_arr{
//    [self.delete_arr addObjectsFromArray:delete_arr];
//
//}

-(void)changeMakeOutBillViewNONeed{
    __weak typeof(self) ws = self;
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
      ws.comfirmPostBottomView.frame = CGRectMake(0, ws.makeOutBillHeaderView.frame.origin.y+ws.makeOutBillHeaderView.frame.size.height, SCREEN_WIDTH, 127);
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.comfirmPostBottomView.frame.origin.y+self.comfirmPostBottomView.frame.size.height+100);
    } completion:nil];

}

-(void)changeMakeOutBillViewNeed{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.comfirmPostBottomView.frame = CGRectMake(0, ws.makeOutBillView.frame.origin.y+ws.makeOutBillView.frame.size.height, SCREEN_WIDTH, 127);
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.comfirmPostBottomView.frame.origin.y+self.comfirmPostBottomView.frame.size.height+100);
    } completion:nil];
  
}


- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    _deadline = dateStr;
    [self.partTimeJobDetailView.deadLineBtn setTitle:dateStr forState:UIControlStateNormal];
    [self.partTimeJobDetailView.deadLineBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
 }

////字符串转时间
//- (NSDate *)nsstringConversionNSDate:(NSString *)dateStr
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSDate *datestr = [dateFormatter dateFromString:dateStr];
//    return datestr;
//}

-(void)showDataPickView{
    [self hideKeyBoard];
    [self.view addSubview:self.dataPickerView];
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.dataPickerView.frame = CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350);
    } completion:nil];
    
    
}

-(void)hideKeyBoard{
    [self.partTimeJobDetailView.jobNameTextField resignFirstResponder];
    [self.partTimeJobDetailView.paymentMoneyTextField resignFirstResponder];
    [self.partTimeJobDetailView.downPaymentTextField resignFirstResponder];
    [self.decriptionTextView.contentTextView resignFirstResponder];
    [self.makeOutBillView.invoiceTitleTextField resignFirstResponder];
    [self.makeOutBillView.invoiceTaxNumTextField resignFirstResponder];
    [self.makeOutBillView.invoiceEmailTextField resignFirstResponder];
}


-(void)hidePickView{

    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.dataPickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350);
    } completion:nil];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.pickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350);
    } completion:nil];
}
//视频模块
-(void)videoLeftBtnAction{
    [self filmVideo];
}

-(void)videoRightBtnAction{
    [self uploadVideo];
    
}

-(void)playBtnActionWithUrl:(NSString *)url{
//    [self fetchmyVideo];
//    NSString * path;
//    if (_viewType == JMBUserPostPartTimeJobTypeAdd) {
//        //本地获取链接播放，需要拼接
//        if (![self.video_path containsString:@"https://jmsp-videos"]) {
//            path = [NSString stringWithFormat:@"https://jmsp-videos-1257721067.cos.ap-guangzhou.myqcloud.com%@",self.video_path];
//        }else{
//            path = self.video_path;
//
//        }
//    }else if (_viewType == JMBUserPostPartTimeJobTypeEdit) {
//        path = url;
//    }
    
    //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
    //        AVPlayer *player = [AVPlayer playerWithURL:url];
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:url videoID:@"666"];
    [[JMVideoPlayManager sharedInstance] play];
    [JMVideoPlayManager sharedInstance].viewType = JMVideoPlayManagerTypeDefault;
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    
}


-(void)isReadProtocol:(BOOL)isRead{
    if (!isRead) {
        [self.comfirmPostBottomView.OKBtn setBackgroundColor:TEXT_GRAY_COLOR];
        self.isReadProtocol = NO;
    }else{
        [self.comfirmPostBottomView.OKBtn setBackgroundColor:MASTER_COLOR];
        self.isReadProtocol = YES;
    }
}

-(void)OKAction{
    [self.partTimeJobDetailView.jobNameTextField resignFirstResponder];
    [self.partTimeJobDetailView.paymentMoneyTextField resignFirstResponder];
    [self.partTimeJobDetailView.quantityMaxTextField resignFirstResponder];
    [self.partTimeJobDetailView.downPaymentTextField resignFirstResponder];
    [self.decriptionTextView.contentTextView resignFirstResponder];
    [self.makeOutBillView.invoiceTitleTextField resignFirstResponder];
    [self.makeOutBillView.invoiceTaxNumTextField resignFirstResponder];
    [self.makeOutBillView.invoiceEmailTextField resignFirstResponder];

    if (self.decriptionTextView.contentTextView.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请完善职位描述信息" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }


    if (self.isReadProtocol == YES) {
        //        [self.imageUrl_arr removeAllObjects];
        [self sendRequest];

    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请阅读并同意《平台服务协议》" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }])];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    
}


-(void)protocolAction{
    JMServiceProtocolWebViewController *vc = [[JMServiceProtocolWebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 图片
- (void)sendArray_addImageUrls:(NSMutableArray *)addImageUrls {
    _isChange = YES;
    self.imageUrl_arr = addImageUrls;
    NSLog(@"addImageUrls%@",addImageUrls);
    [self.partTimeJobDetailView.postImgBtn setTitle:@"已上传" forState:UIControlStateNormal];
    [self.partTimeJobDetailView.postImgBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
}

//添加的图片
//-(void)sendAddImgs:(NSMutableArray *)Imgs{
//    [self updateTaskImagesRequest_images:Imgs.mutableCopy];
//    //    [self uploadCompanyWithImages:Imgs.mutableCopy];
//}

//删除图片
-(void)deleteSalePositionImageWithIndex:(NSInteger)index{
    if (self.photoModel_arr.count > 0) {
        JMImageModel *model = self.photoModel_arr[index];
        if (index < self.photoModel_arr.count) {
            [self deleteGoodsImageRequsetWithFile_id:model.file_id];
            [self.photoModel_arr removeObject:model];
            //        [self.image_arr.mutableCopy removeObjectAtIndex:index];
        }
        
    }
}





////编辑任务，添加的图片
//-(void)sendAddImgs:(NSMutableArray *)Imgs{
//    _isChange = YES;
//    [self updateTaskImagesRequest_images:Imgs.mutableCopy];
//    [self.partTimeJobDetailView.postImgBtn setTitle:@"已上传" forState:UIControlStateNormal];
//    [self.partTimeJobDetailView.postImgBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
//    //    [self uploadCompanyWithImages:Imgs.mutableCopy];
//}
//
////发布新任务
//- (void)sendArray_addImageUrls:(NSMutableArray *)addImageUrls {
//    _isChange = YES;
//    self.image_arr = addImageUrls;
//    NSLog(@"addImageUrls%@",addImageUrls);
//    [self.partTimeJobDetailView.postImgBtn setTitle:@"已上传" forState:UIControlStateNormal];
//    [self.partTimeJobDetailView.postImgBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
//}
//
////删除图片
//-(void)deleteSalePositionImageWithIndex:(NSInteger)index{
//    _isChange = YES;
//    if (self.imageDataArr.count > 0) {
//        JMImageModel *model = self.imageDataArr[index];
//        if (index < self.imageDataArr.count) {
//            [self deleteGoodsImageRequsetWithFile_id:model.file_id];
//            [self.imageDataArr removeObject:model];
//            //        [self.image_arr.mutableCopy removeObjectAtIndex:index];
//        }
//
//    }
//}


#pragma mark - ScrollViewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [self hidePickView];
}

#pragma mark - 赋值
-(void)setRightBtnValues_model:(JMTaskPartTimejobDetailModel *)model{
    [self.partTimeJobDetailView.jobTypeBtn setTitle:model.type_labelName forState:UIControlStateNormal];
    [self.partTimeJobDetailView.jobTypeBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
    [self.partTimeJobDetailView.jobNameTextField setText:model.task_title];
    if (_viewType == JMBUserPostPartTimeJobTypeEdit) {
        [self.partTimeJobDetailView.jobNameTextField setEnabled:NO];
        
    }

    [self.partTimeJobDetailView.paymentMoneyTextField setText:model.payment_money];
    [self.partTimeJobDetailView.downPaymentTextField setText:model.front_money];
    if (model.cityID == nil) {
        [self.partTimeJobDetailView.cityBtn setTitle:@"不限" forState:UIControlStateNormal];
    }else{
        [self.partTimeJobDetailView.cityBtn setTitle:model.cityName forState:UIControlStateNormal];
    }
    [self.partTimeJobDetailView.cityBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    [self.makeOutBillHeaderView.adressBtn setTitle:model.address forState:UIControlStateNormal];
    [self.makeOutBillHeaderView.adressBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
    [self.partTimeJobDetailView.deadLineBtn setTitle:model.deadline forState:UIControlStateNormal];
    [self.partTimeJobDetailView.deadLineBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    [self.partTimeJobDetailView.quantityMaxTextField setText:model.quantity_max];
    if (model.images.count > 0) {
        [self.partTimeJobDetailView.postImgBtn setTitle:@"已上传" forState:UIControlStateNormal];
        [self.partTimeJobDetailView.postImgBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    }

    
    NSMutableArray *industryNameArray = [NSMutableArray array];
    _industry_arr = [NSMutableArray array];

    for (JMTaskIndustryModel *industryModel in model.industry) {
        [industryNameArray addObject:industryModel.name];
        [_industry_arr addObject:industryModel.label_id];
    }
    NSString *industry = [industryNameArray componentsJoinedByString:@","];
    [self.partTimeJobDetailView.industryBtn setTitle:industry forState:UIControlStateNormal];
    [self.partTimeJobDetailView.industryBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
    [self.decriptionTextView setContent:model.taskDescription];

//    _image_arr = [NSMutableArray array];
//    for (JMImageModel *imgModel in model.images) {
//        [_image_arr addObject:imgModel.file_path];
//    }
//    _video_path = model.video_file_path;
//    _video_cover = model.video_cover;
    if (model.video_cover.length > 0 && model.video_file_path.length > 0) {
//        NSURL *url = [NSURL URLWithString:model.video_cover];
//        [self.videoView.videoImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"NOvideos"]];
        [self.videoView.playBtn setHidden:NO];
        [self.videoView setVideo_path:model.video_file_path];
        [self.videoView setVideo_cover:model.video_cover];
//        [self.videoView setValusWithVideo_path:model.video_file_path video_cover:model.video_cover];
    }
    
    _type_label_id = model.type_labelID;
    _task_title = model.task_title;
    _payment_money = model.payment_money;
    _front_money = model.front_money;
    _quantity_max = model.quantity_max;
    
    for (JMImageModel *imgModel in model.images) {
        [self.imageUrl_arr addObject:imgModel.file_path];
    }
    
//    _image_arr = model.images;
    if (model.address.length > 0) {
        _adress = model.address;
        
    }
    _myDecription = model.taskDescription;
    if (model.cityID == nil) {
        _city_id = @"0";
    }else{
        _city_id = model.cityID;
    }

}

-(void)setInvoiceValuesWithModel:(JMInvoiceModel *)model{
    self.makeOutBillView.invoiceTitleTextField.text = model.invoice_title;
    self.makeOutBillView.invoiceTaxNumTextField.text = model.invoice_tax_number;
    self.makeOutBillView.invoiceEmailTextField.text = model.invoice_email;
    

}

#pragma mark - 提交数据
-(void)rightAction{
    //删除任务
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除吗，删除后数据将不可恢复！" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteTaskRequest];
        
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
 
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
  
}

//获取 -默认- 发票信息
-(void)getInvoiceInfo{
    [[JMHTTPManager sharedInstance]fectchInvoiceInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

        if (responsObject[@"data"]) {
            _invoiceModel = [JMInvoiceModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            if (_viewType == JMBUserPostPartTimeJobTypeAdd || _viewType == JMBUserPostPartTimeJobTypeHistory) {//添加状态
                if (![responsObject[@"data"][@"invoice"] isEqual:[NSNull null]]) {
//                    [self setInvoiceValuesWithModel:_invoiceModel];
                    [self didClickBillActionWithTag:1000 isChange:NO];
                    
                }else{
                    [self didClickBillActionWithTag:1001 isChange:NO];
                    
                }
                
            }
        }
      
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}


-(void)sendRequest{
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSString *url in _imageUrl_arr) {
        if ([url containsString:@"https://jmsp-images-1257721067.picgz.myqcloud.com"]) {
            NSString *strUrl = [url stringByReplacingOccurrencesOfString:@"https://jmsp-images-1257721067.picgz.myqcloud.com" withString:@""];
            [imageArr addObject:strUrl];
            
        }else{
            imageArr = _imageUrl_arr;
        }
    }
    
    [[JMHTTPManager sharedInstance]createTask_task_title:_task_title type_label_id:_type_label_id payment_method:@"3" unit:@"元" payment_money:_payment_money front_money:_front_money quantity_max:_quantity_max myDescription:_myDecription industry_arr:_industry_arr city_id:_city_id longitude:_longitude latitude:_latitude address:_adress goods_title:nil goods_price:nil goods_desc:nil video_path:_video_path video_cover:_video_cover image_arr:imageArr deadline:_deadline status:nil is_invoice:_is_invoice invoice_title:_invoice_title invoice_tax_number:_invoice_tax_number invoice_email:_invoice_email successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self showAlertVCSucceesSingleWithMessage:@"创建任务成功" btnTitle:@"好的"];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}




-(void)deleteTaskRequest{
    [[JMHTTPManager sharedInstance]deleteTask_Id:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n" message:@"删除成功" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.navigationController.viewControllers.count >=2) {
                UIViewController *listViewController =self.navigationController.viewControllers[1];
                [self.navigationController popToViewController:listViewController animated:YES];
            }
            
        }]];
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"purchase_succeeds"];
        [alert.view addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(alert.view).mas_offset(23);
            make.centerX.mas_equalTo(alert.view);
            make.size.mas_equalTo(CGSizeMake(75, 64));
            
        }];
        [self presentViewController:alert animated:YES completion:nil];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

//上传图片请求
//-(void)updateTaskImagesRequest_images:(NSArray *)images{
//    [[JMHTTPManager sharedInstance]updateTaskWithId:self.task_id payment_method:@"3" unit:@"元" payment_money:nil front_money:nil quantity_max:nil myDescription:nil industry_arr:nil city_id:nil longitude:nil latitude:nil address:nil goods_title:nil goods_price:nil goods_desc:nil video_path:nil video_cover:nil image_arr:images is_invoice:nil invoice_title:nil invoice_tax_number:nil invoice_email:nil status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"成功添加图片" preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        }])];
//        [self presentViewController:alertController animated:YES completion:nil];
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//}

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

//更新任务请求
-(void)updateTaskInfoRequest_status:(NSString *)status{
    [self.partTimeJobDetailView.jobNameTextField resignFirstResponder];
    [self.partTimeJobDetailView.paymentMoneyTextField resignFirstResponder];
    [self.partTimeJobDetailView.downPaymentTextField resignFirstResponder];
    [self.decriptionTextView.contentTextView resignFirstResponder];
    [self.makeOutBillView.invoiceTitleTextField resignFirstResponder];
    [self.makeOutBillView.invoiceTaxNumTextField resignFirstResponder];
    [self.makeOutBillView.invoiceEmailTextField resignFirstResponder];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSString *url in _imageUrl_arr) {
        if ([url containsString:@"http://produce.jmzhipin.com"] || [url containsString:@"https://jmsp-images-1257721067.picgz.myqcloud.com"]) {
            if ([url containsString:@"https://jmsp-images-1257721067.picgz.myqcloud.com"]) {
                NSString *strUrl = [url stringByReplacingOccurrencesOfString:@"https://jmsp-images-1257721067.picgz.myqcloud.com" withString:@""];
                [imageArr addObject:strUrl];
                 
            }else if ([url containsString:@"http://produce.jmzhipin.com"]){
                NSString *strUrl = [url stringByReplacingOccurrencesOfString:@"http://produce.jmzhipin.com" withString:@""];
                      [imageArr addObject:strUrl];
                       
            }
            
        }else{
            [imageArr addObject:url];

        }
    }
    
    [[JMHTTPManager sharedInstance]updateTaskWithId:self.task_id payment_method:@"3" unit:@"元" payment_money:_payment_money front_money:_front_money quantity_max:_quantity_max myDescription:_myDecription industry_arr:_industry_arr city_id:_city_id longitude:_longitude latitude:_latitude  address:_adress goods_title:nil goods_price:nil goods_desc:nil video_path:_video_path video_cover:_video_cover image_arr:imageArr  ids:self.ids  sorts:self.sorts  is_invoice:_is_invoice invoice_title:_invoice_title invoice_tax_number:_invoice_tax_number invoice_email:_invoice_email status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
        [self showAlertVCSucceesSingleWithMessage:@"保存成功" btnTitle:@"好的"];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

-(void)alertSucceesAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//获取兼职职位详情数据
-(void)getData{
    [[JMHTTPManager sharedInstance]fectchTaskInfo_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            _partTimejobDetailModel = [JMTaskPartTimejobDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
       
//            if ([_partTimejobDetailModel.status isEqualToString:Position_Downline]) {
//                [self.bottomLeftBtn setTitle:@"重新上线" forState:UIControlStateNormal];
//
//            }else if ([_partTimejobDetailModel.status isEqualToString:Position_Online]) {
//                [self.bottomLeftBtn setTitle:@"下线" forState:UIControlStateNormal];
//
//            }
            
            //赋值
            [self setRightBtnValues_model:_partTimejobDetailModel];
            //编辑状态
            if (_viewType == JMBUserPostPartTimeJobTypeEdit) {
                //判断该职位信息本身是否需要开发票
                if (_partTimejobDetailModel.invoice_tax_number == nil || _partTimejobDetailModel.invoice_title == nil || _partTimejobDetailModel.invoice_email == nil ) {
                    //不需要开发票
                    [self didClickBillActionWithTag:1001 isChange:NO];

                }else{
                    //需要开发票
                    _invoiceModel = [[JMInvoiceModel alloc]init];
                    _invoiceModel.invoice_title = _partTimejobDetailModel.invoice_title;
                    _invoiceModel.invoice_tax_number = _partTimejobDetailModel.invoice_tax_number;
                    _invoiceModel.invoice_email = _partTimejobDetailModel.invoice_email;
                    [self setInvoiceValuesWithModel:_invoiceModel];
                    
                }
                
            }
//            self.imageModel_arr = _partTimejobDetailModel.images.mutableCopy;
            for (JMImageModel *imgModel in _partTimejobDetailModel.images) {
                HXPhotoModel *photoModel = [[HXPhotoModel alloc]init];
                photoModel.networkPhotoUrl = [NSURL URLWithString:imgModel.file_path];
                photoModel.file_id = imgModel.file_id;
                [self.photoModel_arr addObject:photoModel];
            }

        }
        [self hiddenHUD];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
}


#pragma mark - 视频





- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
    if (image) {
        
        
    }else{
        
        //会以MOV格式存储在tmp目录下
        NSURL *source = [info objectForKey:UIImagePickerControllerMediaURL];
        //计算视频大小
        CGFloat length = [self getVideoLength:source];
        CGFloat size = [self getFileSize:[source path]];
        NSLog(@"视频的时长为%lf s \n 视频的大小为%.2f M",length,size);
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        // 将图片写入文件
        [self showHUD];
        //        压缩
        [self compressVideo:source];
    }
    
}


-(void)uploadVideo{
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    //    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    //    if (availableMedia.count) {
    //        ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    //    }
    ipc.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;//设置委托
    
    
    
}

-(void)filmVideo{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //检测是否开通权限
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无拍摄视频权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    //使用UIImagePickerController视频录制
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    //mediaTypes设置摄影还是拍照
    //kUTTypeImage 对应拍照
    //kUTTypeMovie  对应摄像
    //    NSString *requiredMediaType = ( NSString *)kUTTypeImage;
    NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
    NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType1,nil];
    picker.mediaTypes = arrMediaTypes;
    //    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;默认是中等
    picker.videoMaximumDuration = 60.; //60秒
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
    
}

/**
 获取文件大小
 
 @param path 路径
 @return M
 */
- (CGFloat)getFileSize:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}


/**
 获取视频时长
 
 @param url url
 @return s
 */
- (CGFloat)getVideoLength:(NSURL *)url{
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:url];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}


/**
 视频压缩
 */
- (void)compressVideo:(NSURL *)url{
    
    NSURL *newVideoUrl ; //一般.mp4
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉，减少空间。
    
    [self convertVideoQuailtyWithInputURL:url outputURL:newVideoUrl completeHandler:nil];
    
}


//-(void)fetchmyVideo{
//    NSString * path;
//    if (![self.video_path containsString:@"https://jmsp-videos"]) {
//        path = [NSString stringWithFormat:@"https://jmsp-videos-1257721067.cos.ap-guangzhou.myqcloud.com%@",self.video_path];
//    }else{
//        path = self.video_path;
//
//    }
//    //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
//    //        AVPlayer *player = [AVPlayer playerWithURL:url];
//    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:path];
//    [[JMVideoPlayManager sharedInstance] play];
//    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
//    [self presentViewController:playVC animated:YES completion:nil];
//    [[JMVideoPlayManager sharedInstance] play];
//
//}

/**
 压缩完成调用上传
 
 @param inputURL 输入url
 @param outputURL 输出url
 @param handler AVAssetExportSession转码
 */
- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:{
                 //                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 //UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                 
                 dispatch_async(dispatch_get_global_queue(0, 0), ^{
                     CGFloat length = [self getVideoLength:outputURL];
                     CGFloat size = [self getFileSize:[outputURL path]];
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         //                         self.bottomLab.text = [NSString stringWithFormat:@"%.2f s, 压缩后大小为：%.2f M",length,size];
                         NSLog(@"%.2f s %.2f M",length,size);
                         [self centerFrameImageWithVideoURL:outputURL completion:^(UIImage *image) {
                             self.videoView.videoImg.image = image;
                             if (image) {
                                 [_videoView.playBtn setHidden:NO];
                                 [_videoView.videoLeftBtn setTitle:@"重新拍摄" forState:UIControlStateNormal];
                                 [_videoView.videoRightBtn setTitle:@"重新上传" forState:UIControlStateNormal];
//                                 [self uploadImgRequest:image];
                                 [self  uploadVideoCoverImgRequest:image];
                             }
                         }];
                     });
                 });
                 
                 
                 //上传视频
                 [self uploadVideo:outputURL];
             }
                 
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}

-(void)uploadImgRequest:(UIImage *)img index:(int)index{
    NSArray *array = @[img];

    [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            NSString *url = responsObject[@"data"][0];
            if (self.imageUrl_arr2.count > 0) {
                [self.imageUrl_arr2 replaceObjectAtIndex:index withObject:url];
                _imageUrl_arr = _imageUrl_arr2;
                 
            }

        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

//获取封面
-(void)uploadVideoCoverImgRequest:(UIImage *)img{
    NSArray *array = @[img];

    [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            _video_cover = responsObject[@"data"][0];


        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

#pragma mark - 异步获取帧图片

// 异步获取帧图片，可以一次获取多帧图片
- (void)centerFrameImageWithVideoURL:(NSURL *)videoURL completion:(void (^)(UIImage *image))completion {
    //    NSString *str = @"https://jmsp-1258537318.cos.ap-guangzhou.myqcloud.com/storage/images/2019/05/14/CQhHejm8wgtV9HK1uBjjJiwmp1knQdpmAvtcKP3X.mp4";
    //
    //    NSURL *URL = [NSURL URLWithString:str];
    //    // AVAssetImageGenerator
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    // calculate the midpoint time of video
    Float64 duration = CMTimeGetSeconds([asset duration]);
    // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
    // 通常来说，600是一个常用的公共参数，苹果有说明:
    // 24 frames per second (fps) for film, 30 fps for NTSC (used for TV in North America and
    // Japan), and 25 fps for PAL (used for TV in Europe).
    // Using a timescale of 600, you can exactly represent any number of frames in these systems
    CMTime midpoint = CMTimeMakeWithSeconds(duration / 2.0, 600);
    
    // 异步获取多帧图片
    NSValue *midTime = [NSValue valueWithCMTime:midpoint];
    [imageGenerator generateCGImagesAsynchronouslyForTimes:@[midTime] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        if (result == AVAssetImageGeneratorSucceeded && image != NULL) {
            UIImage *centerFrameImage = [[UIImage alloc] initWithCGImage:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(centerFrameImage);
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(nil);
                }
            });
        }
    }];
}

- (void)uploadVideo:(NSURL *)url{
    //        上传data
    NSArray *array = @[url];
    [[JMHTTPManager sharedInstance]uploadsWithMP4Files:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            NSLog(@"%@",responsObject[@"data"][0]);
            NSString *url = responsObject[@"data"][0];
            NSLog(@"urlurlurlurl--%@",url);
            self.video_path = url;
            [self.videoView setVideo_path:url];
            _isChange = YES;
            //            [self updateInfoData];
            [self hiddenHUD];
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    上传成功可以选择删除
    //        [[NSFileManager defaultManager] removeItemAtPath:[url path] error:nil];
    
    
}

#pragma mark - Getter

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.backgroundColor = BG_COLOR;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(JMBUserPartTimeJobDetailView *)partTimeJobDetailView{
    if (_partTimeJobDetailView == nil) {
        _partTimeJobDetailView = [[JMBUserPartTimeJobDetailView alloc]init];
        _partTimeJobDetailView.delegate = self;
        _partTimeJobDetailView.jobNameTextField.delegate = self;
        _partTimeJobDetailView.paymentMoneyTextField.delegate = self;
        _partTimeJobDetailView.downPaymentTextField.delegate = self;
        _partTimeJobDetailView.quantityMaxTextField.delegate = self;

    }
    return _partTimeJobDetailView;
}


- (JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, 350 , SCREEN_WIDTH, 229);
        _decriptionTextView.viewType = JMPartTimeJobResumeFooterViewTypePartTimeJob;
        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        _decriptionTextView.delegate = self;
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _decriptionTextView;
}

-(JMBUserPositionVideoView *)videoView{
    if (_videoView == nil) {
        _videoView = [[JMBUserPositionVideoView alloc]init];
        _videoView.delegate = self;
        if (!self.task_id) {
            [_videoView.videoLeftBtn setTitle:@"拍摄视频" forState:UIControlStateNormal];
            [_videoView.videoRightBtn setTitle:@"上传视频" forState:UIControlStateNormal];
        }
    }
    return _videoView;
}

- (JMMakeOutBillHeaderView *)makeOutBillHeaderView{
    if (_makeOutBillHeaderView == nil) {
        _makeOutBillHeaderView = [JMMakeOutBillHeaderView new];
        _makeOutBillHeaderView.delegate = self;
    
    }
    return _makeOutBillHeaderView;
}

- (JMMakeOutBillView *)makeOutBillView{
    if (_makeOutBillView == nil) {
        _makeOutBillView = [JMMakeOutBillView new];
        _makeOutBillView.invoiceTitleTextField.delegate = self;
        _makeOutBillView.invoiceTaxNumTextField.delegate = self;
        _makeOutBillView.invoiceEmailTextField.delegate = self;
        _makeOutBillView.delegate = self;
    }
    return _makeOutBillView;
}

- (JMComfirmPostBottomView *)comfirmPostBottomView{
    if (_comfirmPostBottomView == nil) {
        _comfirmPostBottomView = [JMComfirmPostBottomView new];
        _comfirmPostBottomView.delegate = self;
        
    }
    return _comfirmPostBottomView;
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350)];
        _pickerView.backgroundColor = BG_COLOR;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _quantityArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    }
    return _pickerView;
}

-(UIDatePicker *)dataPickerView{
    if (!_dataPickerView) {
        _dataPickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350)];
        _dataPickerView.backgroundColor = BG_COLOR;
        //设置地区: zh-中国
        _dataPickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        
        //设置日期模式(Displays month, day, and year depending on the locale setting)
        _dataPickerView.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [_dataPickerView setDate:[NSDate date] animated:YES];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setYear:0];
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        //设置最小时间为：
        [_dataPickerView setMinimumDate:minDate];
        //设置时间格式
        
        //监听DataPicker的滚动
        [_dataPickerView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _dataPickerView;
}

-(NSMutableArray *)photoModel_arr{
    if (_photoModel_arr == nil) {
        _photoModel_arr = [NSMutableArray array];
    }
    return _photoModel_arr;
    
}

-(NSMutableArray *)imageUrl_arr{
    if (_imageUrl_arr == nil) {
        _imageUrl_arr = [NSMutableArray array];
    }
    return _imageUrl_arr;
    
}

-(NSMutableArray *)imageUrl_arr2{
    if (_imageUrl_arr2 == nil) {
        _imageUrl_arr2 = [NSMutableArray array];
    }
    return _imageUrl_arr2;
    
}
//-(NSMutableArray *)delete_arr{
//    if (_delete_arr == nil) {
//        _delete_arr = [NSMutableArray array];
//    }
//    return _delete_arr;
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/






@end
