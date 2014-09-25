//
//  MJScrollView.m
//  动画和事件综合例子-键盘处理
//
//  Created by mj on 13-4-15.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJScrollView.h"

@interface MJScrollView ()  {
    CGPoint _lastOffset;
}
@end

@implementation MJScrollView
#pragma mark - 生命周期方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initial];
    }
    return self;
}

#pragma mark 当MJScrollView从xib中创建完毕后会调用这个方法
- (void)awakeFromNib {
    [self initial];
}

- (void)dealloc {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 注意：记得要移除
    [center removeObserver:self];
    //[super dealloc];
}

#pragma mark 初始化
- (void)initial {
    self.contentSize = self.bounds.size;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    // 注册键盘显示的通知
    [center addObserver:self selector:@selector(keybordWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 注册键盘隐藏的通知
    [center addObserver:self selector:@selector(keybordWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 键盘显示出来的时候调用
- (void)keybordWillShow:(NSNotification *)notification{
    //NSLog(@"keybordWillShow,%@", notification);
    
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UITextField *textField = [self findFistResponder:self];
    
    // toView用nil值，代表UIWindow
    CGRect convertRect = [textField convertRect:textField.bounds toView:nil];
    
    CGFloat distance = keyboardRect.origin.y - (convertRect.origin.y + convertRect.size.height + 10);
    
    if (distance < 0) { // 说明键盘挡住了文本框
        [self animationWithUserInfo:notification.userInfo block:^{
            CGPoint offset = _lastOffset = self.contentOffset;
            offset.y -= distance;
            self.contentOffset = offset;
        }];
    }
}

#pragma mark 键盘隐藏的时候调用
- (void)keybordWillHide:(NSNotification *)notification {
    [self animationWithUserInfo:notification.userInfo block:^{
        self.contentOffset = _lastOffset;
    }];
}

#pragma mark 抽出一个方法来执行动画
- (void)animationWithUserInfo:(NSDictionary *)userInfo
                        block:(void (^)(void))block {
    // 取出键盘弹出的时间
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 取出键盘弹出的速率节奏
    int curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    
    // 调用block
    block();
    
    [UIView commitAnimations];
}

#pragma mark 递归找出第一响应者
- (UITextField *)findFistResponder:(UIView *)view {
    for (UIView *child in view.subviews) {
        if ([child respondsToSelector:@selector(isFirstResponder)]
            &&
            [child isFirstResponder]) {
            return (UITextField *)child;
        }
        
        UITextField *field = [self findFistResponder:child];
        if (field) {
            return field;
        }
    }
    
    return nil;
}

#pragma mark 监听scrollview点击
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // 退出键盘
    [self endEditing:YES];
}
@end
