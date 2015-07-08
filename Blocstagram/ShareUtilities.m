//
//  ShareUtilities.m
//  Blocstagram
//
//  Created by rick m on 7/8/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ShareUtilities.h"
#import "Media.h"

@implementation ShareUtilities

+ (UIActivityViewController *)shareMediaItem:(Media *)media {
    NSMutableArray *itemsToShare = [NSMutableArray array];
    
    if (media.caption.length > 0) {
        [itemsToShare addObject:media.caption];
    }
    
    if (media.image) {
        [itemsToShare addObject:media.image];
    }
    
    if (itemsToShare.count > 0) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        return activityVC;
    }
    
    return nil;
}


@end
