//
//  JMMineViewController.m
//  JMian
//
//  Created by chitat on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMineViewController.h"
#import "PositionDesiredViewController.h"



@interface JMMineViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testbtn;

@end

@implementation JMMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PositionDesiredViewController *vc = [[PositionDesiredViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
