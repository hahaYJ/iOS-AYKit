//
//  AYViewControllerProxy.h
//  AYKit
//
//  Created by hahaYJ on 3/4/16.
//  Copyright © 2016 杨捷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AYConstant.h"
#import "UIViewController+CommonFunction.h"

@interface AYViewControllerProxy : NSObject

@property (nonatomic, weak) UIViewController *outViewController;

+ (AYViewControllerProxy *)obtainProxyWithViewController:(UIViewController *) outViewController;
+ (void)destroyProxy;

- (void)viewDidLoad;
//- (void)viewDidLoadWillInSuper;

#pragma mark 用于显示空页面
- (void)drawEmptyPage;
- (void)drawEmptyPageForHint:(NSString *)hint;
- (void)removeEmptyPage;
- (void)loadingPage;
- (void)didLoadingPage;

@end
