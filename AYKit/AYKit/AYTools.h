//
//  AYTools.h
//  AYKit
//
//  Created by hahaYJ on 3/4/16.
//  Copyright © 2016 杨捷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AYTools : NSObject

+ (void) alert:(NSString *) title message:(NSString *) msg;
+ (NSString*)urlEncodeString:(NSString*)unencodedString;
+ (NSString *)urlDecodeString:(NSString*)encodedString;

+ (void) reloadMemberSessionStr:(NSString *)session;
+ (NSString *) getMemberSessionStr;
+ (void) removeMemberSessionStr;
+ (void) reloadSimpleData:(id)simpleData key:(NSString *)key;
+ (id) getSimpleData:(NSString *)key;
+ (UITapGestureRecognizer *)bindPressed:(id)targetView meta:(id)meta action:(SEL)action;

@end

@interface AYTools (UIColorOperate)

+ (UIColor *) stringToColor:(NSString *)str;

@end

@interface AYTools (NSStringOperate)

+ (BOOL) isBlankString:(NSString *)string;

@end