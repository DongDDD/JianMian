//
//  JMCompanyInfoViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyInfoViewController.h"
#import "JMUploadLicenseViewController.h"
#import "JMHTTPManager+CompanyCreate.h"
#import "JMHTTPManager+Login.h"
#import "JMUserInfoModel.h"
#import "JMHTTPManager+Uploads.h"
#import "JMJudgeViewController.h"
#import "NavigationViewController.h"
#import "LoginViewController.h"
#import "STPickerSingle.h"
#import "JMHTTPManager+GetLabels.h"
#import "JMLabsData.h"
#import "JMGetCompanyLocationViewController.h"


@interface JMCompanyInfoViewController ()<UIPickerViewDelegate,UIScrollViewDelegate,STPickerSingleDelegate,UITextFieldDelegate,JMGetCompanyLocationViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *headerImg;

//@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
//@property(nonatomic,strong) UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *companyNameLab;
@property (weak, nonatomic) IBOutlet UITextField *abbreviationTextField;
@property (weak, nonatomic) IBOutlet UIButton *industryBtn;
@property (weak, nonatomic) IBOutlet UIButton *employeeBtn;
@property (weak, nonatomic) IBOutlet UIButton *financingBtn;
@property (weak, nonatomic) IBOutlet UIButton *adressBtn;

@property(nonatomic,strong) NSMutableArray *industryLabsArray;
@property(nonatomic,strong) NSMutableArray *industryDataArray;
@property(nonatomic,copy) NSString *industry_label_id;

//@property(nonatomic,strong) NSArray *pickerArray;

//@property(nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic, strong)AMapPOI *POIModel;
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,copy)NSString *companyAdressStr;

@property (nonatomic, assign)CGFloat changeHeight;
@property(nonatomic,strong)UIButton *moreBtn;
@property (nonatomic, strong) STPickerSingle *companyIndustryPickerSingle;
@property (nonatomic, strong) STPickerSingle *employeePickerSingle;
@property (nonatomic, strong) STPickerSingle *financingPickerSingle;


@end

@implementation JMCompanyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
//    self.extendedLayoutIncludesOpaqueBars = YES;
    if (self.loginViewType == JMLoginViewTypeNextStep) {
        [self setIsHiddenBackBtn:NO];
    }else if ((self.loginViewType == JMJLoginViewTypeMemory)) {
        [self setIsHiddenBackBtn:YES];
    }
    [self setRightBtnTextName:@"下一步"];
//    self.pickerView.delegate = self;
    [self.scrollView addSubview:self.moreBtn];
//    [self.view addSubview:self.pickerView];
    NSString *company_name = kFetchMyDefault(@"company_name");
      if (company_name == nil) {
          JMUserInfoModel *useModel = [JMUserInfoManager getUserInfo];
          company_name = useModel.company_real_company_name;
      }
    
    self.companyNameLab.text = company_name;
    self.scrollView.delegate = self;
    self.abbreviationTextField.delegate = self;
    [self getLabsData];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    if (model.company_id) {
        [self setComInfoValues];
        
    }
    
}


