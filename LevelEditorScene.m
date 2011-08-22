//
//  LevelEditorScene.m
//  Nom
//
//  Created by Thomas Zhang on 11-08-16.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "LevelEditorScene.h"


@implementation LevelEditorScene
@synthesize vc, window;
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        levelEditorLayer = [LevelEditorLayer node];
        [self addChild: levelEditorLayer z: 0 tag: kLevelEditorLayer];
        
                
        
        window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        // Create test view controller
        vc = [[ViewController alloc] init];

        [window addSubview:vc.view];
        [window makeKeyAndVisible];

        [vc setDelegate:levelEditorLayer];

    }
    
    return self;
}

@end
