//
//  NotVanillaCollectionViewCell.h
//  Blocstagram
//
//  Created by rick m on 7/16/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media, MediaTableViewCell, ComposeCommentView;

@interface NotVanillaCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UICollectionViewFlowLayout *filterCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) NSArray *filterImages;
@property (nonatomic, strong) NSArray *filterTitles;

@end
