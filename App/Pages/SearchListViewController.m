//
//  SearchListViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "SearchListViewController.h"
#import "SearchListViewDataLoader.h"

@interface SearchListViewSearchController : UISearchController
@property (nonatomic) UIViewController *configViewController;
@end

@interface SearchListViewController ()
@property (nonatomic) SearchListViewSearchController *searchController;
@end

@implementation SearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *resultsController = [UITableViewController new];
    resultsController.view.backgroundColor = [UIColor greenColor];
    
    self.searchController = [[SearchListViewSearchController alloc] initWithSearchResultsController:nil];
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    [self.searchController.searchBar sizeToFit];
    
    if (self.shouldShowSearchBar) {
        self.tableView.tableHeaderView = self.searchController.searchBar;
    }
}

- (void)setSearchEnabled:(BOOL)shouldShowSearchBar {
    if (_shouldShowSearchBar != shouldShowSearchBar) {
        self.tableView.tableHeaderView = shouldShowSearchBar ? self.searchController.searchBar : nil;
        _shouldShowSearchBar = shouldShowSearchBar;
    }
}

- (void)performSearchWithText:(NSString *)text {
    ListViewDataLoader *dataLoader = [[SearchListViewDataLoader alloc] initWithEntity:self.searchEntity query:text];
    self.dataLoader = dataLoader;
    [dataLoader reload];
}

#pragma mark <UISearchControllerDelegate>

- (void)willPresentSearchController:(UISearchController *)searchController {
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    UIViewController *configViewController = [UITableViewController new];
    configViewController.view.backgroundColor = [UIColor greenColor];
    
    ((SearchListViewSearchController *)searchController).configViewController = configViewController;
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // TODO
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self performSearchWithText:searchBar.text];
    
    searchBar.placeholder = [NSString stringWithFormat:@"Search: %@", searchBar.text];
    searchBar.text = nil;
    
    self.searchController.active = NO;
}

@end

@implementation SearchListViewSearchController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.active && self.configViewController) {
        CGRect barFrame = [self.view convertRect:self.searchBar.frame fromView:self.searchBar.superview];
        CGFloat barBottom = barFrame.origin.y + barFrame.size.height;
        self.configViewController.view.frame = CGRectMake(barFrame.origin.x, barBottom, barFrame.size.width, self.view.bounds.size.height - barBottom);
    }
}

- (void)setConfigViewController:(UIViewController *)configViewController {
    if (_configViewController != configViewController) {
        if (_configViewController) {
            [_configViewController.view removeFromSuperview];
            [_configViewController removeFromParentViewController];
        }
        if (configViewController) {
            [self addChildViewController:configViewController];
            [self.view addSubview:configViewController.view];
            [self.view setNeedsLayout];
        }
        _configViewController = configViewController;
    }
}

@end
