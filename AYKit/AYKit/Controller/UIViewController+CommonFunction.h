//
//  UIViewController.h
//  AYKit
//
//  Created by hahaYJ on 3/4/16.
//  Copyright © 2016 杨捷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AYViewControllerProxy.h"

@interface UIViewController (CommonFunction)

@property (nonatomic, assign) bool launchPresentView;

#pragma mark 用于显示空页面
- (void)drawEmptyPage;
- (void)drawEmptyPageForHint:(NSString *)hint;
- (void)removeEmptyPage;
- (void)loadingPage;
- (void)didLoadingPage;

@end
