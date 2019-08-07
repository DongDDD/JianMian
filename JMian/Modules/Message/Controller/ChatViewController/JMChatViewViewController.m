//
//  JMChatViewViewController.m
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChatViewViewController.h"
#import <TIMManager.h>
#import <TIMMessage.h>
#import <IMMessageExt.h>
#import "JMMessageTableViewController.h"
#import "JMInputTextView.h"
#import "JMMessageCell.h"
#import "JMGreetView.h"
#import "JMGreetTableViewController.h"
#import "JMInputController.h"
#import "DimensMacros.h"
#import "THDatePickerView.h"
#import "JMHTTPManager+InterView.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMVideoChatView.h"


@interface JMChatViewViewController () <JMInputTextViewDelegate,JMMessageTableViewControllerDelegate,JMInputControllerDelegate,THDatePickerViewDelegate,JMVideoChatViewDelegate,UIImagePickerControllerDelegate, UIDocumentPickerDelegate>

@property (nonatomic ,strong) JMMessageTableViewController *messageController;
@property (nonatomic ,strong) JMInputController *inputController;
@property (nonatomic ,strong) JMInputTextView *inputView;
@property (nonatomic ,strong) TIMConversation *conv;

@property (nonatomic, strong) NSArray *childVCs;

//@property (nonatomic ,strong) JMGreetView *greetView;
@property (nonatomic, assign)BOOL isDominator;

@property (weak, nonatomic) THDatePickerView *dateView;
@property (strong, nonatomic) UIButton *BgBtn;//点击背景  隐藏时间选择器
@property (strong, nonatomic) JMVideoChatView *videoChatView;

@end

@implementation JMChatViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    if (model.user_id == _myConvModel.sender_user_id) {
        self.title = _myConvModel.recipient_nickname;
        
    }else{
        self.title = _myConvModel.sender_nickname;

    
    }
    [self setupViews];
    [self initDatePickerView];

//
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewMessage:) name:Notification_JMMMessageListener object:nil];

}

-(void)fanhui{
//    if (_delegate && [_delegate respondsToSelector:@selector(didReadActionWithData:)]) {
//        [_delegate didReadActionWithData:_myConvModel];
//    }
    [super fanhui];
}

-(void)setReadMessageAction_model:(JMMessageListModel *)_myModel{
    
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    //判断senderid是不是自己
    BOOL _isSelfIsSender = [model.user_id isEqualToString: _myModel.sender_user_id];
    NSString *_receiverID;
    //先判断是否系统消息
    if ([_myModel.data.convId isEqualToString:@"dominator"]) {
        _receiverID = @"dominator";
    }else{
        if (_isSelfIsSender) {
            
            _receiverID = _myModel.recipient_mark;
        }else{
            
            _receiverID = _myModel.sender_mark;
        }
    }
    
    _conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_receiverID];
    [_conv setReadMessage:nil succ:^{
        NSLog(@"已读上报");

        //            !_didReadMessage ? : _didReadMessage(_myModel.data.unRead);
        
    } fail:^(int code, NSString *msg) {
        NSLog(@"已读上报失败");
        
    }];
    
    
}
//-(void)onNewMessage:(NSArray *)msgs{
//
//
//
//}

- (void)setupViews{
    //input
 
    _messageController = [[JMMessageTableViewController alloc] init];
    _messageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TTextView_Height - Bottom_SafeHeight);;
    _messageController.delegate = self;

    [self addChildViewController:_messageController];
    [self.view addSubview:_messageController.view];
    [_messageController setMyConvModel:_myConvModel];
    [_messageController setConversation:_conv];

    if (!_isDominator) {
        //        不是系统消息才有输入框
        _inputController = [[JMInputController alloc] init];
        _inputController.view.frame = CGRectMake(0, _messageController.view.frame.size.height - TTextView_Height - Bottom_SafeHeight-20, self.view.frame.size.width,_messageController.view.frame.size.height - TTextView_Height - Bottom_SafeHeight);
        _inputController.delegate = self;
        NSLog(@"*******%f",Bottom_SafeHeight);
        [self addChildViewController:_inputController];
        [self.view addSubview:_inputController.view];
    }else{
        self.title = @"系统消息";
        _messageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
}

-(void)initDatePickerView
{
    self.BgBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    self.BgBtn.backgroundColor = [UIColor blackColor];
    self.BgBtn.hidden = YES;
    self.BgBtn.alpha = 0.3;
    [self.view addSubview:self.BgBtn];
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, SCREEN_WIDTH, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    //    dateView.isSlide = NO;
    //    dateView.date = @"2017-03-23 12:43";
    //    dateView.minuteInterval = 1;
    [self.view addSubview:dateView];
    self.dateView = dateView;
    
}
#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    //    self.timerLbl.text = timer;
    
    self.BgBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
    NSString *userId;
