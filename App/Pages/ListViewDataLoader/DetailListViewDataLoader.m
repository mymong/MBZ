//
//  DetailListViewDataLoader.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-29.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "DetailListViewDataLoader.h"

@implementation DetailListViewDataLoader

- (instancetype)initWithEntity:(NSString *)entity detail:(NSDictionary *)detail {
    if (self = [super initWithEntity:entity]) {
        _detail = detail;
    }
    return self;
}

- (void)reload {
    if ([self willLoad]) {
        __weak __typeof(self) wself = self;
        id detail = self.detail;
        
        dispatch_async(self.loadingQueue, ^{
            if (wself) {
                [wself didLoadWithJSONObject:detail];
            }
        });
    }
}

@end
