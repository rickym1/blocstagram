//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by rick m on 6/29/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;

@end
