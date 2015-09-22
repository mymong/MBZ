//
//  PageListViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-21.
//  Copyright © 2015年 nero. All rights reserved.
//

#import "PageListViewController.h"

@interface PageListViewController ()
@property (nonatomic) UISearchController *searchController;
@end

@implementation PageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableFooterView = self.searchController.searchBar;
}

#pragma mark to be overriden

- (void)searchWithQuery:(NSString *)query {
    NSLog(@"to search: %@", query);
}

#pragma mark <UISearchControllerDelegate>

- (void)willPresentSearchController:(UISearchController *)searchController {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"willPresentSearchController" object:self userInfo:@{@"UISearchController":searchController}];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"willDismissSearchController" object:self userInfo:@{@"UISearchController":searchController}];
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchWithQuery:searchBar.text];
    
    searchBar.placeholder = searchBar.text;
    searchBar.text = nil;
    
    self.searchController.active = NO;
}

@end
