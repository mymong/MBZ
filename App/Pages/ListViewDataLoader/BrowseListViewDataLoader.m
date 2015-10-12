//
//  BrowseListViewDataLoader.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-29.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "BrowseListViewDataLoader.h"
#import "MbzApi+WebServiceBrowse.h"

@implementation BrowseListViewDataLoader

- (instancetype)initWithEntity:(NSString *)entity {
    if (self = [super initWithEntity:entity]) {
        
    }
    return self;
}

- (void)reload {
    if ([self willLoad]) {
        __weak __typeof(self) wself = self;
        NSString *entity = self.entity;
        
        dispatch_async(self.loadingQueue, ^{
            if (wself) {
                MbzApi *api = [MbzApi sharedApi];
                [api browse:entity offset:nil limit:nil conditions:nil includes:nil types:nil statuses:nil completion:^(MbzResponse *response) {
                    [wself didLoadWithResponse:response];
                }];
            }
        });
    }
}

@end
