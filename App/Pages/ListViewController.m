//
//  ListViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "ListViewController.h"
#import "MbzApi+WebServiceSearch.h"

#import "LookupListViewDataLoader.h"
#import "BrowseListViewDataLoader.h"
#import "DetailListViewDataLoader.h"

@interface ListViewController ()
@property (nonatomic,readonly) NSString *defaultCellIdentifier;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _defaultCellIdentifier = @"defaultCellIdentifier";
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:self.defaultCellIdentifier];
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

- (void)listViewDataLoader:(ListViewDataLoader *)dataLoader didReload:(NSError *)error {
    NSParameterAssert(self.dataLoader == dataLoader);
    if (error) {
        NSLog(@"%@", error);
    }
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.defaultCellIdentifier forIndexPath:indexPath];
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
        
        ListViewController *viewController = [ListViewController new];
        if (viewController) {
            ListViewDataLoader *dataLoader = [[DetailListViewDataLoader alloc] initWithEntity:item.entity detail:item.detail];
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
        
        ListViewController *viewController = [ListViewController new];
        if (viewController) {
            ListViewDataLoader *dataLoader = [[LookupListViewDataLoader alloc] initWithEntity:item.entity mbid:item.mbid];
            viewController.dataLoader = dataLoader;
            [dataLoader reload];
            dispatch_async(dispatch_get_main_queue(), ^{
                [navigationController pushViewController:viewController animated:YES];
            });
        }
    }
}

@end
