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

+(void)load {
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(viewDidLoad)), class_getInstanceMethod(self, @selector(ay_viewDidLoad)));
}

-(void)ay_viewDidLoad {
    [self ay_viewDidLoad];
    [[AYViewControllerProxy obtainProxyWithViewController:self] viewDidLoad];
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

@end
