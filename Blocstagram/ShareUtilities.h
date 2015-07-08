//
//  ShareUtilities.h
//  Blocstagram
//
//  Created by rick m on 7/8/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Media;

@interface ShareUtilities : NSObject

+ (UIActivityViewController *)shareMediaItem:(Media *)media;

@end
