//
//  ArtistListViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-21.
//  Copyright © 2015年 nero. All rights reserved.
//

#import "ArtistListViewController.h"

@interface ArtistListViewController ()

@end

@implementation ArtistListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)searchWithQuery:(NSString *)query {
    ListViewDataLoader *dataLoader = [ListViewDataLoader dataLoaderForSearchWithEntity:@"artist" query:query];
    self.dataLoader = dataLoader;
    [dataLoader reload];
}

@end
