//
//  JMGoodsDescriptionViewController.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMGoodsDescriptionViewController.h"
#import "JMPartTimeJobResumeFooterView.h"

@interface JMGoodsDescriptionViewController ()<JMPartTimeJobResumeFooterViewDelegate>

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
    [self.view addSubview:self.decriptionTextView];
    
    if (self.goods_title) {
        [self.goodsNameTextfield setText:self.goods_title];
    }
    
    if (self.goods_price) {
        [self.goodsPriceTextField setText:self.goods_title];

    }
    
    if (self.goods_desc) {
        [self.decriptionTextView.contentTextView setText:self.goods_desc];

    }
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - myDelegate

- (void)sendContent:(nonnull NSString *)content {
    self.goods_desc = content;
}

-(void)rightAction{
    if(_delegate && [_delegate respondsToSelector:@selector(didWriteGoodsDescWithGoodsName:price:goodsDetaolInfo:)]){
        [_delegate didWriteGoodsDescWithGoodsName:self.goods_title price:self.goods_price goodsDetaolInfo:self.goods_desc];
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



#pragma mark - Getter

- (JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, self.headerDescView.frame.origin.y+self.headerDescView.frame.size.height , SCREEN_WIDTH, 229);
        _decriptionTextView.delegate = self;
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
