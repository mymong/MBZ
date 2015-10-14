//
//  ListViewDataLoader.m
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/4.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import "ListViewDataLoader.h"
#import "MbzDataLifeSpan.h"

@interface ListViewDataLoader ()
@property (nonatomic) BOOL isLoading;
@property (nonatomic) NSDate *loadedDate;
@end

@implementation ListViewDataLoader

- (instancetype)initWithEntity:(NSString *)entity {
    if (self = [super init]) {
        _entity = entity;
        _sections = [NSMutableArray new];
        
        NSString *loadingQueueName = [NSString stringWithFormat:@"LoadingQueue of \"%@\" for Entity \"%@\"", NSStringFromClass(self.class), entity];
        _loadingQueue = dispatch_queue_create(loadingQueueName.UTF8String, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)load {
    NSAssert(NO, @"Must be overriden!");
}

- (BOOL)willLoad {
    if (self.isLoading) {
        return NO;
    }
    else {
        self.isLoading = YES;
        return YES;
    }
}

- (void)didFinishLoading:(NSDate *)date {
    self.isLoading = NO;
    if (date && ![self.loadedDate isEqualToDate:date]) {
        self.loadedDate = date;
    }
}

- (void)didLoadWithResponse:(MbzResponse *)response {
    NSError *error = response.raw.error;
    if (error) {
        [self.delegate listViewDataLoader:self didLoadFailedWithError:error];
        return;
    }
    
    id json = [response.raw JSONObjectFromData:&error];
    if (error) {
        [self.delegate listViewDataLoader:self didLoadFailedWithError:error];
        return;
    }
    
    [self didLoadWithJSONObject:json];
}

- (void)didLoadWithJSONObject:(id)object {
    NSArray *sections = [self sectionsWithObject:object];
    
    __weak __typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong __typeof(wself) sself = wself; if (sself) {
            if (sections.count > 0) {
                [sself.sections addObjectsFromArray:sections];
            }
            
            [sself didFinishLoading:NSDate.date];
            
            if (sself.delegate) {
                [sself.delegate listViewDataLoaderDidReload:sself];
            }
        }
    });
}

- (void)didLoadFailedWithError:(NSError *)error {
    __weak __typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong __typeof(wself) sself = wself; if (sself) {
            [sself didFinishLoading:nil];
            
            if (sself.delegate) {
                [sself.delegate listViewDataLoader:sself didLoadFailedWithError:error];
            }
        }
    });
}

#pragma mark -

- (NSArray *)sectionsWithObject:(id)object {
    if ([object isKindOfClass:NSDictionary.class]) {
        return [self sectionsWithDictionary:object];
    }
    
    NSArray *items = [self itemsWithObject:object type:self.entity];
    if (items) {
        if (items.count > 0) {
            ListViewDataSection *section = [ListViewDataSection new];
            section.items = items;
            return @[section];
        }
        else {
            return @[];
        }
    }
    
    return nil;
}

- (NSArray *)sectionsWithDictionary:(NSDictionary *)dictionary {
    if (dictionary) {
        NSMutableArray *sections = [NSMutableArray new];
        for (NSString *key in [self allSortedKeysOfDictionary:dictionary ascending:YES]) {
            id object = dictionary[key];
            NSArray *items = [self itemsWithObject:object type:key];
            if (items.count > 0) {
                ListViewDataSection *section = [ListViewDataSection new];
                section.title = key;
                section.items = items;
                [sections addObject:section];
            }
        }
        return sections;
    }
    return nil;
}

- (NSArray *)itemsWithObject:(id)object type:(NSString *)type {
    if ([object isKindOfClass:NSArray.class]) {
        type = [self singularNameOf:type];
        return [self itemsWithArray:object type:type];
    }
    
    id item = [self itemWithObject:object type:type];
    if (item) {
        return @[item];
    }
    
    return nil;
}

- (NSArray *)itemsWithArray:(NSArray *)array type:(NSString *)type {
    if (array) {
        NSMutableArray *items = [NSMutableArray new];
        for (id object in array) {
            id item = [self itemWithObject:object type:type];
            if (item) {
                [items addObject:item];
            }
        }
        return items;
    }
    return nil;
}

- (NSArray *)itemsWithDictionary:(NSDictionary *)dictionary type:(NSString *)type {
    if (dictionary) {
        NSMutableArray *items = [NSMutableArray new];
        for (NSString *key in [self allSortedKeysOfDictionary:dictionary ascending:YES]) {
            id object = dictionary[key];
            id item = [self itemWithObject:object type:key];
            if (item) {
                [items addObject:item];
            }
        }
        return items;
    }
    return nil;
}

