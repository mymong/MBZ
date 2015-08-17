//
//  RawResponse.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RawResponse : NSObject
/**
 *  HTTP(s) connection response head.
 */
@property (nonatomic) NSHTTPURLResponse *response;
/**
 *  HTTP(s) connection response data.
 */
@property (nonatomic) NSData *data;
/**
 *  HTTP(s) connection error.
 */
@property (nonatomic) NSError *error;
/**
 *  Convert self.data into JSONObject.
 *
 *  @param error Error generated while parsing data into JSON object.
 *
 *  @return JSON object.
 */
- (id)JSONObjectFromData:(NSError **)error;
- (id)JSONObjectFromData;

@end
