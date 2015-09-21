//
//  SegmentsController.m
//
//  Created by Jason Yang on 15-09-15.
//  Copyright (c) 2015年 Jason Yang. All rights reserved.
//

#import "SegmentsController.h"
#import "HMSegmentedControl.h"

@interface SegmentsController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *tabBarContainer;
@end

@interface SegmentsBar ()
@property (nonatomic) HMSegmentedControl *segmentedControl;
@property (weak, nonatomic) SegmentsController *ownerController;
@property (weak, nonatomic) UITabBarController *tabBarController;
@end

@implementation SegmentsController
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
    self.segmentsBar.ownerController = self;
    self.segmentsBar.tabBarController = self.tabBarController; // bind TabBarController with SegmentedControl.
    
    if (self.navigationController.navigationBar) {
        // remove bottom shadow line of NavigationBar.
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
    
    if (self.navigationController.toolbar) {
        // observe Toolbar.hidden so that we can correct the view rect of TabBarController.
        [self.navigationController.toolbar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self layoutTabBarContainer];
}

#pragma mark

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"hidden"] && [object isKindOfClass:UIToolbar.class]) {
        [self layoutTabBarContainer];
    }
}

- (void)layoutTabBarContainer {
    if (!self.navigationController.toolbar || self.navigationController.toolbar.hidden) {
        CGRect frame = self.tabBarContainer.frame;
        frame.size = CGSizeMake(frame.size.width, self.view.bounds.size.height - self.segmentsBar.frame.origin.y - self.segmentsBar.frame.size.height);
        self.tabBarContainer.frame = frame;
    }
    else {
        CGRect frame = self.tabBarContainer.frame;
        frame.size = CGSizeMake(frame.size.width, self.view.bounds.size.height - self.segmentsBar.frame.origin.y - self.segmentsBar.frame.size.height - self.navigationController.toolbar.frame.size.height);
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
    UIViewController *firstViewController = tabBarController.viewControllers.firstObject;
    if (firstViewController) {
        [self tabBarController:tabBarController didSelectViewController:firstViewController];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    // TODO
}

@end

@implementation SegmentsBar

- (BOOL)locked {
    return !self.segmentedControl.touchEnabled;
}

- (void)setLocked:(BOOL)locked {
    self.segmentedControl.touchEnabled = !locked;
}

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
            [titles addObject:@"(?)"];
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
            
            [self.ownerController tabBarController:tabBarController didSelectViewController:tabBarController.selectedViewController];
        }
    }
}

@end
