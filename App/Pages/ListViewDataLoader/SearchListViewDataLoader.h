//
//  SearchListViewDataLoader.h
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-29.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "ListViewDataLoader.h"

@interface SearchListViewDataLoader : ListViewDataLoader

@property (nonatomic,readonly) NSString *query;

- (instancetype)initWithEntity:(NSString *)entity query:(NSString *)query;

@end
