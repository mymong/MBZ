//
//  UITableViewCell+ArtistCell.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/22/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "UITableViewCell+ArtistCell.h"
#import "ArtistCellAccessoryView.h"
#import "UIView+LoadFromNib.h"
#import "UIImageView+WebCache.h"
#import "MbzDataArtist.h"
#import "MbzDataLifeSpan.h"

@implementation UITableViewCell (ArtistCell)

+ (instancetype)artistCellWithInfo:(NSDictionary *)info forIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView {
    MbzDataArtist *artist = [[MbzDataArtist alloc] initWithDictionary:info];
    NSString *text = artist.name;
    
    NSString *detailText = artist.disambiguation;
    if (detailText) {
        detailText = [NSString stringWithFormat:@"%@", detailText];
    }
    
    MbzDataLifeSpan *lifeSpan = artist.life_span;
    NSString *lifeShow = [lifeSpan showString];
    if (lifeShow) {
        detailText = detailText ? [detailText stringByAppendingFormat:@" %@", lifeShow] : lifeShow;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtistCell" forIndexPath:indexPath];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;
    cell.imageView.image = [self artistImagePlaceholder];
    
    ArtistCellAccessoryView *accessoryView = (ArtistCellAccessoryView *)cell.accessoryView;
    if (![accessoryView isKindOfClass:ArtistCellAccessoryView.class]) {
        cell.accessoryView = accessoryView = [ArtistCellAccessoryView viewFromNib:nil];
    }
    [accessoryView setArtist:artist];
    return cell;
}

+ (UIImage *)artistImagePlaceholder {
    static UIImage *image;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSData *data = [[NSData alloc] initWithBase64EncodedString:@"iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAABzlBMVEX///9zbK5XUoUAAABSUlLa2tv6+vvx8fP4+Pnd3N1TTn5ya6za2drz8vXW1dzo6Ou3tb3U0tdpZmxuZ6bc3OLs6+7Bv8fY1tuQj5aMio9pYp5xaqvz8fTv7/LKx9Hf3uOdnKS9u8FDQkZnYZxwaapSTXxJRG5ya636+vrU0tno5uuxsLrJx850cXpxcHZIQ21RTHvx8PPt7PDDwcrY1t2MiZWopq8yMjZGQmtvaan5+frPztbk4ueop7HDwchlYmxhYWVmYJpoYp5uZ6dpY5/w7vHr6u6+u8bV1NqEgIyenaYtLDBnYJxwaalpY6Df3uKcmqS4tr5ZV19dW2Hs6u3j4uaop7DHxcxycXiSkJkoJiro5+q1s7rMzNKFhIqlpKtKSU9NTFFUT4CGhIg3NjphYWMkIyZEREktKkRoYZ1UT39sZaP/yWGUdDh5Xy75xF78xl/0wFzpt1iEaDLltFfmtVfotljwvVt/ZDCSczftulr7xV/9x2CQcTbruVlLS0thYWHvvFr2wV3xvVv6xV9/f3/+yGD1wV3MoE0gICBoaGi4kUX4w16jgD5nZFtWUkiffTwbGxuvramFgnt3dGxMSUA7OjIgHxrzv1zquFlvZxpMAAAAAXRSTlMAQObYZgAAAU1JREFUOMuFkzFLw1AUhb8TatMk0jq1EEURqoOLOLg6OvkfnIpLJ9GOLoKLutXB1cn/4X9QKFVEJFQsYodGadU4NNWkSdsz3ffu4dxzz+MJxHgEaGIfAk3ugzGlTyZ6GMgFQfIurA1JUs+Un66gnCTJ6szhp4/o5SVJmLkxhKIGBEspI8pSczYk4Kx/NEYJugcrJDyyaa02RnIQJawB2MK2EyMaxtqLEyo4GFYjadLmprghSdxh36ZusTM0OS5qM4UQfazda9M0TfOqsj1G4XXvEqDyvBTNv/r/bDF0EgoFnQzL2idOUoGMrIx0fCT01k/z8DUXZPsz+F1wvdQt3jst4HsePAA3mQMLEiW5vs2P4XVdL0JYrgFwenh2AMB5G8ePmlyR9OcsK1Uv2q2Ywj4jeMgPnA4VCovNOKH85ODFc0jH1J8lJkvUxURGnV8gw0b7R7TRyAAAAABJRU5ErkJggg==" options:0];
        image = [UIImage imageWithData:data];
    });
    return image;
}

@end
