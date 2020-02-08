//
//  APIStringMacros.h
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#ifndef APIStringMacros_h
#define APIStringMacros_h

#ifdef DEBUG
//Debug状态下的测试API
#define API_BASE_URL_STRING     @"http://app.jmzhipin.com/"
//#define API_BASE_URL_STRING     @"http://produce.jmzhipin.com/"

//app
#else
//Release状态下的线上API
#define API_BASE_URL_STRING     @"http://www.companydomain.com/api/"

#endif
//身份切换
#define User_Change @"api/user/change"
//退出登录
#define logout_URL @"api/logout"
//C端接口
#define Login_URL @"api/login"
//发送验证码
#define Login_Captcha_URL @"sms/captcha"
#define User_info_URL @"api/user/info"
#define Update_info_URL @"api/user/update"
#define Position_label_URL @"labels"
#define City_List_URL @"city/lists"

//上传图片
#define Uploads_Image_URL @"file/uploads"
//身份证识别
#define Ocr_idcard_URL @"api/tools/ocr/idcard"


//个人简历
#define Create_Vita_URL @"api/vita/create"
#define Update_Vita_URL @"api/vita/update"

//简历分页
#define Paginate_Vita_URL @"api/vita/paginate"

//简历详情
#define Info_Vita_URL @"api/vita/info"
#define Info_Job_URL @"api/job/info"

//岗位
#define Update_job_URL @"api/user/job/update"
#define Add_Job_URL @"api/user/job/create"
#define Delete_Job_URL @"api/user/job/delete"

//工作经历
#define Create_Experience_URL @"api/user/experience/create"
#define Update_Experience_URL @"api/user/experience/update"
#define Delete_Experience_URL @"api/user/experience/delete"

//教育经历
#define Create_EducationExperience_URL @"api/education/create"
#define Update_EducationExperience_URL @"api/education/update"
#define Delete_EducationExperience_URL @"api/education/delete"
//全职
#define Paginate_Work_URL @"api/work/paginate"
#define Create_Work_URL @"api/work/create"
#define Update_Work_URL @"api/work/update"
#define Delete_Work_URL @"api/work/delete"

//C端看公司的职位详情
#define Info_Work_URL @"api/work/info"
//活动专题
#define Special_Activity_URL @"special/info/job_fair"

//B端接口
#define Create_Company_URL @"api/company/create"
#define Fectch_CompanyInfo_URL @"api/company/info"
#define Paginate_Vita_URL @"api/vita/paginate"

#define Update_CompanyInfo_URL @"api/company/update"
#define Update_JobInfo_URL @"api/work/update"
//删除公司文件
#define CompanyFile_Delete_URL @"api/company/file/delete"

#define Create_Interview_URL @"api/work/interview/create"

#define List_Interview_URL @"api/work/interview/lists"
#define Update_Interview_URL @"api/work/interview/update"
#define Feedback_Interview_URL @"api/work/interview/feedback"

//苹果内购
#define ApplyPay_Notify_URL @"api/payment/notify/apple"

//收藏
#define Create_Favorite_URL @"api/user/favorite"
#define List_Favorite_URL @"api/user/favorite/paginate"
#define Delete_Favorite_URL @"api/user/favorite/delete"
//兼职简历增删改查
#define Create_Ability_URL @"api/ability/create"
#define Fectch_Ability_URL @"api/ability/paginate"
#define Update_Ability_URL @"api/ability/update"
#define Fectch_AbilityInfo_URL @"api/ability/info"
#define Delete_AbilityVita_URL @"api/ability/delete"
//兼职简历28
#define Fectch_TaskAbility_URL @"api/user/ability"

//删除兼职简历图片
#define Delete_AbilityImage_URL @"api/ability/delete/file"
//第二版任务
#define Fectch_TaskList_URL @"api/task/paginate"
//招募任务增删改查
#define Create_Task_URL @"api/task/create"
#define Delete_Task_URL @"api/task/delete"
#define Update_Task_URL @"api/task/update"
#define Fectch_TaskInfo_URL @"api/task/info"
#define Delete_GoodsImage_URL @"api/task/delete/file"