- (ListViewDataItem *)itemWithObject:(id)object type:(NSString *)type {
    if (!object) {
        return nil;
    }
    
    if ([object isKindOfClass:NSDictionary.class]) {
        return [self itemWithDictionary:object type:type];
    }
    
    if ([object isKindOfClass:NSArray.class]) {
        return [self itemWithArray:object type:type];
    }
    
    if ([object isKindOfClass:NSNull.class]) {
        return nil;
    }
    
    NSString *title = [object description];
    if (0 == title.length) {
        return nil;
    }
    
    ListViewDataItem *item = [ListViewDataItem new];
    item.entity = type;
    item.detail = object;
    item.title = title;
    return item;
}

- (ListViewDataItem *)itemWithDictionary:(NSDictionary *)dictionary type:(NSString *)type {
    if (dictionary) {
        ListViewDataItem *item = [ListViewDataItem new];
        item.entity = type;
        item.detail = dictionary;
        item.title = [self titleFromDictionary:dictionary type:nil];
        item.subtitle = [self subtitleFromDictionary:dictionary type:type];
    }
    return nil;
}

- (ListViewDataItem *)itemWithArray:(NSArray *)array type:(NSString *)type {
    if (array.count > 0) {
        ListViewDataItem *item = [ListViewDataItem new];
        item.entity = type;
        item.detail = array;
        item.title = [NSString stringWithFormat:@"%@[%@]", type?:@"", @(array.count)];
        item.subtitle = [self subtitleFromArray:array type:type];
    }
    return nil;
}

- (NSString *)titleFromDictionary:(NSDictionary *)dictionary type:(NSString *)type {
    if ([type isEqualToString:@"life-span"]) {
        MbzDataLifeSpan *span = [[MbzDataLifeSpan alloc] initWithDictionary:dictionary];
        return span.description;
    }
    
    for (NSString *key in @[@"name", @"title"]) {
        NSString *value = dictionary[key];
        if ([value isKindOfClass:NSString.class]) {
            return value;
        }
    }
    
    return nil;
}

- (NSString *)subtitleFromDictionary:(NSDictionary *)dictionary type:(NSString *)type {
    if (dictionary) {
        NSMutableDictionary *mdic = dictionary.mutableCopy;
        [mdic removeObjectsForKeys:@[@"score", @"id", @"name", @"title"]];
        
        NSMutableArray *strs = [NSMutableArray new];
        [mdic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:NSString.class]) {
                [strs addObject:obj];
            }
            else if ([obj isKindOfClass:NSDictionary.class]) {
                NSString *str = [self titleFromDictionary:obj type:key];
                if (str.length > 0) {
                    [strs addObject:str];
                }
            }
        }];
        return [strs componentsJoinedByString:@", "];
    }
    return nil;
}

- (NSString *)subtitleFromArray:(NSArray *)array type:(NSString *)type {
    if (array) {
        NSString *type_singulare = [self singularNameOf:type];
        
        NSMutableArray *strs = [NSMutableArray new];
        for (id obj in array) {
            NSString *str;
            if ([obj isKindOfClass:NSDictionary.class]) {
                str = [self titleFromDictionary:obj type:type_singulare];
            }
            else if ([obj isKindOfClass:NSArray.class]) {
                if (type) {
                    NSArray *arr = obj;
                    str = [type stringByAppendingFormat:@"[%@]", @(arr.count)];
                }
            }
            else {
                str = [obj description];
            }
            if (str.length > 0) {
                [strs addObject:str];
            }
        }
        return [strs componentsJoinedByString:@", "];
    }
    return nil;
}

- (NSArray *)allSortedKeysOfDictionary:(NSDictionary *)dictionary ascending:(BOOL)ascending {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:ascending];
    NSArray *sortedKeys = [dictionary.allKeys sortedArrayUsingDescriptors:@[sortDescriptor]];
    return sortedKeys;
}

- (NSString *)singularNameOf:(NSString *)pluralName {
    // TODO
    // ...
    
    if ([pluralName hasSuffix:@"s"]) {
        return [pluralName substringToIndex:pluralName.length-1];
    }
    
    return pluralName;
}

@end

@implementation ListViewDataSection

@end

@implementation ListViewDataItem

@end

@implementation NSDate (MbzDate)

- (NSString *)mbzDateString {
    return [NSDate.mbzDateFormatter stringFromDate:self];
}

+ (NSDate *)dateWithMbzDateString:(NSString *)str {
    return [NSDate.mbzDateFormatter dateFromString:str];
}

+ (NSDateFormatter *)mbzDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    return dateFormatter;
}

@end
