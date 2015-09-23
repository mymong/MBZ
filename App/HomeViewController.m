//
//  HomeViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "HomeViewController.h"
#import "HMSegmentedControl.h"
#import "SearchListViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet HomeViewSegmentBar *segmentBar;
@property (weak, nonatomic) IBOutlet UIView *tabBarContainer;
@end

@interface HomeViewSegmentBar ()
@property (nonatomic) HMSegmentedControl *segmentedControl;
@property (weak, nonatomic) HomeViewController *viewController;
@property (weak, nonatomic) UITabBarController *tabBarController;
@end

@implementation HomeViewController
{
    UITabBarController *_tabBarController; // override super.tabBarController
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // find embeded TabBarController.
    for (UIViewController *viewController in self.childViewControllers) {
        if ([viewController isKindOfClass:UITabBarController.class]) {
            _tabBarController = (id)viewController;
            [self loadViewControllersForTabBarController:_tabBarController];
            break;
        }
    }
    
    // setup SegmentsView and bind with TabBarController.
    self.segmentBar.viewController = self;
    self.segmentBar.tabBarController = self.tabBarController; // bind TabBarController with SegmentedControl.
    
    if (self.navigationController.navigationBar) {
        // remove bottom shadow line of NavigationBar.
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSearchControllerWillPresent:) name:@"willPresentSearchController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSearchControllerWillDismiss:) name:@"willDismissSearchController" object:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self layoutTabBarContainer];
}

#pragma mark For TabBarController

- (void)layoutTabBarContainer {
    if (!self.navigationController.toolbar || self.navigationController.toolbar.hidden) {
        CGRect frame = self.tabBarContainer.frame;
        frame.size = CGSizeMake(frame.size.width, self.view.bounds.size.height - self.segmentBar.frame.origin.y - self.segmentBar.frame.size.height);
        self.tabBarContainer.frame = frame;
    }
    else {
        CGRect frame = self.tabBarContainer.frame;
        frame.size = CGSizeMake(frame.size.width, self.view.bounds.size.height - self.segmentBar.frame.origin.y - self.segmentBar.frame.size.height - self.navigationController.toolbar.frame.size.height);
        self.tabBarContainer.frame = frame;
    }
}

- (UITabBarController *)tabBarController {
    if (_tabBarController) {
        return _tabBarController;
    }
    return [super tabBarController];
}

- (void)loadViewControllersForTabBarController:(UITabBarController *)tabBarController {
    NSMutableArray *viewControllers = tabBarController.viewControllers.mutableCopy;
    for (NSString *entity in @[MbzEntity_Work, MbzEntity_Label]) {
        SearchListViewController *viewController = [SearchListViewController new];
        viewController.searchEntity = entity;
        [viewControllers addObject:viewController];
    }
    tabBarController.viewControllers = viewControllers;
    
    for (id viewController in tabBarController.viewControllers) {
        if ([viewController isKindOfClass:SearchListViewController.class]) {
            ((SearchListViewController *)viewController).searchEnabled = YES;
        }
    }
    
    UIViewController *firstViewController = tabBarController.viewControllers.firstObject;
    if (firstViewController) {
        [self tabBarController:tabBarController didSelectViewController:firstViewController];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    // TODO
    NSLog(@"didSelectViewController: %@", viewController.title);
}

#pragma mark Notification Receivers

- (void)onSearchControllerWillPresent:(NSNotification *)notification {
    self.segmentBar.segmentedControl.touchEnabled = NO;
}

- (void)onSearchControllerWillDismiss:(NSNotification *)notification {
    self.segmentBar.segmentedControl.touchEnabled = YES;
}

@end

@implementation HomeViewSegmentBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@" "]];
    self.segmentedControl.frame = self.bounds;
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorColor = [UIColor darkGrayColor];
    [self.segmentedControl addTarget:self action:@selector(onSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segmentedControl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.segmentedControl.frame = self.bounds;
}

- (void)setTabBarController:(UITabBarController *)tabBarController {
    if (tabBarController) {
        NSMutableArray *titles = [NSMutableArray new];
        if (tabBarController.tabBar.items.count > 0) {
            for (UITabBarItem *item in tabBarController.tabBar.items) {
                [titles addObject:(item.title ?: @"(?)")];
            }
        }
        else if (tabBarController.childViewControllers.count > 0) {
            for (UIViewController *viewController in tabBarController.childViewControllers) {
                [titles addObject:(viewController.tabBarItem.title ?: (viewController.title ?: @"(?)"))];
            }
        }
        else {
            [titles addObjectsFromArray:@[@"(A)", @"(B)", @"(C)"]];
        }
        self.segmentedControl.sectionTitles = titles;
        if (NSNotFound != tabBarController.selectedIndex) {
            self.segmentedControl.selectedSegmentIndex = tabBarController.selectedIndex;
        }
    }
    _tabBarController = tabBarController;
}

- (void)onSegmentChanged:(HMSegmentedControl *)control {
    UITabBarController *tabBarController = self.tabBarController;
    if (tabBarController.tabBar.items.count > control.selectedSegmentIndex) {
        if (tabBarController.selectedIndex != control.selectedSegmentIndex) {
            tabBarController.selectedIndex = control.selectedSegmentIndex;
            
            [self.viewController tabBarController:tabBarController didSelectViewController:tabBarController.selectedViewController];
        }
    }
}

@end
