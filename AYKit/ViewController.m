//
//  ViewController.m
//  AYKit
//
//  Created by hahaYJ on 3/4/16.
//  Copyright © 2016 杨捷. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%d", self.launchPresentView);
    self.launchPresentView = YES;
    NSLog(@"%d", self.launchPresentView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
