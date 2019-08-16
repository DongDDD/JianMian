//
//  JMTaskSeachViewController.m
//  JMian
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskSeachViewController.h"
#import "SearchView.h"

@interface JMTaskSeachViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)SearchView *searchView;

@end

@implementation JMTaskSeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.searchView];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - textField -
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(didInputKeywordWithStr:)]) {
        [_delegate didInputKeywordWithStr:textField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

#pragma mark - getter -

-(SearchView *)searchView{
    if (_searchView == nil) {
        _searchView = [[SearchView alloc]initWithFrame:CGRectMake(20,10, SCREEN_WIDTH-40, 33)];
        _searchView.searchTextField.placeholder = @"请输入职位名称";
        _searchView.searchTextField.delegate = self;
        [self.view addSubview:self.searchView];
    }
    return _searchView;
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
