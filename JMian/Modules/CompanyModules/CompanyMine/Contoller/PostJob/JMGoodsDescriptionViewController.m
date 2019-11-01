//
//  JMGoodsDescriptionViewController.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMGoodsDescriptionViewController.h"
#import "JMPartTimeJobResumeFooterView.h"

@interface JMGoodsDescriptionViewController ()<JMPartTimeJobResumeFooterViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *goodsPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *goodsNameTextfield;
@property (weak, nonatomic) IBOutlet UIView *headerDescView;

@property (strong, nonatomic)JMPartTimeJobResumeFooterView *decriptionTextView;

@end

@implementation JMGoodsDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品描述";
    [self setRightBtnTextName:@"保存"];
 
    self.goodsNameTextfield.delegate = self;
    self.goodsPriceTextField.delegate = self;
    [self.goodsNameTextfield setText:_goods_title];
    [self.goodsPriceTextField setText:_goods_price];
    [self.view addSubview:self.decriptionTextView];
    self.decriptionTextView.contentTextView.text = _goods_desc;
        if (_goods_desc.length > 0) {
            self.decriptionTextView.placeHolder.hidden = YES;
        }
    // Do any additional setup after loading the view from its nib.
}


//-(void)setGoodsWithDesc:(NSString *)goods_desc{
//
//
//    if (goods_desc.length > 0) {
//        self.decriptionTextView.placeHolder.hidden = YES;
//    }
//
//}
#pragma mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - myDelegate

 - (void)sendContent:(nonnull NSString *)content {
    self.goods_desc = content;
}

-(void)rightAction{
    [self.goodsNameTextfield resignFirstResponder];
    [self.goodsPriceTextField resignFirstResponder];
    [self.decriptionTextView.contentTextView resignFirstResponder];
    if (_goods_title.length > 30) {
        [self showAlertSimpleTips:@"提示" message:@"商品名称不能超过30个字" btnTitle:@"好的"];
        return;
    }
    if (_goods_title.length > 0 || _goods_price.length > 0 || _goods_desc.length > 0) {
        if(_delegate && [_delegate respondsToSelector:@selector(didWriteGoodsDescWithGoodsName:price:goodsDetaolInfo:)]){
            [_delegate didWriteGoodsDescWithGoodsName:self.goods_title price:self.goods_price goodsDetaolInfo:self.goods_desc];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];

    }
    

}

- (IBAction)rightTextFieldEditingEnd:(UITextField *)sender {
    switch (sender.tag) {
        case 100:
            self.goods_title = sender.text;
            break;
        case 101:
            self.goods_price = sender.text;
            break;
            
        default:
            break;
    }
    
}

-(void)doneClicked{
    [_decriptionTextView.contentTextView resignFirstResponder];
}

#pragma mark - Getter

- (JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, self.headerDescView.frame.origin.y+self.headerDescView.frame.size.height-50, SCREEN_WIDTH, 229);
        _decriptionTextView.delegate = self;
//        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeGoodsDesc];
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _decriptionTextView;
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
