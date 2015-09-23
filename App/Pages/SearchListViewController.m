//
//  SearchListViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "SearchListViewController.h"

@interface SearchListViewController ()
@property (nonatomic) UISearchController *searchController;
@end

@implementation SearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

#pragma mark to be overriden

- (void)performSearchWithText:(NSString *)text {
    NSLog(@"to perform search: %@", text);
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
    [self performSearchWithText:searchBar.text];
    
    searchBar.placeholder = [NSString stringWithFormat:@"Search: %@", searchBar.text];
    searchBar.text = nil;
    
    self.searchController.active = NO;
}

@end
