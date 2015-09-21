//
//  SegmentsController.h
//
//  Created by Jason Yang on 15-09-15.
//  Copyright (c) 2015年 Jason Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentsBar : UIView

@property (nonatomic) BOOL locked;

@end

@interface SegmentsController : UIViewController

@property (weak, nonatomic) IBOutlet SegmentsBar *segmentsBar;

- (void)loadViewControllersForTabBarController:(UITabBarController *)tabBarController;

@end
