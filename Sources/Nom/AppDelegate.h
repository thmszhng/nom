//
//  AppDelegate.h
//  Nom
//
//  Created on 11-07-25.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameManager.h"
#import "GameplayLayer.h"
#import "PauseLayer.h"
#import "GameManager.h"

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
