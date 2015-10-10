//
//  UISearchController+NavigationItemSearchBar.h
//  MusicBrainz
//
//  Created by Jason Yang on 15-10-10.
//  Copyright © 2015年 yg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (NavigationItemSearchBar)
+ (nonnull instancetype)searchBarAsTitleViewOfNavigationItem:(nonnull UINavigationItem *)navigationItem;
@end

@interface UISearchController (NavigationItemSearchBar)
+ (nonnull instancetype)searchControllerWithSearchBarAsTitleViewOfNavigationItem:(nonnull UINavigationItem *)navigationItem withSearchResultsController:(nullable UIViewController *)searchResultsController;
@end
