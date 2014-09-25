//
//  YJViewController.m
//  SMS_SDKDemo
//
//  Created by 严军 on 14-6-27.
//  Copyright (c) 2014年 严军. All rights reserved.
//

#import "YJViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "SMS_HYZBadgeView.h"
#import "RegViewController.h"
#import "SectionsViewControllerFriends.h"
#import "SMS_MBProgressHUD+Add.h"
#import <AddressBook/AddressBook.h>

@interface YJViewController ()
{
    SMS_HYZBadgeView* _testView;
    SectionsViewControllerFriends* _friendsController;
}

@end

static UIAlertView* _alert1=nil;

@implementation YJViewController

-(void)registerUser
{
    RegViewController* reg=[[RegViewController alloc] init];
    [self presentViewController:reg animated:YES completion:^{
        
    }];

    
}

-(void)getAddressBookFriends
{
    NSLog(@"show my friends");
    [_testView setNumber:0];
    
    SectionsViewControllerFriends* friends=[[SectionsViewControllerFriends alloc] init];
    _friendsController=friends;
    
    [_friendsController setMyBlock:_friendsBlock];
    
    [SMS_MBProgressHUD showMessag:@"正在加载中..." toView:self.view];
    
    [SMS_SDK getAppContactFriends:1 result:^(enum SMS_ResponseState state, NSArray *array) {
        if (1==state)
        {
            NSLog(@"block 获取好友列表成功");
            
            [_friendsController setMyData:array];
            [self presentViewController:_friendsController animated:YES completion:^{
                            ;
                        }];
                }
        else if(0==state)
        {
            NSLog(@"block 获取好友列表失败");
        }

    }];
    
    //判断用户通讯录是否授权
    if (_alert1) {
        [_alert1 show];
    }
    
    if(ABAddressBookGetAuthorizationStatus()!=kABAuthorizationStatusAuthorized&&_alert1==nil)
    {
        NSString* str=[NSString stringWithFormat:@"您未授权访问联系人，请在【设置>隐私>通讯录】中授权访问，就可以看到通讯录好友了哦"];
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        _alert1=alert;
        [alert show];
    }

    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat statusBarHeight=0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        statusBarHeight=20;
    }
    
    NSLog(@"statusBarHeight:%f",statusBarHeight);
    
    UIButton* regBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    regBtn.frame=CGRectMake(20, 111+statusBarHeight, 280, 40);
    
    [regBtn setTitle:@"注册或绑定手机演示" forState:UIControlStateNormal];
    
    [regBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [regBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* friendsBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    friendsBtn.frame=CGRectMake(20, 170+statusBarHeight, 280, 40);

    [friendsBtn setTitle:@"通讯录好友" forState:UIControlStateNormal];
    
    [friendsBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [friendsBtn addTarget:self action:@selector(getAddressBookFriends) forControlEvents:UIControlEventTouchUpInside];
    
    //创建一个导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0+statusBarHeight, 320, 44)];
    
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //设置导航栏内容
    [navigationItem setTitle:@"ShareSDK"];
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    NSString *icon = [NSString stringWithFormat:@"smssdk.bundle/button5.png"];
    [regBtn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    
    [friendsBtn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    
    SMS_HYZBadgeView* testView=[[SMS_HYZBadgeView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _testView=testView;
    [testView setNumber:0];
    
    [friendsBtn addSubview:testView];
    
    
    _friendsBlock=^(enum SMS_ResponseState state,int latelyFriendsCount)
    {
        if (1==state) {
            NSLog(@"block 新好友数目重新设置");
            int count=latelyFriendsCount;
            [testView setNumber:count];
        }
    };
    
    [SMS_SDK showFriendsBadge:_friendsBlock];
    
    self.view.backgroundColor=[UIColor whiteColor];
    //把导航栏添加到视图中
    [self.view addSubview:navigationBar];
    [self.view addSubview:regBtn];
    [self.view addSubview:friendsBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
