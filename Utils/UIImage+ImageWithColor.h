//
//  UIImage+ImageWithColor.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/23/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageWithColor)

+ (instancetype)imageWithColor:(UIColor *)color;
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
