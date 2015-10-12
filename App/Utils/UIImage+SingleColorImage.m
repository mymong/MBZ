//
//  UIImage+SingleColorImage.m
//  Stash
//
//  Created by Jason Yang on 15-09-18.
//  Copyright © 2015年 nero. All rights reserved.
//

#import "UIImage+SingleColorImage.h"

@implementation UIImage (SingleColorImage)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
