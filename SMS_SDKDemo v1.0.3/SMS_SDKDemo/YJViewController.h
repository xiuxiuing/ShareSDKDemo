//
//  YJViewController.h
//  SMS_SDKDemo
//
//  Created by 严军 on 14-6-27.
//  Copyright (c) 2014年 严军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SMS_SDK/SMS_SDKResultHanderDef.h>

@interface YJViewController : UIViewController

@property(nonatomic,strong)  UIButton* friends;

@property(nonatomic,strong)  UIButton* registerUserBtn;

-(void)registerUser;

-(void)getAddressBookFriends;

@property(nonatomic,strong) ShowNewFriendsCountBlock friendsBlock;

@end