//    if (self.messageController.isSelfIsSender) {
//        userId = self.myConvModel.recipient_user_id;
//    }else{
//        userId = self.myConvModel.sender_user_id;
//    }
    [[JMHTTPManager sharedInstance]createInterViewWith_user_job_id:self.myConvModel.job_user_job_id time:timer successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邀请成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
/**
 时间选择取消
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    self.BgBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}
#pragma mark - JMInputControllerDelegate

- (void)inputController:(JMInputController *)inputController didSendMessage:(JMMessageCellData *)msg
{
   
    [_messageController sendMessage:msg];

}

- (void)inputController:(JMInputController *)inputController didChangeHeight:(CGFloat)height
{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect msgFrame = ws.messageController.view.frame;
        msgFrame.size.height = ws.view.frame.size.height - height;
        ws.messageController.view.frame = msgFrame;
        CGRect inputFrame = ws.inputController.view.frame;
        inputFrame.origin.y = msgFrame.origin.y + msgFrame.size.height;
        inputFrame.size.height = height;
        ws.inputController.view.frame = inputFrame;

    } completion:nil];
    
}

- (void)inputController:(JMInputController *)inputController didSelectMoreCell:(JMMoreCollectionViewCell *)cell{
    if ([cell.titleLabel.text isEqualToString:@"拍照"]) {
        NSLog(@"拍照");

    }
    if ([cell.titleLabel.text isEqualToString:@"相册"]) {
        NSLog(@"相册");
        [self selectPhotoForSend];
    }
}



#pragma mark - JMMessageTableViewControllerDelegate

//视频面试邀请
-(void)videoInterviewController:(JMMessageTableViewController *)controller{
    if ([_myConvModel.type isEqualToString:@"2"]) {
        
        [self gotoVideoChatViewWithForeign_key:_myConvModel.work_task_id recipient:_myConvModel.job_user_user_id chatType:@"2"];
     
    }else if ([_myConvModel.type isEqualToString:@"1"]) {
        
        self.BgBtn.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
            [self.dateView show];
        }];
        
        
       
    }
    

}

- (void)didTapInMessageController:(JMMessageTableViewController *)controller
{
    [_inputController reset];
}

- (void)isDominatorController:(JMMessageTableViewController *)controller{
    _isDominator = YES;
}

- (void)sendImageMessage:(UIImage *)image;
{
    [_messageController sendImageMessage:image];
}

//- (void)sendVideoMessage:(NSURL *)url
//{
//    [_messageController sendVideoMessage:url];
//}
//
//- (void)sendFileMessage:(NSURL *)url
//{
//    [_messageController sendFileMessage:url];
//}

- (void)sendGreetAction:(NSInteger *)index{
  
//    [_inputView setChildVC:self.childVCs];

//    [_inputView setCurrentIndex:0];


//    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.view).offset(-211);
//        make.left.mas_equalTo(self.view);
//        make.right.mas_equalTo(self.view);
//        make.height.mas_equalTo(60);
//    }];

    
}

- (void)selectPhotoForSend
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)takePictureForSend
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraCaptureMode =UIImagePickerControllerCameraCaptureModePhoto;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 快速点的时候会回调多次
    picker.delegate = nil;
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImageOrientation imageOrientation = image.imageOrientation;
            if(imageOrientation != UIImageOrientationUp)
            {
                CGFloat aspectRatio = MIN ( 1920 / image.size.width, 1920 / image.size.height );
                CGFloat aspectWidth = image.size.width * aspectRatio;
                CGFloat aspectHeight = image.size.height * aspectRatio;
                
                UIGraphicsBeginImageContext(CGSizeMake(aspectWidth, aspectHeight));
                [image drawInRect:CGRectMake(0, 0, aspectWidth, aspectHeight)];
                image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            
            [self sendImageMessage:image];
        }
        else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
            NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
//            [self sendVideoMessage:url];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -  （自定义消息 兼职视频邀请)

-(void)gotoVideoChatViewWithForeign_key:(NSString *)foreign_key
                              recipient:(NSString *)recipient
                               chatType:(NSString *)chatType{
    _videoChatView = [[JMVideoChatView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    _videoChatView.delegate = self;
    _videoChatView.tag = 222;
    [_videoChatView createChatRequstWithForeign_key:foreign_key recipient:recipient chatType:chatType];
    //    [_videoChatView setInterviewModel:nil];
    [self.view addSubview:_videoChatView];
    [self.navigationController setNavigationBarHidden:YES];
}
//JMVideoChatViewDelegate 挂断
-(void)hangupAction_model:(JMInterViewModel *)model{
    
    
    [self.navigationController setNavigationBarHidden:NO];
    
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
