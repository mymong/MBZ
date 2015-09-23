//
//  MbzArtistSearchListViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "MbzArtistSearchListViewController.h"

@interface MbzArtistSearchListViewController ()

@end

@implementation MbzArtistSearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)performSearchWithText:(NSString *)text {
    ListViewDataLoader *dataLoader = [ListViewDataLoader dataLoaderForSearchWithEntity:@"artist" query:text];
    self.dataLoader = dataLoader;
    [dataLoader reload];
}

@end
