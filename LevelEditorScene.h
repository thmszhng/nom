//
//  LevelEditorScene.h
//  Nom
//
//  Created by Thomas Zhang on 11-08-16.
//  Copyright 2011 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LevelEditorLayer.h"
#import "ViewController.h"

@interface LevelEditorScene : CCScene {
    LevelEditorLayer *levelEditorLayer;
    UIWindow *window;
    ViewController *vc;
}
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) ViewController *vc;
@end
