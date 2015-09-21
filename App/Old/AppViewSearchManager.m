//
//  AppViewSearchManager.m
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/5.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import "AppViewSearchManager.h"
#import "AppViewSearchController.h"

@interface AppViewSearchManager () <UISearchBarDelegate, UISearchControllerDelegate>
@property (nonatomic) AppViewSearchController *searchController;
@end

@implementation AppViewSearchManager

- (instancetype)init {
    if (self = [super init]) {
        self.searchController = [[AppViewSearchController alloc] initWithSearchResultsController:nil];
        self.searchController.delegate = self;
        self.searchController.searchBar.delegate = self;
        [self.searchController.searchBar sizeToFit];
    }
    return self;
}

- (UISearchBar *)searchBar {
    return self.searchController.searchBar;
}

- (void)dismiss {
    [self.searchController dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *entity = self.searchController.params[@"entity"];
    NSString *query  = self.searchController.searchBar.text;
    if (entity && query && self.searchBlock) {
        self.searchBlock(entity, query);
    }
    
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
}

@end
