//
//  AppViewSearchController.m
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/5.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import "AppViewSearchController.h"
#import "AppViewSearchParamsController.h"

@interface AppViewSearchController ()
@property (nonatomic) AppViewSearchParamsController *paramsController;
@end

@implementation AppViewSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    self.paramsController = [AppViewSearchParamsController loadFromStoryboard];
    
    [self addChildViewController:self.paramsController];
    [self.view addSubview:self.paramsController.view];
    
    CGRect barFrame = self.searchBar.frame;
    CGRect viewFrame = self.view.frame;
    
    CGRect frame = CGRectZero;
    frame.origin = CGPointMake(0, barFrame.origin.y + barFrame.size.height);
    frame.size = CGSizeMake(viewFrame.size.width, viewFrame.size.height - frame.origin.y);
    self.paramsController.view.frame = frame;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.paramsController.view removeFromSuperview];
    [self.paramsController removeFromParentViewController];
    self.paramsController = nil;
}

- (NSDictionary *)params {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    NSString *entity = self.paramsController.selectedEntity;
    if (entity) {
        params[@"entity"] = entity;
    }
    
    return params;
}

@end
