//
//  ViewController.m
//  ShareSDKDemo
//
//  Created by Mac_PC on 14-8-21.
//  Copyright (c) 2014年 H0meDev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://open.weibo.com/apps/"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:self
                                                       authManagerViewDelegate:self];
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"内容分享"
                                        
                                                              oneKeyShareList:[NSArray defaultOneKeyShareList]
                                        
                                                               qqButtonHidden:YES
                                        
                                                        wxSessionButtonHidden:YES
                                        
                                                       wxTimelineButtonHidden:YES
                                        
                                                         showKeyboardOnAppear:NO
                                        
                                                            shareViewDelegate:self
                                        
                                                          friendsViewDelegate:self
                                        
                                                        picViewerViewDelegate:nil];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions: shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                    //获取用户信息
                                    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                        if (result) {
                                             NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[userInfo sourceData]];
                                            
                                        }
                                    }];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

- (IBAction)loginClick:(id)sender {
    [ShareSDK authWithType:ShareTypeSinaWeibo                                              //需要授权的平台类型
                   options:nil                                          //授权选项，包括视图定制，自动授权
                    result:^(SSAuthState state, id<ICMErrorInfo> error) {       //授权返回后的回调方法
                        if (state == SSAuthStateSuccess)
                        {
                            NSLog(@"登陆成功");
                        }
                        else if (state == SSAuthStateFail)
                        {
                            NSLog(@"失败");
                        }
                    }];
}

- (IBAction)exitClick:(id)sender {
   [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
   
}

-(void)reloadStateWithType:(ShareType)type{
    //现实授权信息，包括授权ID、授权有效期等。
    //此处可以在用户进入应用的时候直接调用，如授权信息不为空且不过期可帮用户自动实现登录。
    id<ISSPlatformCredential> credential = [ShareSDK getCredentialWithType:type];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
                                                        message:[NSString stringWithFormat:
                                                                 @"uid = %@\ntoken = %@\nsecret = %@\n expired = %@\nextInfo = %@",
                                                                 [credential uid],
                                                                 [credential token],
                                                                 [credential secret],
                                                                 [credential expired],
                                                                 [credential extInfo]]
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType{
   // [viewController.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
   // [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"heeh.jpg"] forBarMetrics:UIBarMetricsDefault];
    [viewController.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}
@end
