//
//  ListViewDataLoader.h
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/4.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import "MbzApi+WebService.h"

@class ListViewDataLoader;

@protocol ListViewDataLoaderDelegate <NSObject>
- (void)listViewDataLoaderDidReload:(ListViewDataLoader *)dataLoader;
- (void)listViewDataLoader:(ListViewDataLoader *)dataLoader didLoadFailedWithError:(NSError *)error;
@optional
- (void)listViewDataLoader:(ListViewDataLoader *)dataLoader didLoadSectionsAtIndexSet:(NSIndexSet *)indexSet;
- (void)listViewDataLoader:(ListViewDataLoader *)dataLoader didLoadItemsAtIndexSet:(NSIndexSet *)indexSet inSection:(NSUInteger)section;
@end

@interface ListViewDataLoader : NSObject
@property (nonatomic,weak) id<ListViewDataLoaderDelegate> delegate;
@property (nonatomic,readonly) dispatch_queue_t loadingQueue;
@property (nonatomic,readonly) NSString *entity;
@property (nonatomic,readonly) NSMutableArray *sections;
@property (nonatomic,readonly) BOOL isLoading;
@property (nonatomic,readonly) NSDate *loadedDate;
- (instancetype)initWithEntity:(NSString *)entity;
- (void)load;
- (BOOL)willLoad;
- (void)didFinishLoading:(NSDate *)date;
- (void)didLoadWithResponse:(MbzResponse *)response;
- (void)didLoadWithJSONObject:(id)object;
@end

@interface ListViewDataSection : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSArray *items;
@end

@interface ListViewDataItem : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *subtitle;
@property (nonatomic) NSString *entity;
@property (nonatomic) NSString *mbid;
@property (nonatomic) id detail;
@end

@interface NSDate (MbzDate)
- (NSString *)mbzDateString;
+ (NSDate *)dateWithMbzDateString:(NSString *)str;
@end
