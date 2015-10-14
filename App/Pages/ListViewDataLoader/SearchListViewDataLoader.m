//
//  SearchListViewDataLoader.m
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-29.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "SearchListViewDataLoader.h"
#import "MbzApi+WebServiceSearch.h"
#import "MbzDataLifeSpan.h"

@interface SearchListViewDataLoader ()
@property (nonatomic,readonly) NSMutableArray *items;
@property (nonatomic) NSNumber *offset; // nil means would: load the first page; or refresh; or reload.
@property (nonatomic) BOOL canLoadMore;
@end

@implementation SearchListViewDataLoader

- (instancetype)initWithEntity:(NSString *)entity query:(NSString *)query limit:(NSNumber *)limit {
    NSParameterAssert(entity && query);
    if (self = [super initWithEntity:entity]) {
        _query = query;
        _limit = (limit.unsignedIntegerValue == 0 || limit.unsignedIntegerValue > 100) ? @(100) : limit;
        
        ListViewDataSection *section = [ListViewDataSection new];
        section.items = _items = [NSMutableArray new];
        [self.sections removeAllObjects];
        [self.sections addObject:section];
    }
    return self;
}

- (void)load {
    [self load:NO];
}

- (void)reload {
    [self load:YES];
}

#pragma mark -

- (void)load:(BOOL)isReload {
    NSParameterAssert([NSThread currentThread] == [NSThread mainThread]);
    
    if ([self willLoad]) {
        if (isReload) {
            self.offset = nil;
        }
        
        __weak __typeof(self) wself = self;
        NSString *entity = self.entity;
        NSString *query = self.query;
        NSNumber *offset = self.offset;
        NSNumber *limit = self.limit;
        
        dispatch_async(self.loadingQueue, ^{
            if (wself) {
                MbzApi *api = [MbzApi sharedApi];
                [api search:entity string:query conditions:nil offset:offset limit:limit completion:^(MbzResponse *response) {
                    [wself didLoadWithResponse:response];
                }];
            }
        });
    }
}

- (void)didLoadWithJSONObject:(id)object {
    if (![object isKindOfClass:NSDictionary.class]) {
        [super didLoadWithJSONObject:object];
        return;
    }
    
    NSArray *items = [self itemsWithEntitiesInResponseDictionary:object];
    if (!items) {
        [super didLoadWithJSONObject:object];
        return;
    }
    
    __weak __typeof(self) wself = self;
    dispatch_sync(dispatch_get_main_queue(), ^{
        BOOL isReload = wself.offset ? NO : YES;
        if (isReload) {
            [wself.items removeAllObjects];
        }
        
        NSRange items_range = NSMakeRange(wself.items.count, items.count);
        [wself.items addObjectsFromArray:items];
        
        wself.offset = @(wself.items.count);
        wself.canLoadMore = (items.count == wself.limit.unsignedIntegerValue);
        
        if (isReload) {
            [wself didFinishLoading:NSDate.date];
            [wself.delegate listViewDataLoaderDidReload:wself];
        }
        else {
            [wself didFinishLoading:nil];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:items_range];
            [wself.delegate listViewDataLoader:wself didLoadItemsAtIndexSet:indexSet inSection:0];
        }
    });
}

#pragma mark -

- (NSString *)keyOfResponseEntities {
    return [self.entity stringByAppendingString:@"s"];
}

- (NSArray *)itemsWithEntitiesInResponseDictionary:(NSDictionary *)dic {
    NSString *key = [self keyOfResponseEntities];
    NSArray *entityDicArray = dic[key];
    
    if (![entityDicArray isKindOfClass:NSArray.class]) {
        return nil;
    }
    
    NSMutableArray *items = [NSMutableArray new];
    for (NSDictionary *entityDic in entityDicArray) {
        if ([entityDic isKindOfClass:NSDictionary.class]) {
            id item = [self itemWithEntityDictionary:entityDic];
            if (item) {
                [items addObject:item];
            }
        }
    }
    return items;
}

- (ListViewDataItem *)itemWithEntityDictionary:(NSDictionary *)dic {
    ListViewDataItem *item = [ListViewDataItem new];
    item.entity = self.entity;
    item.detail = dic;
    
    NSMutableArray *keysExcludedForSubtitleBuilding = [NSMutableArray arrayWithObjects:@"score", nil];
    
    id value = dic[@"id"];
    if ([value isKindOfClass:NSString.class]) {
        item.mbid = value;
        [keysExcludedForSubtitleBuilding addObject:@"id"];
    }
    
    for (NSString *key in @[@"name", @"title"]) {
        value = dic[key];
        if ([value isKindOfClass:NSString.class]) {
            item.title = value;
            [keysExcludedForSubtitleBuilding addObject:key];
            break;
        }
    }
    
    if (!item.subtitle) {
        NSMutableArray *strs = [NSMutableArray new];
        NSMutableDictionary *mdic = dic.mutableCopy;
        [mdic removeObjectsForKeys:keysExcludedForSubtitleBuilding];
        [mdic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:NSString.class]) {
                [strs addObject:obj];
            }
            else if ([obj isKindOfClass:NSDictionary.class]) {
                NSString *str = [self summaryForDataType:key withDataDictionary:obj];
                if (str.length > 0) {
                    [strs addObject:str];
                }
            }
        }];
        item.subtitle = [strs componentsJoinedByString:@", "];
    }
    return item;
}

- (NSString *)summaryForDataType:(NSString *)type withDataDictionary:(NSDictionary *)dic {
    if ([type isEqualToString:@"life-span"]) {
        MbzDataLifeSpan *span = [[MbzDataLifeSpan alloc] initWithDictionary:dic];
        return span.description;
    }
    
    for (NSString *key in @[@"name", @"title"]) {
        NSString *value = dic[key];
        if ([value isKindOfClass:NSString.class]) {
            return value;
        }
    }
    
    return nil;
}

@end
