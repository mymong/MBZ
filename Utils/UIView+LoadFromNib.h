//
//  UIView+LoadFromNib.h
//  Common
//
//  Created by Jason Yang on 15/4/17.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LoadFromNib)

+ (id)loadViewFromNib:(NSString *)nibName;

+ (id)loadViewFromNib:(NSString *)nibName inBundle:(NSBundle *)bundle;

+ (id)loadViewFromNib:(NSString *)nibName forClass:(Class)viewClass inBundle:(NSBundle *)bundle;

+ (instancetype)viewFromNib:(NSString *)nibName;

+ (instancetype)viewFromNib:(NSString *)nibName inBundle:(NSBundle *)bundle;

@end
