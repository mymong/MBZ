//
//  MbzRecordingListViewController.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "MbzRecordingListViewController.h"

@interface MbzRecordingListViewController ()

@end

@implementation MbzRecordingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)performSearchWithText:(NSString *)text {
    ListViewDataLoader *dataLoader = [ListViewDataLoader dataLoaderForSearchWithEntity:MbzEntity_Recording query:text];
    self.dataLoader = dataLoader;
    [dataLoader reload];
}

@end
