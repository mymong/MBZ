//
//  ListViewDataLoader.m
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/4.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import "ListViewDataLoader.h"

#define ShowEmptyItems NO

@interface ListViewDataSection ()
+ (NSArray *)sectionArrayWithDictionary:(NSDictionary *)dictionary;
@end

@interface ListViewDataItem ()
+ (NSArray *)itemArrayWithObject:(id)object forKey:(id)key;
@end

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
    NSArray *sections = [self makeSectionsFromJSONObject:object];
    
    __weak __typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong __typeof(wself) sself = wself; if (sself) {
            [sself.sections addObjectsFromArray:sections];
            
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

- (NSArray *)makeSectionsFromJSONObject:(id)object {
    if ([object isKindOfClass:NSDictionary.class]) {
        return [self makeSectionsFromDictionary:object];
    }
    
    if ([object isKindOfClass:NSArray.class]) {
        ListViewDataSection *section = [ListViewDataSection new];
        section.items = [self makeItemsFromArray:object withEntity:self.entity];
        return @[section];
    }
    
    if (object) {
        ListViewDataItem *item = [self makeItemFromObject:object withEntity:self.entity];
        ListViewDataSection *section = [ListViewDataSection new];
        section.items = @[item];
        return @[section];
    }
    
    return @[];
}

- (NSArray *)makeSectionsFromDictionary:(NSDictionary *)dictionary {
    NSMutableArray *array = [NSMutableArray new];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        ListViewDataSection *section = [ListViewDataSection new];
        NSString *entity = [self singularNameOf:key];
        section.title = key;
        section.items = [self makeItemsFromJSONObject:obj withEntity:entity];
        if (ShowEmptyItems) {
            [array addObject:section];
        }
        else if (section.items.count > 0) {
            [array addObject:section];
        }
    }];
    return array;
}

- (NSArray *)makeItemsFromJSONObject:(id)object withEntity:(NSString *)entity {
    NSParameterAssert(object);
    if ([object isKindOfClass:NSDictionary.class]) {
        return [self makeItemsFromDictionary:object withEntity:entity];
    }
    if ([object isKindOfClass:NSArray.class]) {
        return [self makeItemsFromArray:object withEntity:entity];
    }
    ListViewDataItem *item = [self makeItemFromObject:object withEntity:entity];
    return @[item];
}

- (NSArray *)makeItemsFromDictionary:(NSDictionary *)dictionary withEntity:(NSString *)entity {
    NSMutableArray *items = [NSMutableArray new];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        ListViewDataItem *item = [self makeItemFromObject:obj withEntity:entity];
        if (item.title.length > 0) {
            [items addObject:item];
        }
    }];
    return items;
}

- (NSArray *)makeItemsFromArray:(NSArray *)array withEntity:(NSString *)entity {
    NSMutableArray *items = [NSMutableArray new];
    for (id object in array) {
        ListViewDataItem *item = [self makeItemFromObject:object withEntity:entity];
        if (item.title.length > 0) {
            [items addObject:item];
        }
    }
    return items;
}

- (ListViewDataItem *)makeItemFromObject:(id)object withEntity:(NSString *)entity {
    ListViewDataItem *item = [ListViewDataItem new];
    item.entity = entity;
    item.detail = object;
    
    if ([object isKindOfClass:NSNull.class]) {
        return item;
    }
    
    if ([object isKindOfClass:NSString.class] || [object isKindOfClass:NSNumber.class]) {
        item.title = [object description];
        return item;
    }
    
    if ([object isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = object;
        
        id value = dic[@"id"];
        if ([value isKindOfClass:NSString.class]) {
            item.mbid = value;
        }
        
        value = dic[@"name"];
        if ([value isKindOfClass:NSString.class]) {
            item.title = value;
            return item;
        }
        
        value = dic[@"title"];
        if ([value isKindOfClass:NSString.class]) {
            item.title = value;
            return item;
        }
    }
    
    item.title = @"?";
    return item;
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
    
    if ([object isKindOfClass:NSNull.class]) {
        return item;
    }
    
    if ([object isKindOfClass:NSDictionary.class]) {
        if ([key isEqualToString:@"life-span"]) {
            item.title = [self stringFromLifeSpan:object];
            return item;
        }
    }
    
    if ([object isKindOfClass:NSDictionary.class]) {
        item.entity = key;
        item.detail = object;
        
        NSDictionary *dic = object;
        id value = dic[@"id"];
        if (value) {
            item.mbid = value;
        }
        
        value = dic[@"name"];
        if (value) {
            item.title = value;
            return item;
        }
        
        value = dic[@"title"];
        if (value) {
            item.title = value;
            return item;
        }
        
        value = dic[@"artist"];
        if ([value isKindOfClass:NSDictionary.class]) {
            item.title = @"artist";
            return item;
        }
        
        item.title = [NSString stringWithFormat:@"TODO: item object as dictionary for keys: %@", dic.allKeys];
        return item;
    }
    
    if ([object isKindOfClass:NSString.class]) {
        NSDate *date = [NSDate dateWithMbzDateString:object];
        if (date) {
            item.title = date.description;
            return item;
        }
    }
    
    // TODO
    // ...
    item.title = [object description];
    
    return item;
}

#pragma mark converter

+ (NSString *)stringFromLifeSpan:(NSDictionary *)life_span {
    NSMutableString *string = [NSMutableString new];
    
    NSString *begin = life_span[@"begin"];
    NSString *end = life_span[@"end"];
    if (begin && ![begin isKindOfClass:NSString.class]) {
        begin = nil;
    }
    if (end && ![end isKindOfClass:NSString.class]) {
        end = nil;
    }
    
    if (begin && end) {
        [string appendFormat:@"%@ ~ %@", begin, end];
    }
    else if (begin) {
        [string appendFormat:@"%@ ~", begin];
    }
    else if (end) {
        [string appendFormat:@"~ %@", end];
    }
    
    NSNumber *ended = life_span[@"ended"];
    if ([ended isKindOfClass:NSNumber.class] && ended.boolValue) {
        if (string.length > 0) {
            [string appendString:@" "];
        }
        [string appendString:@"(Ended)"];
    }
    
    return string;
}

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
