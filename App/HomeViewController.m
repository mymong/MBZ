//
//  HomeViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "HomeViewController.h"
#import "UISearchController+NavigationItemSearchBar.h"
#import "UIImage+SingleColorImage.h"
#import "HMSegmentedControl.h"
#import "SearchListViewController.h"

@interface HomeViewController () <UISearchControllerDelegate, UISearchBarDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic) NSString *searchText;
@property (nonatomic,readonly) UISearchController *searchController;
@property (nonatomic,readonly) CGFloat heightOfSegmentedControl;
@property (nonatomic,readonly) HMSegmentedControl *segmentedControl;
@property (nonatomic,readonly) UIPageViewController *pageViewController;
@property (nonatomic,readonly) NSArray<UIViewController*> *pages;

@property (nonatomic,readonly) UIColor *barColor;
@property (nonatomic,readonly) UIColor *barDarkColor;
@property (nonatomic,readonly) UIColor *barLightColor;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *(^colorLighter)(UIColor *, CGFloat) = ^UIColor *(UIColor *color, CGFloat coef) {
        CGFloat h, s, b, a;
        [color getHue:&h saturation:&s brightness:&b alpha:&a];
        return [UIColor colorWithHue:h saturation:s brightness:b*coef alpha:a];
    };
    _barColor = self.navigationController.navigationBar.backgroundColor;
    _barDarkColor = colorLighter(self.barColor, 0.8);
    _barLightColor = colorLighter(self.barColor, 1.5);
    
    _searchController = [UISearchController searchControllerWithSearchBarAsTitleViewOfNavigationItem:self.navigationItem withSearchResultsController:nil];
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"Search";
    self.searchController.searchBar.textField.backgroundColor = self.barLightColor;
    self.searchController.searchBar.textField.layer.borderColor = self.barDarkColor.CGColor;
    
    NSMutableArray *pages = [NSMutableArray new];
    NSMutableArray *titles = [NSMutableArray new];
    NSArray *entities = @[MbzEntity_Artist, MbzEntity_Recording, MbzEntity_Release, MbzEntity_ReleaseGroup, MbzEntity_Instrument, MbzEntity_Work, MbzEntity_Label];
    for (NSString *entity in entities) {
        SearchListViewController *viewController = [SearchListViewController loadFromStoryboard];
        viewController.searchEntity = entity;
        [pages addObject:viewController];
        [titles addObject:entity.capitalizedString];
    }
    _pages = pages;
    
    _heightOfSegmentedControl = 28;
    
    CGRect bounds = self.view.bounds;
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:titles];
    self.segmentedControl.frame = CGRectMake(0, 0, bounds.size.width, self.heightOfSegmentedControl);
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.segmentedControl.backgroundColor = self.barColor;
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorColor = [UIColor darkGrayColor];
    [self.segmentedControl addTarget:self action:@selector(onSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@(8.0)}];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.view.backgroundColor = self.barColor;
    self.pageViewController.view.frame = CGRectMake(0, self.heightOfSegmentedControl, bounds.size.width, bounds.size.height - self.heightOfSegmentedControl);
    [self.pageViewController setViewControllers:@[self.pages.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
    
    if (self.navigationController.navigationBar) {
        // remove bottom shadow line of NavigationBar.
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:self.barColor] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    self.segmentedControl.frame = CGRectMake(0, 0, bounds.size.width, self.heightOfSegmentedControl);
    self.pageViewController.view.frame = CGRectMake(0, self.heightOfSegmentedControl, bounds.size.width, bounds.size.height - self.heightOfSegmentedControl);
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
        
        UIViewController *selectedViewController = self.pages[index];
        [self.pageViewController setViewControllers:@[selectedViewController] direction:direction animated:YES completion:nil];
        if ([selectedViewController isKindOfClass:SearchListViewController.class]) {
            SearchListViewController *viewController = (id)selectedViewController;
            [viewController performSearchWithText:self.searchText];
        }
    }
}

#pragma mark <UISearchControllerDelegate>

- (void)willPresentSearchController:(UISearchController *)searchController {
    [UIView animateWithDuration:0.3 animations:^{
        searchController.searchBar.textField.backgroundColor = [UIColor whiteColor];
    } completion:^(BOOL finished) {
        searchController.searchBar.text = self.searchText;
    }];
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    searchController.searchBar.placeholder = self.searchText;
    
    [UIView animateWithDuration:0.3 animations:^{
        searchController.searchBar.textField.backgroundColor = self.barLightColor;
    }];
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchText = searchBar.text;
    
    UIViewController *currentViewController = self.pageViewController.viewControllers.firstObject;
    if ([currentViewController isKindOfClass:SearchListViewController.class]) {
        SearchListViewController *viewController = (id)currentViewController;
        [viewController performSearchWithText:self.searchText];
    }
    
    self.searchController.active = NO;
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
        [self onSegmentChanged:self.segmentedControl];
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
