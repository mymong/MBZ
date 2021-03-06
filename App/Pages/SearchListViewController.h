//
//  SearchListViewController.h
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "ListViewController.h"

@interface SearchListViewController : ListViewController

+ (SearchListViewController *)loadFromStoryboard;

@property (nonatomic) NSString *searchEntity;

- (void)performSearchWithText:(NSString *)text;

@end
