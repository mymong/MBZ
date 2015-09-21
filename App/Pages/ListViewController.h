//
//  ListViewController.h
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/2.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewDataLoader.h"

@interface ListViewController : UITableViewController <ListViewDataLoaderDelegate>

+ (instancetype)loadFromStoryboard;

@property (nonatomic) ListViewDataLoader *dataLoader;

@end
