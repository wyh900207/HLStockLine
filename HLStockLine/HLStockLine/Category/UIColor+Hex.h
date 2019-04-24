//
//  UIColor+Hex.h
//  OrangeTaoJin
//
//  Created by wyh on 2019/4/8.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HexColor(hex_string) [UIColor colorWithHexString:hex_string]

@interface UIColor (Hex)

+ (instancetype)colorWithHexString:(NSString *)hexStr;
+ (instancetype)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

@end
