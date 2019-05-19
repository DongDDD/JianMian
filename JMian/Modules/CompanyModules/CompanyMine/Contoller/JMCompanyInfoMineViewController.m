//
//  JMCompanyInfoMineViewController.m
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyInfoMineViewController.h"
#import "JMHTTPManager+FetchCompanyInfo.h"
#import "JMCompanyInfoModel.h"
#import "JMHTTPManager+Uploads.h"
#import "JMCompanyDesciptionOfMineViewController.h"
#import "JMHTTPManager+CompanyInfoUpdate.h"
#import "DimensMacros.h"

@interface JMCompanyInfoMineViewController ()<UIImagePickerControllerDelegate,UIPickerViewDelegate,JMCompanyDesciptionOfMineViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong)JMCompanyInfoModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UIView *topView;


@property (weak, nonatomic) IBOutlet UILabel *companyNameLab;
@property (weak, nonatomic) IBOutlet UIButton *companyDecriptionBtn;
@property (weak, nonatomic) IBOutlet UILabel *abbrLab;
@property (weak, nonatomic) IBOutlet UIButton *industryBtn;
@property (weak, nonatomic) IBOutlet UIButton *employBtn;
@property (weak, nonatomic) IBOutlet UIButton *facingBtn;
@property (weak, nonatomic) IBOutlet UIView *facingView;

@property (nonatomic,copy)NSString *imageUrl;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(nonatomic,strong) NSArray *pickerArray;
@property (nonatomic,strong)UIButton *selectedBtn;
@property (nonatomic, assign)NSUInteger pickerRow;
@property (weak, nonatomic) IBOutlet UIView *pickerBGView;

@property(nonatomic,strong)JMUserInfoModel *userInfoModel;

@property(nonatomic,assign)BOOL isChange;

@end

@implementation JMCompanyInfoMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"公司信息";
    [self getData];
    self.pickerView.delegate = self;
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerImgAction)];
    [self.topView addGestureRecognizer:tap];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.facingView.frame.origin.y+self.facingView.frame.size.height+50);
    
    
    
}



-(void)getData{
    _userInfoModel = [JMUserInfoManager getUserInfo];
    [[JMHTTPManager sharedInstance]fetchCompanyInfo_Id:_userInfoModel.company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        self.model = [JMCompanyInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        
        [self initView];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


-(void)updateInfoData{
    
    [[JMHTTPManager sharedInstance]updateCompanyInfo_Id:_userInfoModel.company_id company_name:nil nickname:nil abbreviation:nil logo_path:_imageUrl video_path:nil work_time:nil work_week:nil type_label_id:nil industry_label_id:nil financing:self.facingBtn.titleLabel.text employee:self.employBtn.titleLabel.text address:nil url:nil longitude:nil latitude:nil description:self.companyDecriptionBtn.titleLabel.text image_path:nil label_id:nil subway:nil corporate:nil reg_capital:nil reg_date:nil reg_address:nil unified_credit_code:nil business_scope:nil license_path:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"公司信息更新成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
    
}




-(void)initView{
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:self.model.logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.companyNameLab.text = self.model.company_name;
    [self.industryBtn setTitle:self.model.industry_name forState:UIControlStateNormal];
    [self.employBtn setTitle:self.model.employee forState:UIControlStateNormal];
    [self.facingBtn setTitle:self.model.financing forState:UIControlStateNormal];
    self.abbrLab.text = self.model.abbreviation;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.facingView.frame.origin.y+self.facingView.frame.size.height);
}

#pragma mark - 点击事件

-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
    if(_isChange){
        [self updateInfoData];
    }
}

- (IBAction)companyImgAction:(UIButton *)sender {
    
}
- (IBAction)companyDescriptionAction:(UIButton *)sender {
    
    JMCompanyDesciptionOfMineViewController *vc = [[JMCompanyDesciptionOfMineViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)sendTextView_textData:(NSString *)textData{
    if (![self.companyDecriptionBtn.titleLabel.text isEqualToString:textData]) {
        _isChange = YES;
        [self.companyDecriptionBtn setTitle:textData forState:UIControlStateNormal];
        
    }
    
    
}

- (IBAction)industryAction:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"公司行业暂时不提供修改功能"
                                                  delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)employeeAction:(UIButton *)sender {
    [self.pickerBGView setHidden:NO];
    self.pickerArray = [NSArray arrayWithObjects:@"15人以下",@"15～50人",@"50～100人",@"500人以上",nil];
    [self.pickerView reloadAllComponents];
    self.selectedBtn = sender;
}


- (IBAction)financingStep:(UIButton *)sender {
    [self.pickerBGView setHidden:NO];
    self.pickerArray = [NSArray arrayWithObjects:@"天使轮",@"A轮",@"B轮",@"C轮",@"D轮",@"不需要融资",nil];
    [self.pickerView reloadAllComponents];
    self.selectedBtn = sender;
    
}

- (IBAction)pickerOKAction:(UIButton *)sender {
    
    _isChange = YES;
    switch (_selectedBtn.tag) {
        case 1:
            [self.employBtn setTitle:self.pickerArray[_pickerRow] forState:UIControlStateNormal];
            [self.employBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            break;
            
        case 2:
            [self.facingBtn setTitle:self.pickerArray[_pickerRow] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    [self.pickerBGView setHidden:YES];
    
}

- (IBAction)pickerViewDeleteAction:(id)sender {
    [self.pickerBGView setHidden:YES];
}

#pragma mark - pickerViewDelegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _pickerRow = row;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    return [self.pickerArray count];
    
}
//
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [self.pickerArray objectAtIndex:row];
    
    return str;
    
}
#pragma mark - 上传图片

- (void)headerImgAction {
    
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
//#pragma mark -scrollView delegte
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    self.datePicker.hidden = YES;
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
    self.headerImg.image = savedImage;
    
    
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
        
        
        //        if(responsObject[@"data"]){
        //            NSArray *urlArray = responsObject[@"data"];
        //            _imageUrl = urlArray[0];
        //        }
        
        
        _isChange = YES;
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
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
