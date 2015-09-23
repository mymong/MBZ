//
//  SearchListViewController.h
//  MusicBrainz
//
//  Created by Jason Yang on 15-09-23.
//  Copyright © 2015年 yg. All rights reserved.
//

#import "ListViewController.h"

@interface SearchListViewController : ListViewController <UISearchControllerDelegate, UISearchBarDelegate>

#pragma mark to be overriden

- (void)performSearchWithText:(NSString *)text;

@end
