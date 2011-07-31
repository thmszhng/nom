//
//  AppDelegate.h
//  Nom
//
//  Created by Qian Zhang on 11-07-25.
//  Copyright Cisco 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
