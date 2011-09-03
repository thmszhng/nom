//
//  Level.m
//  Nom
//
//  Created by Thomas Zhang on 11-09-02.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "Level.h"


@implementation Level
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        for (int i = 0; i < 30; i++)
        {
            for (int j = 0; j < 30; j++)
            {
                levelInfo[i][j] = LevelNothing;
            }
        }
    }
    
    return self;
}

-(enum LevelSpot) getValue: (int) i: (int) j
{
    return levelInfo[i][j];
}

-(void) setValue: (int) i: (int) j: (enum LevelSpot) value
{
    levelInfo[i][j] = value;
}

@end
