//
//  CameraToolBar.h
//  Blocstagram
//
//  Created by rick m on 7/10/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraToolBar;

@protocol CameraToolbarDelegate <NSObject>

- (void) leftButtonPressedOnToolbar:(CameraToolBar *)toolbar;
- (void) rightButtonPressedOnToolbar:(CameraToolBar *)toolbar;
- (void) cameraButtonPressedOnToolbar:(CameraToolBar *)toolbar;

@end

@interface CameraToolBar : UIView

- (instancetype) initWithImageNames:(NSArray *)imageNames;

@property (nonatomic, weak) NSObject <CameraToolbarDelegate> *delegate;

@end
