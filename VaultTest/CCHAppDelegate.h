//
//  CCHAppDelegate.h
//  VaultTest
//
//  Created by Kevin Lee on 6/26/14.
//  Copyright (c) 2014 Context Hub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContextHub/ContextHub.h>

@interface CCHAppDelegate : UIResponder <UIApplicationDelegate, CCHSensorPipelineDelegate, CCHSensorPipelineDataSource>

@property (strong, nonatomic) UIWindow *window;

@end
