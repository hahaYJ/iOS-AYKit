//
//  AYViewControllerProxy.m
//  AYKit
//
//  Created by hahaYJ on 3/4/16.
//  Copyright © 2016 杨捷. All rights reserved.
//

#import "AYViewControllerProxy.h"

static AYViewControllerProxy *_global_proxy;
static dispatch_once_t onceDispatchProccess;

@interface AYViewControllerProxy ()

@end

@implementation AYViewControllerProxy

+ (AYViewControllerProxy *)obtainProxyWithViewController:(UIViewController *) outViewController {
    dispatch_once(&onceDispatchProccess, ^{
        _global_proxy = [[AYViewControllerProxy alloc] init];
        _global_proxy.outViewController = outViewController;
    });
    return _global_proxy;
}

+ (void)destroyProxy {
    onceDispatchProccess = 0;
    _global_proxy = nil;
}

//- (void)viewDidLoadWillInSuper {
//    NSLog(@"AYViewDidLoadWillInSuper");
//}

- (void)viewDidLoad {
    [self initNavigationBar];
}

#pragma mark - 导航栏设置
- (void)initNavigationBar {
    _outViewController.navigationController.navigationBar.translucent = NO;
    //修改导航条背景色（themeColor）
    _outViewController.navigationController.navigationBar.barTintColor = AYNavigationBar_barTintColor;
    //修改导航条标题颜色
    [_outViewController.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    //修改导航条添加的按钮（item）颜色(黄色)
    _outViewController.navigationController.navigationBar.tintColor = AYNavigationBar_tintColor;
    // 修改状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    _outViewController.view.backgroundColor = AYViewController_backgroundColor;
    
    // 判断是否启动模态
    if(_outViewController.launchPresentView) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                             target:nil action:nil];
        negativeSpacer.width = -15; // it was -6 in iOS 6, iOS 7 -16
        UIButton *retreatButton = [UIButton buttonWithType: UIButtonTypeCustom];
        retreatButton.frame = CGRectMake(0, 0, 44, 44);
        retreatButton.backgroundColor = [UIColor clearColor];
        retreatButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [retreatButton setTitle:@"关闭" forState:UIControlStateNormal];
        [retreatButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        retreatButton.restorationIdentifier = @"retreatText";
        
        [_outViewController.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:retreatButton], nil] animated:NO];
        [retreatButton addTarget:_outViewController action:@selector(retreatButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
    }
    
    // 设置返回箭头的样式
    _outViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [_outViewController.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

-(void)retreatButtonPressed:(id)sender {
    if (_outViewController.launchPresentView) {
        [_outViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else {
        [_outViewController.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark 用于显示空页面
- (void)drawEmptyPage {
    [self drawEmptyPageForHint:@"亲，暂无数据哟~"];
}

- (void)drawEmptyPageForHint:(NSString *)hint {
    UILabel *txt = [UILabel new];
    txt.text = hint;
    txt.textAlignment = NSTextAlignmentCenter;
    txt.tag = 1111530;
    txt.font = [UIFont systemFontOfSize:15];
    txt.translatesAutoresizingMaskIntoConstraints = NO;
    [_outViewController.view addSubview:txt];
    
    //水平方向上，logoImageView左侧与父视图左侧对齐，logoImageView右侧与父视图右侧对齐
    [_outViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[txt]|" options:0 metrics:nil views:@{@"txt": txt}]];
    //垂直方向上，logoImageView顶部与父视图顶部对齐，logoImageView底部与scrollView顶部对齐，scrollView底部与父视图底部对齐
    [_outViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[txt]|" options:0 metrics:nil views:@{@"txt": txt}]];
}

- (void)removeEmptyPage {
    UIView *txt = [_outViewController.view viewWithTag:1111530];
    if(txt)
        [txt removeFromSuperview];
}

- (void)loadingPage {
    UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    testActivityIndicator.center = CGPointMake(_outViewController.view.center.x, _outViewController.view.center.y - 50);//只能设置中心，不能设置大小
    [testActivityIndicator startAnimating]; // 开始旋转
    testActivityIndicator.tag = 3838383838438;
    [_outViewController.view addSubview:testActivityIndicator];
}

- (void)didLoadingPage {
    UIActivityIndicatorView *testActivityIndicator = [_outViewController.view viewWithTag:3838383838438];
    if(testActivityIndicator) {
        [testActivityIndicator removeFromSuperview];
    }
}

@end
