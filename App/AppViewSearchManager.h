//
//  AppViewSearchManager.h
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/5.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppViewSearchManager : NSObject

@property (copy) void (^searchBlock)(NSString *entity, NSString *query);
@property (readonly) UISearchBar *searchBar;

///
- (void)dismiss;

@end
