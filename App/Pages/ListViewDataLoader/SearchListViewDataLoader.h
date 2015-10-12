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
@property (nonatomic,readonly) NSNumber *limit;
@property (nonatomic,readonly) NSDate *refreshDate;
@property (nonatomic,readonly) BOOL canLoadMore;
- (instancetype)initWithEntity:(NSString *)entity query:(NSString *)query limit:(NSNumber *)limit;
- (void)reload;
@end
