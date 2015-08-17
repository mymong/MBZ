//
//  MbzCompletion.h
//  MusicBrainz
//
//  Created by Jason Yang on 7/6/15.
//  Copyright (c) 2015 nero. All rights reserved.
//

#import "MbzResponse.h"

/**
 *  MBZ (MusicBrainz) API completion block definition.
 *
 *  @param response The response of each Api method.
 */
typedef void(^MbzCompletion)(MbzResponse *response);

/**
 *  MBZ (MusicBrainz) API completion block (with special attention data) definition.
 *
 *  @param response The response of each Api method.
 *  @param T        Attention data class.
 */
#define MbzCompletionWith(T) void(^)(MbzResponse *response, T *object)
