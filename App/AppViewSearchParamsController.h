//
//  AppViewSearchParamsController.h
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/5.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppViewSearchParamsController : UITableViewController

+ (instancetype)loadFromStoryboard;

@property (nonatomic) NSString *selectedEntity;

@end
