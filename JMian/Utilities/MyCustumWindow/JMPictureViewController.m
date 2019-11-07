//
//  JMPictureViewController.m
//  JMian
//
//  Created by mac on 2019/11/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPictureViewController.h"


@interface JMPictureViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation JMPictureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
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