//-(void)keyboardHide:(UITapGestureRecognizer*)tap{
//    [_abbreviationTextField resignFirstResponder];
////    self.pickerView.hidden = YES;
////    [_bgView setHidden:YES];
//
//    //上移n个单位，按实际情况设置
//    CGRect rect=CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
//    self.view.frame=rect;
//}
#pragma mark - 赋值
-(void)setComInfoValues{
    
    NSString *abbreviation = kFetchMyDefault(@"abbreviation");
    NSString *selectedTitle1 = kFetchMyDefault(@"employee");
    NSString *selectedTitle2 = kFetchMyDefault(@"financing");
    NSString *selectedTitle3 = kFetchMyDefault(@"industry");
    NSString *selectedTitle4 = kFetchMyDefault(@"companyAdress");
    self.companyAdressStr = selectedTitle4;
    
    [self.abbreviationTextField setText:abbreviation];
    [self.employeeBtn setTitle:selectedTitle1 forState:UIControlStateNormal];
    [self.employeeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.financingBtn setTitle:selectedTitle2 forState:UIControlStateNormal];
    [self.financingBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.industryBtn setTitle:selectedTitle3 forState:UIControlStateNormal];
    [self.industryBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.adressBtn setTitle:selectedTitle4 forState:UIControlStateNormal];
    [self.adressBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
   
}


#pragma mark - 点击事件


- (IBAction)industryAction:(UIButton *)sender {
    [self.view addSubview:self.companyIndustryPickerSingle];
    [self.companyIndustryPickerSingle show];
    
    
}

- (IBAction)employeeAction:(UIButton *)sender {

    [self.view addSubview:self.employeePickerSingle];
    [self.employeePickerSingle show];
    [_abbreviationTextField resignFirstResponder];

}


- (IBAction)financingStep:(UIButton *)sender {
    [_abbreviationTextField resignFirstResponder];
    [self.view addSubview:self.financingPickerSingle];
    [self.financingPickerSingle show];
}

- (IBAction)companyAdress:(id)sender {
    JMGetCompanyLocationViewController *vc = [[JMGetCompanyLocationViewController alloc]init];
      vc.delegate = self;
      [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;

}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    kSaveMyDefault(@"abbreviation", textField.text);
    return YES;
}


#pragma mark - Data
-(void)getLabsData{
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]getLabels_Id:@"992" mode:@"tree" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            _industryDataArray = [JMLabsData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        }
        for (JMLabsData *data in _industryDataArray) {
            [self.industryLabsArray addObject:data.name];
        }
        [self hiddenHUD];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

-(void)rightAction{
    if (_imageUrl == nil) {
        [self showAlertSimpleTips:@"提示" message:@"请上传公司logo" btnTitle:@"好的"];
        return;
    }
    if (self.abbreviationTextField.text.length > 10) {
        [self showAlertSimpleTips:@"提示" message:@"公司简称不能超过10个字" btnTitle:@"好的"];
              return;
    }
    NSString *company_name = kFetchMyDefault(@"company_name");
    NSString *company_position = kFetchMyDefault(@"company_position");
    if (company_name == nil ) {
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        company_name = userModel.company_real_company_name;
        company_position = userModel.company_position;
    }
    
    NSString *longitude = [NSString stringWithFormat:@"%f",self.POIModel.location.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f",self.POIModel.location.latitude];
    
    [[JMHTTPManager sharedInstance]createCompanyWithCompany_name:company_name company_position:company_position nickname:nil avatar:nil enterprise_step:@"3" abbreviation:self.abbreviationTextField.text logo_path:self.imageUrl video_path:nil work_time:nil work_week:nil type_label_id:nil industry_label_id:self.industry_label_id financing:self.financingBtn.titleLabel.text employee:self.employeeBtn.titleLabel.text      city_id:nil address:self.companyAdressStr url:nil longitude:longitude latitude:latitude description:nil image_path:nil label_id:nil subway:nil line:nil station:nil corporate:nil reg_capital:nil reg_date:nil reg_address:nil unified_credit_code:nil business_scope:nil license_path:nil status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
    
            JMUploadLicenseViewController *vc = [[JMUploadLicenseViewController alloc]init];
      
            [self.navigationController pushViewController:vc animated:YES];
            kRemoveMyDefault(@"abbreviation");
            kRemoveMyDefault(@"employee");
            kRemoveMyDefault(@"financing");
            kRemoveMyDefault(@"industry");
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {


    }];



}

- (IBAction)headerAction:(id)sender {
    
    //选取照片上传
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
    
}

#pragma mark -Mydelegte
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle row:(NSInteger)row{
    
    if (pickerSingle == _employeePickerSingle) {
        [self.employeeBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.employeeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        kSaveMyDefault(@"employee", selectedTitle);
    }else if(pickerSingle == _financingPickerSingle){
        [self.financingBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.financingBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        kSaveMyDefault(@"financing", selectedTitle);
    }else if(pickerSingle == _companyIndustryPickerSingle){
        [self.industryBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.industryBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        JMLabsData *data = _industryDataArray[row];
        self.industry_label_id = data.label_id;
        kSaveMyDefault(@"industry", selectedTitle);

    }
}

//公司地址回传
-(void)sendAdress_Data:(AMapPOI *)data
{
    self.POIModel = data;
    NSString *adr = [NSString stringWithFormat:@"%@-%@-%@-%@",data.city,data.district,data.name,data.address];
    [self.adressBtn setTitle:adr forState:UIControlStateNormal];
    self.companyAdressStr = adr;
      kSaveMyDefault(@"companyAdress", adr);
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    self.pickerView.hidden = YES;
////    [_abbreviationTextField resignFirstResponder];
//
//}

// 图片选择结束之后，走这个方法，字典存放所有图片信息
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
    
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:@"currentImage.png"];
    //读取路径进行上传
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    
    //图片赋值显示
    [_headerImg setImage:savedImage forState:UIControlStateNormal];
    
    
}

//图频上传

#pragma mark - 保存图片至沙盒（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
    
    NSArray *array = @[currentImage];
    [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            
            _imageUrl = responsObject[@"data"][0];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}

#pragma mark - lazy

-(NSMutableArray *)industryDataArray{
    if (_industryDataArray.count == 0) {
        _industryDataArray = [NSMutableArray array];
    }
    return _industryDataArray;
}

-(NSMutableArray *)industryLabsArray{
    if (_industryLabsArray.count == 0) {
        _industryLabsArray = [NSMutableArray array];
    }
    return _industryLabsArray;
}

-(UIButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,self.adressBtn.frame.origin.y+self.adressBtn.frame.size.height+110, SCREEN_WIDTH, 40)];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];

        [_moreBtn setTitle:@"更多操作" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

-(STPickerSingle *)employeePickerSingle{
    if (_employeePickerSingle == nil) {
        _employeePickerSingle = [[STPickerSingle alloc]init];
        _employeePickerSingle.delegate = self;
        _employeePickerSingle.title = @"人员规模";
        _employeePickerSingle.widthPickerComponent = SCREEN_WIDTH;
        _employeePickerSingle.arrayData = [NSMutableArray arrayWithObjects:@"15人以下",@"15～50人",@"50～100人",@"500人以上",nil];
    }
    return _employeePickerSingle;
}


-(STPickerSingle *)financingPickerSingle{
    if (_financingPickerSingle == nil) {
        _financingPickerSingle = [[STPickerSingle alloc]init];
        _financingPickerSingle.delegate = self;
        _financingPickerSingle.title = @"发展阶段";
        _financingPickerSingle.widthPickerComponent = SCREEN_WIDTH;
        _financingPickerSingle.arrayData = [NSMutableArray arrayWithObjects:@"天使轮",@"A轮",@"B轮",@"C轮",@"D轮",@"不需要融资",nil];
    }
    return _financingPickerSingle;
}


-(STPickerSingle *)companyIndustryPickerSingle{
    if (_companyIndustryPickerSingle == nil) {
        _companyIndustryPickerSingle = [[STPickerSingle alloc]init];
        _companyIndustryPickerSingle.delegate = self;
        _companyIndustryPickerSingle.title = @"公司行业";
        _companyIndustryPickerSingle.widthPickerComponent = SCREEN_WIDTH;
        _companyIndustryPickerSingle.arrayData = self.industryLabsArray;
    }
    return _companyIndustryPickerSingle;
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
