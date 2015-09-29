//
//  LookupListViewDataLoader.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-29.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "LookupListViewDataLoader.h"
#import "MbzApi+WebServiceLookup.h"

@implementation LookupListViewDataLoader

- (instancetype)initWithEntity:(NSString *)entity mbid:(NSString *)mbid {
    if (self = [super initWithEntity:entity]) {
        _mbid = mbid;
    }
    return self;
}

- (void)reload {
    if ([self willReload]) {
        __weak __typeof(self) wself = self;
        NSString *entity = self.entity;
        NSString *mbid = self.mbid;
        
        dispatch_async(self.loadingQueue, ^{
            if (wself) {
                MbzApi *api = [MbzApi sharedApi];
                [api lookupEntity:entity mbid:mbid subqueries:nil arguments:nil relationships:nil type:nil status:nil completion:^(MbzResponse *response) {
                    [wself didReloadDataWithResponse:response];
                }];
            }
        });
    }
}

@end
