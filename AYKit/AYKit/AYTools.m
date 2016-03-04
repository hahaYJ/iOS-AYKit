//
//  AYTools.m
//  AYKit
//
//  Created by hahaYJ on 3/4/16.
//  Copyright © 2016 杨捷. All rights reserved.
//

#import "AYTools.h"

@implementation AYTools

+ (void) alert:(NSString *) title message:(NSString *) msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}
//URLEncode
+(NSString*)urlEncodeString:(NSString*)unencodedString{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

//URLDEcode
+ (NSString *)urlDecodeString:(NSString*)encodedString {
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

#pragma mark 底依赖会话管理工具
+ (NSString *) getMemberSessionStr {
    NSString *memberSession = [[NSUserDefaults standardUserDefaults] valueForKey:@"APPDELEGATE_SESSION_STR"];
    return memberSession;
}

+ (void) reloadMemberSessionStr:(NSString *)session {
    [[NSUserDefaults standardUserDefaults] setValue: session forKey: @"APPDELEGATE_SESSION_STR"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) removeMemberSessionStr {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[NSUserDefaults standardUserDefaults] setValue: nil forKey: @"APPDELEGATE_SESSION_STR"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) reloadSimpleData:(id)simpleData key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setValue:simpleData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id) getSimpleData : (NSString *)key {
    id simpleData = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    return simpleData;
}


+ (UITapGestureRecognizer *)bindPressed:(id)targetView meta:(id)meta action:(SEL)action {
    ((UIView *)targetView).userInteractionEnabled = YES;
    
    UITapGestureRecognizer *bind = [[UITapGestureRecognizer alloc] initWithTarget:meta action:action];
    [targetView addGestureRecognizer:bind];
    return bind;
}

@end

@implementation AYTools (UIColorOperate)

+ (UIColor *) stringToColor:(NSString *)str {
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

@end

@implementation AYTools (NSStringOperate)

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL || [@"(null)" isEqualToString:string]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        return YES;
    }
    return NO;
}

@end