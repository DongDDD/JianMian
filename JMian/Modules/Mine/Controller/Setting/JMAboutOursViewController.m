//
//  JMAboutOursViewController.m
//  JMian
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAboutOursViewController.h"

@interface JMAboutOursViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation JMAboutOursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于平台";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];  
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    _lab.text = app_Version;
    // Do any additional setup after loading the view from its nib.
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
