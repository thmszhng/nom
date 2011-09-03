//
//  LevelLayer.m
//  Nom
//
//  Created on 11-09-02.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "LevelLayer.h"
#import "Render.h"

#import "GameManager.h"
#import "Level.h"

@implementation LevelLayer
-(void) draw
{
    Level *level = [GameManager sharedGameManager].currentLevel;
    if (level == nil) return;
    for (int y = 0; y < 30; ++y)
    {
        for (int x = 0; x < 30; ++x)
        {
            if ([level getValue: x : y] != LevelWall)
            {
                continue;
            }
            BOOL top = (y < 29 && [level getValue: x : y+1] == LevelWall),
                 left = (x > 0 && [level getValue: x-1 : y] == LevelWall),
                 bottom = (y > 0 && [level getValue: x : y-1] == LevelWall),
                 right = (x < 29 && [level getValue: x+1 : y] == LevelWall);
            drawSnake(x, y, top, left, bottom, right);
        }
    }
}

@end
