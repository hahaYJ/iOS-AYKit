//
//  UIViewController.m
//  AYKit
//
//  Created by hahaYJ on 3/4/16.
//  Copyright © 2016 杨捷. All rights reserved.
//

#import "UIViewController+CommonFunction.h"
#import <objc/runtime.h>

@interface UIViewController ()

@end

@implementation UIViewController (CommonFunction)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(viewDidLoad)), class_getInstanceMethod(self, @selector(ay_viewDidLoad)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(viewDidDisappear:)), class_getInstanceMethod(self, @selector(ay_viewDidDisappear:)));
}

- (void)ay_viewDidLoad {
    [self ay_viewDidLoad];
    [[AYViewControllerProxy obtainProxyWithViewController:self] viewDidLoad];
}

- (void)ay_viewDidDisappear:(BOOL)animated {
    [self ay_viewDidDisappear:animated];
    [AYViewControllerProxy destroyProxy];
}

static const char *AYLaunchPresentView = "launchPresentView";
- (void)setLaunchPresentView:(bool)launchPresentView {
    // 存储新的
    [self willChangeValueForKey:@"launchPresentView"]; // KVO
    objc_setAssociatedObject(self, &AYLaunchPresentView,
                             @(launchPresentView), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"launchPresentView"]; // KVO
}

- (bool)launchPresentView {
    return objc_getAssociatedObject(self, &AYLaunchPresentView);
}


#pragma mark 用于显示空页面
- (void)drawEmptyPage {
    [[AYViewControllerProxy obtainProxyWithViewController:self] drawEmptyPage];
}

- (void)drawEmptyPageForHint:(NSString *)hint {
    [[AYViewControllerProxy obtainProxyWithViewController:self] drawEmptyPageForHint:hint];
}

- (void)removeEmptyPage {
    [[AYViewControllerProxy obtainProxyWithViewController:self] removeEmptyPage];
}

- (void)loadingPage {
    [[AYViewControllerProxy obtainProxyWithViewController:self] loadingPage];
}

- (void)didLoadingPage {
    [[AYViewControllerProxy obtainProxyWithViewController:self] didLoadingPage];
}




- (void)setNavBtnTitleWithLeft:(NSString *)left andLeftAction:(void(^)(id i))leftBlock right:(NSString *)right andRightAction:(void(^)(id i))rightBlock {
    [[AYViewControllerProxy obtainProxyWithViewController:self] setNavBtnTitleWithLeft:left andLeftAction:leftBlock right:right andRightAction:rightBlock];
}

@end
