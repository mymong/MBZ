//
//  ListViewDataLoader.m
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/4.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import "ListViewDataLoader.h"
#import "MbzApi+WebServiceSearch.h"
#import "MbzApi+WebServiceLookup.h"
#import "MbzApi+WebServiceBrowse.h"

typedef NS_ENUM(NSInteger, ListViewDataLoaderType) {
    ListViewDataLoaderTypeSearch,
    ListViewDataLoaderTypeLookup,
    ListViewDataLoaderTypeBrowse,
    ListViewDataLoaderTypeDetail,
};

@interface ListViewDataLoader ()
@property (nonatomic,readonly) dispatch_queue_t serialQueue;
@property (nonatomic,readonly) ListViewDataLoaderType type;
@property (nonatomic,readonly) NSString *entity;
@property (nonatomic) NSString *query;
@property (nonatomic) NSString *mbid;
@property (nonatomic) NSDictionary *detail;
@end

@interface ListViewDataSection ()
+ (NSArray *)sectionArrayWithDictionary:(NSDictionary *)dictionary;
@end

@interface ListViewDataItem ()
+ (NSArray *)itemArrayWithObject:(id)object forKey:(id)key;
@end

@implementation ListViewDataLoader

- (instancetype)initWithType:(ListViewDataLoaderType)type entity:(NSString *)entity {
    if (self = [super init]) {
        const char *queueLabel = "ListViewDataLoader serial queue";
        switch (type) {
            case ListViewDataLoaderTypeSearch:
                queueLabel = "ListViewDataLoader serial queue for search";
                break;
            case ListViewDataLoaderTypeLookup:
                queueLabel = "ListViewDataLoader serial queue for search";
                break;
            case ListViewDataLoaderTypeBrowse:
                queueLabel = "ListViewDataLoader serial queue for browse";
                break;
            case ListViewDataLoaderTypeDetail:
                queueLabel = "ListViewDataLoader serial queue for detail";
                break;
        }
        _serialQueue = dispatch_queue_create(queueLabel, DISPATCH_QUEUE_SERIAL);
        _type = type;
        _entity = entity;
    }
    return self;
}

+ (instancetype)dataLoaderForSearchWithEntity:(NSString *)entity query:(NSString *)query {
    ListViewDataLoader *loader = [[ListViewDataLoader alloc] initWithType:ListViewDataLoaderTypeSearch entity:entity];
    loader.query = query;
    return loader;
}

+ (instancetype)dataLoaderForLookupWithEntity:(NSString *)entity mbid:(NSString *)mbid {
    ListViewDataLoader *loader = [[ListViewDataLoader alloc] initWithType:ListViewDataLoaderTypeLookup entity:entity];
    loader.mbid = mbid;
    return loader;
}

+ (instancetype)dataLoaderForBrowseWithEntity:(NSString *)entity {
    ListViewDataLoader *loader = [[ListViewDataLoader alloc] initWithType:ListViewDataLoaderTypeBrowse entity:entity];
    return loader;
}

+ (instancetype)dataLoaderForDetail:(NSDictionary *)detail withEntity:(NSString *)entity {
    ListViewDataLoader *loader = [[ListViewDataLoader alloc] initWithType:ListViewDataLoaderTypeDetail entity:entity];
    loader.detail = detail;
    return loader;
}

