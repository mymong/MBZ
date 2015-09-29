//
//  LookupListViewDataLoader.h
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-29.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "ListViewDataLoader.h"

@interface LookupListViewDataLoader : ListViewDataLoader

@property (nonatomic,readonly) NSString *mbid;

- (instancetype)initWithEntity:(NSString *)entity mbid:(NSString *)mbid;

@end
