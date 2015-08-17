//
//  AppViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "AppViewController.h"
#import "AppViewSearchManager.h"
#import "ListViewController.h"
#import "SearchViewController.h"

@interface AppViewController ()
@property (nonatomic) AppViewSearchManager *searchManager;
@property (nonatomic) UISearchController *sc;
@end

@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchManager = [AppViewSearchManager new];
    self.tableView.tableFooterView = self.searchManager.searchBar;
    
    UINavigationController *navigationController = self.navigationController;
//    {
//        UIViewController *vc = [SearchViewController loadFromStoryboard];
//        [navigationController pushViewController:vc animated:YES];
//    }
    
    self.searchManager.searchBlock = ^(NSString *entity, NSString *query) {
        ListViewController *viewController = [ListViewController loadFromStoryboard];
        if (viewController) {
            ListViewDataLoader *dataLoader = [ListViewDataLoader dataLoaderForSearchWithEntity:entity query:query];
            viewController.dataLoader = dataLoader;
            [dataLoader reload];
            dispatch_async(dispatch_get_main_queue(), ^{
                [navigationController pushViewController:viewController animated:YES];
            });
        }
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [self.searchManager.searchBar sizeToFit];
}

@end
