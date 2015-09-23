//
//  MbzReleaseListViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "MbzReleaseListViewController.h"

@interface MbzReleaseListViewController ()

@end

@implementation MbzReleaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)performSearchWithText:(NSString *)text {
    ListViewDataLoader *dataLoader = [ListViewDataLoader dataLoaderForSearchWithEntity:MbzEntity_Release query:text];
    self.dataLoader = dataLoader;
    [dataLoader reload];
}

@end
