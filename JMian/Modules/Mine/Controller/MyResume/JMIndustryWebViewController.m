//
//  JMIndustryWebViewController.m
//  JMian
//
//  Created by mac on 2019/6/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMIndustryWebViewController.h"
#import "JMHTTPManager+GetLabels.h"

@interface JMIndustryWebViewController ()

@end

@implementation JMIndustryWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHTMLPath:@"SecondModulesHTML/C/C-resume_hy.html"];
    // Do any additional setup after loading the view.
    self.title = @"选择行业";
    [self setRightBtnTextName:@"保存"];
    [self showProgressHUD_view:self.view];
}

-(void)rightAction{
        if (self.labsJson) {
            if (_delegate && [_delegate respondsToSelector:@selector(sendlabsWithJson:)]) {
                [_delegate sendlabsWithJson:_labsJson];
            [self.navigationController popViewControllerAnimated:YES];
            
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你没选择好"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }
}


-(void)getData{
    [[JMHTTPManager sharedInstance]getLabels_Id:@"1025" mode:@"tree" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSArray *array = responsObject[@"data"];
            //传数据到H5
            [self ocToJs_arrayData:array selectedLabs:self.labsJson];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
  
}

- (void)ocToJs_arrayData:(NSArray *)arrayData selectedLabs:(NSString *)selectedLabs {
    //OC调用JS
    NSString *jsonLabs;
    if (arrayData.count > 0) {
        jsonLabs = [self arrayToJSONWithArr:arrayData];
    }
    

    NSString *showInfoFromJava = [NSString stringWithFormat:@"showInfoFromJava('%@','%@')",jsonLabs,selectedLabs];
    [self.webView evaluateJavaScript:showInfoFromJava completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        //显示对话框
//        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(hiddenHUD) userInfo:nil repeats:YES];
        [self hiddenHUD];
        //延迟
        NSLog(@"OC调用JS方法 showInfoFromJava ");
    }];
    
}


// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self getData];
    //    [self ocToJs];
}
//被自定义的WKScriptMessageHandler在回调方法里通过代理回调回来，绕了一圈就是为了解决内存不释放的问题
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    //用message.body获得JS传出的参数体
    // NSDictionary * parameter = message.body;
    //JS调用OC
   if([message.name isEqualToString:@"aaa"]){
        self.labsJson = message.body;
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:message.body preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }])];
//        [self presentViewController:alertController animated:YES completion:nil];
    }
    
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