//发票信息
#define Fectch_InvoiceInfo_URL @"api/user/invoice"
//C端评价
#define Fectch_CommentList_URL @"api/task/comment/paginate"

//C端我的任务
#define Fectch_TaskOrderList_URL @"api/task/order/paginate"
#define Fectch_TaskOrderInfo_URL @"api/task/order/info"
//C端申请兼职任务
#define Create_TaskOrder_URL @"api/task/order/create"
//模拟付款
#define Pay_Money_URL @"api/payment/notify/wechat"

//改变任务状态
#define Change_TaskOrderStatus_URL @"api/task/order/status"
//创建任务评价
#define Create_TaskComment_URL @"api/task/comment/create"
//付款信息
#define Fectch_OrderPayment_URL @"api/order/payment"
//订单
#define Fectch_OrderList_URL @"api/order/paginate"
//物流信息
#define Create_LogisticsInfo_URL @"api/order/logistics"
//订单状态
#define Change_OrderStatus_URL @"api/order/update"
//
#define Update_ShopInfo_URL @"api/shop/update"
//
#define Fectch_GoodsMangerList_URL @"//manager/goods"



//视频列表
#define Fectch_VideoList_URL @"api/video/lists"
//播放次数记录
#define Record_VideoLook_URL @"api/look/file"

//明细
#define Fectch_MoneyDetails_URL @"api/user/money/details"
#define Fectch_WalletDetails_URL @"api/user/wallet/details"
//提现
#define Money_Withdraw_URL @"api/user/money/withdraw"
//好友列表
#define Get_FriendList_URL @"api/friend/lists"
#define Add_Friend_URL @"api/friend/create"
#define Delete_Friend_URL @"api/friend/delete"
#define Search_Friend_URL @"api/friend/search"

//会话列表
#define Chat_List_URL @"converse/lists"
//创建会话
#define Create_Chat_URL @"converse/create"
//常用语
#define Fetch_GreetList_URL @"api/greet/paginate"
#define Create_Greet_URL @"api/greet/create"
#define Delete_Greet_URL @"api/greet/delete"
//未读通知（小程序用）
#define Unread_Notice_URL @"unread/notice"

//模版
#define Fectch_TplList_URL @"tpl/paginate"

//银行卡
#define Fetch_BankCardList_URL @"api/bank/card/lists"
#define Create_BankCard_URL @"api/bank/card/create"
#define Delete_BankCard_URL @"api/bank/card/delete"
//获取系统标签
#define Delete_BankCard_URL @"api/bank/card/delete"
//获取会员协议
#define Fectch_Protocal_URL @"member/contract"
//获取城市ID
#define Get_CityID_URL @"city/location"
//获取客服ID
#define Get_ServiceID_URL @"api/service"
//转账
#define Transfer_Money_URL @"api/user/transfer"
//发布宝贝
#define Get_CategoryList_URL @"api/sort/paginate"
//店铺
#define Get_GoodsList_URL @"api/goods/paginate"
#define Get_ShopInfo_URL @"api/shop"
#define Get_GoodsInfo_URL @"api/goods/info"


//接口
#define Get_Labels_URL @"/labels"
//版本号
#define Get_VersionInfo_URL @"version/info"


#define GET_CONTENT_DETAIL      @"channel/getContentDetail" //获取内容详情(含上一个和下一个)

#define GET_COMMENT_LIST        @"comment/getCommentList"   //获取评论列表

#define COMMENT_LOGIN           @"comment/login"            //获取评论列表

#define COMMENT_PUBLISH         @"comment/publish"          //发布评论

#define COMMENT_DELETE          @"comment/delComment"       //删除评论

#define LOGINOUT                @"common/logout"            //登出


#endif /* APIStringMacros_h */