- (void)reload {
    if (self.isLoading) {
        return;
    }
    _isLoading = YES;
    
    if (self.type == ListViewDataLoaderTypeDetail) {
        NSArray *sections = [ListViewDataSection sectionArrayWithDictionary:self.detail];
        [self didFinishReloadWithSections:sections error:nil];
        return;
    }
    
    __weak __typeof(self) wself = self;
    void (^completion)(MbzResponse *) = ^(MbzResponse *response) {
        NSArray *sections; NSError *error;
        
        NSDictionary *dic = response.raw.JSONObjectFromData;
        if ([dic isKindOfClass:NSDictionary.class]) {
            sections = [ListViewDataSection sectionArrayWithDictionary:dic];
        }
        else {
            error = response.error;
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [wself didFinishReloadWithSections:sections error:error];
        });
    };
    
    ListViewDataLoaderType type = self.type;
    NSString *entity = self.entity;
    NSString *query = self.query;
    NSString *mbid = self.mbid;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MbzApi *api = [MbzApi sharedApi];
        switch (type) {
            case ListViewDataLoaderTypeSearch:
                [api search:entity string:query conditions:nil offset:nil limit:nil completion:completion];
                break;
            case ListViewDataLoaderTypeLookup:
                [api lookupEntity:entity mbid:mbid subqueries:nil arguments:nil relationships:nil type:nil status:nil completion:completion];
                break;
            case ListViewDataLoaderTypeBrowse:
                [api browse:entity offset:nil limit:nil conditions:nil includes:nil types:nil statuses:nil completion:completion];
                break;
            default:
                completion(nil);
                break;
        }
    });
}

- (void)didFinishReloadWithSections:(NSArray *)sections error:(NSError *)error {
    if (sections) {
        _sections = sections;
        
        id<ListViewDataLoaderDelegate> delegate = self.delegate;
        if (delegate) {
            [delegate listViewDataLoaderDidReload:self];
        }
    }
    
    if (error) {
        NSLog(@"did finish reload with error: %@", error);
    }
    
    _isLoading = NO;
}

@end

#define ShowEmptyItems NO

@implementation ListViewDataSection

+ (NSArray *)sectionArrayWithDictionary:(NSDictionary *)dictionary {
    if (!dictionary) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        ListViewDataSection *section = [ListViewDataSection new];
        section.title = key;
        section.items = [ListViewDataItem itemArrayWithObject:obj forKey:key];
        if (ShowEmptyItems) {
            [array addObject:section];
        }
        else if (section.items.count > 0) {
            [array addObject:section];
        }
    }];
    
    return array;
}

@end

@implementation ListViewDataItem

+ (NSString *)singularNameOf:(NSString *)pluralName {
    // TODO
    // ...
    
    if ([pluralName hasSuffix:@"s"]) {
        return [pluralName substringToIndex:pluralName.length-1];
    }
    
    return pluralName;
}

+ (NSArray *)itemArrayWithObject:(id)object forKey:(NSString *)key {
    if (!object) {
        return nil;
    }
    
    NSMutableArray *items = [NSMutableArray new];
    
    if ([object isKindOfClass:NSArray.class]) {
        key = [ListViewDataItem singularNameOf:key];
        
        for (id child in (NSArray *)object) {
            ListViewDataItem *item = [ListViewDataItem itemWithObject:child forKey:key];
            if (ShowEmptyItems) {
                [items addObject:item];
            }
            else if (item.title.length > 0) {
                [items addObject:item];
            }
        }
    }
    else {
        ListViewDataItem *item = [ListViewDataItem itemWithObject:object forKey:key];
        if (ShowEmptyItems) {
            [items addObject:item];
        }
        else if (item.title.length > 0) {
            [items addObject:item];
        }
    }
    
    return items;
}

+ (instancetype)itemWithObject:(id)object forKey:(NSString *)key {
    ListViewDataItem *item = [ListViewDataItem new];
    
    if ([object isKindOfClass:NSDictionary.class]) {
        item.entity = key;
        item.detail = object;
        
        NSDictionary *dic = object;
        id value;
        
        value = dic[@"name"];
        if (value) {
            item.title = value;
        }
        else {
            item.title = [NSString stringWithFormat:@"TODO: item object as dictionary for keys: %@", dic.allKeys];
        }
        
        value = dic[@"id"];
        if (value) {
            item.mbid = value;
        }
    }
    else if (![object isKindOfClass:NSNull.class]) {
        // TODO
        // ...
        
        item.title = [object description];
    }
    
    return item;
}

@end
