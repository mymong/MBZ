//
//  HomeController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-21.
//  Copyright © 2015年 nero. All rights reserved.
//

#import "HomeController.h"
#import "ListViewController.h"
#import "ArtistListViewController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSearchControllerWillPresent:) name:@"willPresentSearchController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSearchControllerWillDismiss:) name:@"willDismissSearchController" object:nil];
}

- (void)loadViewControllersForTabBarController:(UITabBarController *)tabBarController {
    /* Artist */ {
        UIViewController *viewController = [ArtistListViewController new];
        viewController.title = @"Artist";
        [tabBarController addChildViewController:viewController];
    }
    
    /* Release */ {
        ListViewController *viewController = [ListViewController loadFromStoryboard];
        viewController.title = @"Release";
        viewController.view.backgroundColor = [UIColor greenColor];
        [tabBarController addChildViewController:viewController];
        
        viewController.dataLoader = [ListViewDataLoader dataLoaderForSearchWithEntity:@"artist" query:@"abc"];
        [viewController.dataLoader reload];
    }
    
    /* Recording */ {
        UIViewController *viewController = [UIViewController new];
        viewController.title = @"Recording";
        viewController.view.backgroundColor = [UIColor yellowColor];
        [tabBarController addChildViewController:viewController];
    }
    
    /* Work */ {
        UIViewController *viewController = [UIViewController new];
        viewController.title = @"Work";
        viewController.view.backgroundColor = [UIColor brownColor];
        [tabBarController addChildViewController:viewController];
    }
    
    /* Label */ {
        UIViewController *viewController = [UIViewController new];
        viewController.title = @"Label";
        viewController.view.backgroundColor = [UIColor grayColor];
        [tabBarController addChildViewController:viewController];
    }
    
    [super loadViewControllersForTabBarController:tabBarController];
}

- (void)onSearchControllerWillPresent:(NSNotification *)notification {
    self.segmentsBar.locked = YES;
}

- (void)onSearchControllerWillDismiss:(NSNotification *)notification {
    self.segmentsBar.locked = NO;
}

@end
