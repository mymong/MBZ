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
//- (void)listViewDataLoader:(ListViewDataLoader *)dataLoader didInsertSections:(NSIndexSet *)sections;
@end

@interface ListViewDataLoader : NSObject
@property (nonatomic,weak) id<ListViewDataLoaderDelegate> delegate;
@property (nonatomic,readonly) NSArray *sections;
@property (nonatomic,readonly) BOOL isLoading;
+ (instancetype)dataLoaderForSearchWithEntity:(NSString *)entity query:(NSString *)query;
+ (instancetype)dataLoaderForLookupWithEntity:(NSString *)entity mbid:(NSString *)mbid;
+ (instancetype)dataLoaderForBrowseWithEntity:(NSString *)entity;
+ (instancetype)dataLoaderForDetail:(NSDictionary *)detail withEntity:(NSString *)entity;
- (void)reload;
//- (void)loadMore;
@end

@interface ListViewDataSection : NSObject
@property (nonatomic) NSArray *items;
@property (nonatomic) NSString *title;
@end

@interface ListViewDataItem : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *subtitle;
@property (nonatomic) NSString *entity;
@property (nonatomic) NSString *mbid;
@property (nonatomic) NSDictionary *detail;
@end
