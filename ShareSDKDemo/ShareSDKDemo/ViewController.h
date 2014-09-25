//
//  ViewController.h
//  ShareSDKDemo
//
//  Created by Mac_PC on 14-8-21.
//  Copyright (c) 2014年 H0meDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

@class AppDelegate;
@interface ViewController : UIViewController<ISSShareViewDelegate>{
     AppDelegate *_appDelegate;
}
- (IBAction)click:(id)sender;

- (IBAction)loginClick:(id)sender;

- (IBAction)exitClick:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *MessageClick;
- (IBAction)message:(id)sender;

@end
