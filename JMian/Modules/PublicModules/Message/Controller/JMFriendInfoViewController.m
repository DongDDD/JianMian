//
//  JMFriendInfoViewController.m
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMFriendInfoViewController.h"

@interface JMFriendInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation JMFriendInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.nameLab.text = self.model.nickname;
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];

}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];


}
- (IBAction)backAction:(UIButton *)sender {
    [super fanhui];
    
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
