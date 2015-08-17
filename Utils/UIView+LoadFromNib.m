//
//  UIView+LoadFromNib.m
//  Common
//
//  Created by Jason Yang on 15/4/17.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import "UIView+LoadFromNib.h"

@implementation UIView (LoadFromNib)

+ (id)loadViewFromNib:(NSString *)nibName {
    return [self loadViewFromNib:nibName forClass:UIView.class inBundle:nil];
}

+ (id)loadViewFromNib:(NSString *)nibName inBundle:(NSBundle *)bundle {
    return [self loadViewFromNib:nibName forClass:UIView.class inBundle:bundle];
}

+ (id)loadViewFromNib:(NSString *)nibName forClass:(Class)viewClass inBundle:(NSBundle *)bundle {
    if (!nibName) {
        nibName = NSStringFromClass(self);
    }
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    NSArray *array = [bundle loadNibNamed:nibName owner:nil options:nil];
    for (id item in array) {
        if ([item isKindOfClass:viewClass]) {
            return item;
        }
    }
    return nil;
}

+ (instancetype)viewFromNib:(NSString *)nibName {
    return [self loadViewFromNib:nibName forClass:self inBundle:nil];
}

+ (instancetype)viewFromNib:(NSString *)nibName inBundle:(NSBundle *)bundle {
    return [self loadViewFromNib:nibName forClass:self inBundle:bundle];
}

@end
