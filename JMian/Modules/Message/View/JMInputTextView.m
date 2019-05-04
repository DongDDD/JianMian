//
//  JMInputTextView.m
//  JMian
//
//  Created by mac on 2019/5/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMInputTextView.h"
#import "DimensMacros.h"
#import "Masonry.h"
#import "JMGreetTableViewController.h"

@interface JMInputTextView()

@property (nonatomic, strong) UIScrollView *contentView;

@end


@implementation JMInputTextView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];

        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)setChildVC:(NSArray *)childVC{
        self.contentView.contentSize = CGSizeMake(1 * self.frame.size.width, 0);
        [self addSubview:self.contentView];
}

- (void)setCurrentIndex:(NSInteger)index {
    UIViewController *VC = self.childVC[index];
    
    JMGreetTableViewController *vc = [[JMGreetTableViewController alloc]init];
    vc.view.backgroundColor = [UIColor yellowColor];
//    if (!VC.view.superview) {
        vc.view.frame = (CGRect){index * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height};
        [self.contentView addSubview:vc.view];
//    }
    [self.contentView setContentOffset:CGPointMake(index * self.frame.size.width, 0) animated:YES];
}
-(void)initView
{
    
    _btn1 = [[UIButton alloc]init];
    _btn1.layer.cornerRadius = 5;
    _btn1.backgroundColor = MASTER_COLOR;
    [_btn1 addTarget:self action:@selector(btn1Action:) forControlEvents:UIControlEventTouchUpInside];
    [_btn1 setTitle:@"常用语" forState:UIControlStateNormal];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_btn1];
    
    _textView = [[UITextView alloc]init];
//    _textView.delegate = self;
    _textView.font = GlobalFont(13);
    _textView.returnKeyType = UIReturnKeySend;//返回键类型
    _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    [self addSubview:_textView];
    
    _btn2 = [[UIButton alloc]init];
    [_btn2 setImage:[UIImage imageNamed:@"expression"] forState:UIControlStateNormal];
    [_btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn2];
    
    _btn3 = [[UIButton alloc]init];
    [_btn3 setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self addSubview:_btn3];
    
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(29);
        make.width.mas_equalTo(55);
    }];
    
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_btn3.mas_left).offset(-15);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(_btn3);
        make.width.mas_equalTo(_btn3);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn1.mas_right).offset(5);
        make.right.mas_equalTo(_btn2.mas_left).offset(5);
        make.height.mas_equalTo(_btn2);
        make.centerY.mas_equalTo(_btn2);
    }];

//    [self greetView];
}

-(void)btn2Action{

    [self.delegate sendMessageWithText:_textView.text];

}

-(void)btn1Action:(UIButton *)btn{
    
    [self.delegate sendGreetAction:btn.tag];
    
}
#pragma mark - lazy

//-(JMGreetView *)greetView{
//    if (_greetView==nil) {
//        _greetView = [[JMGreetView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 211)];
//        _greetView.tableView.backgroundColor = [UIColor redColor];
//        [self addSubview:_greetView];
//
//                [_greetView mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.mas_equalTo(self);
//                    make.right.mas_equalTo(self);
//                    make.top.mas_equalTo(self.mas_bottom);
//                    make.height.mas_equalTo(211);
//                }];
//    }
//    return _greetView;
//}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentView.pagingEnabled = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.delegate = self;
    }
    return _contentView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
