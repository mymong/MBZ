//
//  DetailListViewDataLoader.h
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-29.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "ListViewDataLoader.h"

@interface DetailListViewDataLoader : ListViewDataLoader

@property (nonatomic,readonly) NSDictionary *detail;

- (instancetype)initWithEntity:(NSString *)entity detail:(NSDictionary *)detail;

@end
