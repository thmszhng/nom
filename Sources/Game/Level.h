//
//  Level.h
//  Nom
//
//  Created by Thomas Zhang on 11-09-02.
//  Copyright 2011 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>

enum LevelSpot {
    LevelNothing = 0,
    LevelWall,
    LevelFood,
};

@class CCSprite;

@interface Level: NSObject
{
    enum LevelSpot levelInfo[30][30];
    NSMutableDictionary *renderCache;
}

+(id) level;

-(enum LevelSpot) getValue: (int) i: (int) j;
-(void) setValue: (int) i: (int) j: (enum LevelSpot) value;
-(CCSprite *) drawWithSize: (int) size;

@end
