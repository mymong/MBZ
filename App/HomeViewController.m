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

@interface HomeViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic) HMSegmentedControl *segmentedControl;
@property (nonatomic) UIPageViewController *pageViewController;
@property (nonatomic,readonly) NSArray *pages;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *pages = [NSMutableArray new];
    NSMutableArray *titles = [NSMutableArray new];
    NSArray *entities = @[MbzEntity_Artist, MbzEntity_ReleaseGroup, MbzEntity_Release, MbzEntity_Recording, MbzEntity_Instrument, MbzEntity_Work, MbzEntity_Label];
    for (NSString *entity in entities) {
        SearchListViewController *viewController = [SearchListViewController new];
        viewController.searchEntity = entity;
        viewController.shouldShowSearchBar = YES;
        [pages addObject:viewController];
        [titles addObject:entity.capitalizedString];
    }
    _pages = pages;
    
    CGRect bounds = self.view.bounds;
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:titles];
    self.segmentedControl.frame = CGRectMake(0, 0, bounds.size.width, 32);
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorColor = [UIColor darkGrayColor];
    [self.segmentedControl addTarget:self action:@selector(onSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.view.frame = CGRectMake(0, 32, bounds.size.width, bounds.size.height - 32);
    [self.pageViewController setViewControllers:@[self.pages.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
    
    if (self.navigationController.navigationBar) {
        // remove bottom shadow line of NavigationBar.
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    self.segmentedControl.frame = CGRectMake(0, 0, bounds.size.width, 32);
    self.pageViewController.view.frame = CGRectMake(0, 32, bounds.size.width, bounds.size.height - 32);
}

#pragma mark Events

- (void)onSegmentChanged:(HMSegmentedControl *)control {
    NSInteger index = control.selectedSegmentIndex;
    if (index >= 0 && index < self.pages.count) {
        UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
        
        UIViewController *currentViewController = self.pageViewController.viewControllers.firstObject;
        if (currentViewController) {
            NSUInteger currentIndex = [self.pages indexOfObject:currentViewController];
            if (currentIndex != NSNotFound && currentIndex > index) {
                direction = UIPageViewControllerNavigationDirectionReverse;
            }
        }
        
        [self.pageViewController setViewControllers:@[self.pages[index]] direction:direction animated:YES completion:nil];
    }
}

#pragma mark <UIPageViewControllerDelegate>

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    // TODO
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *currentViewController = self.pageViewController.viewControllers.firstObject;
    NSUInteger currentIndex = currentViewController ? [self.pages indexOfObject:currentViewController] : NSNotFound;
    if (currentIndex != NSNotFound) {
        [self.segmentedControl setSelectedSegmentIndex:currentIndex animated:YES];
    }
}

#pragma mark <UIPageViewControllerDataSource>

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [self.pages indexOfObject:viewController];
    if (currentIndex != NSNotFound && currentIndex > 0) {
        return self.pages[currentIndex - 1];
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [self.pages indexOfObject:viewController];
    if (currentIndex != NSNotFound && currentIndex + 1 < self.pages.count) {
        return self.pages[currentIndex + 1];
    }
    return nil;
}

@end
