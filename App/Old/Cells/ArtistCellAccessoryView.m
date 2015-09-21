//
//  ArtistCellAccessoryView.m
//  MusicBrainz
//
//  Created by Jason Yang on 7/22/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "ArtistCellAccessoryView.h"
#import "UIImageView+WebCache.h"
#import "MbzDataLifeSpan.h"
#import "UIImage+ImageWithColor.h"

@interface ArtistCellAccessoryView ()
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *countryImageView;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation ArtistCellAccessoryView

- (void)awakeFromNib {
    CALayer *layer = self.countryImageView.layer;
    layer.shadowColor = [UIColor lightGrayColor].CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowRadius = 1;
    layer.shadowOpacity = 0.6;
}

- (void)setArtist:(MbzDataArtist *)artist {
    NSString *country = artist.country;
    if (country) {
        NSString *countryImageURLString = [NSString stringWithFormat:@"http://asky-01.audials.com/dark/flags/30x22/%@.png", country.lowercaseString];
        [self.countryImageView sd_setImageWithURL:[NSURL URLWithString:countryImageURLString] placeholderImage:[self countryImagePlaceholder]];
    }
    else {
        self.countryImageView.image = [self countryImagePlaceholder];
    }
    
    NSNumber *ended = artist.life_span.ended;
    NSString *type = artist.type.lowercaseString;
    NSString *gender = artist.gender;
    if (ended.boolValue) {
        self.genderImageView.image = [UIImage imageNamed:@"RIP"];
    }
    else if (type) {
        if ([type isEqualToString:@"person"]) {
            if ([gender isEqualToString:@"female"]) {
                self.genderImageView.image = [UIImage imageNamed:@"Female"];
            }
            else {
                self.genderImageView.image = [UIImage imageNamed:@"Male"];
            }
        }
        else if ([type isEqualToString:@"group"]) {
            self.genderImageView.image = [UIImage imageNamed:@"Group"];
        }
    }
    else if (gender) {
        if ([gender isEqualToString:@"female"]) {
            self.genderImageView.image = [UIImage imageNamed:@"Female"];
        }
        else {
            self.genderImageView.image = [UIImage imageNamed:@"Male"];
        }
    }
    
    self.scoreLabel.text = artist.score;
}

- (UIImage *)countryImagePlaceholder {
    static UIImage *inst;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(30, 22)];
    });
    return inst;
}

@end
