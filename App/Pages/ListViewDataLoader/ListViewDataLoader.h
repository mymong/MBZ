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
- (void)listViewDataLoader:(ListViewDataLoader *)dataLoader didReload:(NSError *)error;
//- (void)listViewDataLoader:(ListViewDataLoader *)dataLoader didInsertSections:(NSIndexSet *)sections;
@end

@interface ListViewDataLoader : NSObject
@property (nonatomic,weak) id<ListViewDataLoaderDelegate> delegate;
@property (nonatomic,readonly) dispatch_queue_t loadingQueue;
@property (nonatomic,readonly) NSString *entity;
@property (nonatomic,readonly) NSArray *sections;
@property (nonatomic,readonly) BOOL isLoading;

- (instancetype)initWithEntity:(NSString *)entity;

#pragma mark override
- (void)reload;
//- (void)loadMore;

#pragma mark protected
- (BOOL)willReload;
- (void)didReloadDataWithResponse:(MbzResponse *)response;
- (void)didReloadDataWithJSONObject:(id)object;

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
