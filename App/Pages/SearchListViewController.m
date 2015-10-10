//
//  SearchListViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "SearchListViewController.h"
#import "SearchListViewDataLoader.h"

@interface SearchListViewController ()
@property (nonatomic) NSString *query;
@end

@implementation SearchListViewController

+ (SearchListViewController *)loadFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSString *)defaultCellIdentifier {
    return @"Cell";
}

- (void)performSearchWithText:(NSString *)text {
    if (text.length > 0 && ![self.query isEqualToString:text]) {
        self.query = text;
        
        ListViewDataLoader *dataLoader = [[SearchListViewDataLoader alloc] initWithEntity:self.searchEntity query:self.query];
        self.dataLoader = dataLoader;
        [dataLoader reload];
    }
}

@end
