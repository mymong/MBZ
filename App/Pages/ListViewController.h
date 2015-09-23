//
//  ListViewController.h
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewDataLoader.h"

@interface ListViewController : UITableViewController <ListViewDataLoaderDelegate>

@property (nonatomic) ListViewDataLoader *dataLoader;

@end
