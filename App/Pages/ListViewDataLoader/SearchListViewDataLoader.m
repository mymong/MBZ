//
//  SearchListViewDataLoader.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-29.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "SearchListViewDataLoader.h"
#import "MbzApi+WebServiceSearch.h"

@implementation SearchListViewDataLoader

- (instancetype)initWithEntity:(NSString *)entity query:(NSString *)query {
    if (self = [super initWithEntity:entity]) {
        _query = query;
    }
    return self;
}

- (void)reload {
    if ([self willReload]) {
        __weak __typeof(self) wself = self;
        NSString *entity = self.entity;
        NSString *query = self.query;
        
        dispatch_async(self.loadingQueue, ^{
            if (wself) {
                MbzApi *api = [MbzApi sharedApi];
                [api search:entity string:query conditions:nil offset:nil limit:nil completion:^(MbzResponse *response) {
                    [wself didReloadDataWithResponse:response];
                }];
            }
        });
    }
}

@end
