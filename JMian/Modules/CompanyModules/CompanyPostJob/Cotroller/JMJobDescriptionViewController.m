//
//  JMJobDescriptionViewController.m
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMJobDescriptionViewController.h"
#import "JMTitlesView.h"

@interface JMJobDescriptionViewController ()

@property (nonatomic, strong) JMTitlesView *titleView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic , strong) UITextField *textField;



@end

@implementation JMJobDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"职位描述"];
    [self setRightBtnTextName:@"保存"];
    
    [self.view addSubview:self.titleView];
    [self setTextFieldUI];
    
}

-(void)setTextFieldUI{
    self.textField = [[UITextField alloc]init];
    self.textField.placeholder = @"填写岗位职责、任职要求等（3000字以内），清晰的 描述有助于更好的展开招聘，例如：\n 岗位职责 1, ... 2, ... 3, ... \n 任职要求 1, ... 2, ... 3, ...";
    
    [self.view addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.titleView.mas_bottom).offset(20);
        make.height.mas_equalTo(300);
    }];


}


- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"清空文本", @"描述推荐"]];
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
        };
    }
    
    return _titleView;
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
