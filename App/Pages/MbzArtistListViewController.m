//
//  MbzArtistListViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "MbzArtistListViewController.h"
#import "SearchListViewDataLoader.h"

@interface MbzArtistListViewController ()

@end

@implementation MbzArtistListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)performSearchWithText:(NSString *)text {
    ListViewDataLoader *dataLoader = [[SearchListViewDataLoader alloc] initWithEntity:MbzEntity_Artist query:text];
    self.dataLoader = dataLoader;
    [dataLoader reload];
}

@end
