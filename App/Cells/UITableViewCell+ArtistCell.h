//
//  UITableViewCell+ArtistCell.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/22/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ArtistCell)
+ (instancetype)artistCellWithInfo:(NSDictionary *)info forIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView;
@end
