//
//  LHTitlesView.m
//  JMian
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTitlesView.h"
#import "Masonry.h"

@interface JMTitlesView ()

@property (nonatomic, strong) NSArray *titles;
/** 所有按钮的数组 */
@property (nonatomic ,strong) NSMutableArray<UIButton *> *titleBtns;
// 记录上一个选中按钮
@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation JMTitlesView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        
        [self setupInit];
    }
    return self;
}

- (void)setCurrentTitleIndex:(NSInteger)index {
    [self selectTitleButton:self.titleBtns[index]];
}

- (void)titleClick:(UIButton *)button {
    // 0.获取角标
    NSInteger i = button.tag;
    
    !self.didTitleClick ? : self.didTitleClick(i);
    // 1.让标题按钮选中
    [self selectTitleButton:button];
}

- (void)selectTitleButton:(UIButton *)btn {
    // 恢复上一个按钮颜色
    [_selectButton setTitleColor:TEXT_GRAY_COLOR forState:UIControlStateNormal];
    
    // 设置当前选中按钮的颜色
    [btn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    
    // 记录当前选中的按钮
    _selectButton = btn;
}

- (void)setupInit {
    CGFloat btnW = self.frame.size.width / self.titles.count;
    CGFloat btnH = self.frame.size.height;
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx;
        btn.frame = (CGRect) {btnW * idx, 0, btnW, btnH};
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:TEXT_GRAY_COLOR forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
        if (!idx) {
            [self titleClick:btn];
        }
        
        [self addSubview:btn];
        [self.titleBtns addObject:btn];
        UIView *shuXian = [[UIView alloc]init];
        shuXian.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [self addSubview:shuXian];
        [shuXian mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(1);
                make.height.mas_equalTo(19);
                make.centerY.mas_equalTo(self);
                make.left.mas_equalTo(btn);
        }];
            
    }];
    
    UIView * xian1View = [[UIView alloc]init];
    xian1View.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self addSubview:xian1View];
    
    [xian1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.mas_top);
    }];
    
    
    UIView * xian2View = [[UIView alloc]init];
    xian2View.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self addSubview:xian2View];
    
    [xian2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self);
    }];
    
    
}

#pragma mark - 懒加载
- (NSMutableArray<UIButton *> *)titleBtns {
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

@end
