//
//  ListViewController.m
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/2.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import "ListViewController.h"
#import "MbzApi+WebServiceSearch.h"

@interface ListViewController ()

@end

@implementation ListViewController

+ (instancetype)loadFromStoryboard {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass(self.class) bundle:nil];
    id vc = [sb instantiateInitialViewController];
    NSParameterAssert([vc isKindOfClass:self.class]);
    return vc;
}

- (void)setDataLoader:(ListViewDataLoader *)dataLoader {
    if (_dataLoader) {
        _dataLoader.delegate = nil;
    }
    _dataLoader = dataLoader;
    _dataLoader.delegate = self;
}

#pragma mark <ListViewDataLoaderDelegate>

- (void)listViewDataLoaderDidReload:(ListViewDataLoader *)dataLoader {
    NSParameterAssert(self.dataLoader == dataLoader);
    
    [self.tableView reloadData];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataLoader.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ListViewDataSection *sect = self.dataLoader.sections[section];
    return sect.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ListViewDataSection *sect = self.dataLoader.sections[section];
    return sect.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListViewDataSection *sect = self.dataLoader.sections[indexPath.section];
    ListViewDataItem *item = sect.items[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.subtitle;
    
    if (item.mbid && item.detail) {
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    else if (item.mbid) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (item.detail) {
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    ListViewDataSection *sect = self.dataLoader.sections[indexPath.section];
    ListViewDataItem *item = sect.items[indexPath.row];
    
    if (item.detail) {
        UINavigationController *navigationController = self.navigationController;
        
        ListViewController *viewController = [ListViewController loadFromStoryboard];
        if (viewController) {
            ListViewDataLoader *dataLoader = [ListViewDataLoader dataLoaderForDetail:item.detail withEntity:item.entity];
            viewController.dataLoader = dataLoader;
            [dataLoader reload];
            dispatch_async(dispatch_get_main_queue(), ^{
                [navigationController pushViewController:viewController animated:YES];
            });
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListViewDataSection *sect = self.dataLoader.sections[indexPath.section];
    ListViewDataItem *item = sect.items[indexPath.row];
    
    if (item.entity && item.mbid) {
        UINavigationController *navigationController = self.navigationController;
        
        ListViewController *viewController = [ListViewController loadFromStoryboard];
        if (viewController) {
            ListViewDataLoader *dataLoader = [ListViewDataLoader dataLoaderForLookupWithEntity:item.entity mbid:item.mbid];
            viewController.dataLoader = dataLoader;
            [dataLoader reload];
            dispatch_async(dispatch_get_main_queue(), ^{
                [navigationController pushViewController:viewController animated:YES];
            });
        }
    }
}

@end
