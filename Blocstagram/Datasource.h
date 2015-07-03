//
//  Datasource.h
//  Blocstagram
//
//  Created by rick m on 6/28/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Media;

typedef void (^NewItemcompletionBlock)(NSError *error);

@interface Datasource : NSObject

+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *mediaItems;

- (void) deleteMediaItem:(Media *)item;

- (void) requestNewItemsWithCompletionHandler:(NewItemcompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(NewItemcompletionBlock)completionHandler;

@end
