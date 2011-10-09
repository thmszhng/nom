//
//  LevelLayer.m
//  Nom
//
//  Created on 11-09-02.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "LevelLayer.h"
#import "Render.h"
#import "SnakeTail.h"
#import "GameManager.h"
#import "Level.h"
#import "GameplayLayer.h"

@implementation LevelLayer
@synthesize theGameplayLayer;
-(void) onEnter
{
    sprite = [[[GameManager sharedGameManager].level drawWithSize: 10] retain];
}

#define sgn(x) (((x)>0)-((x)<0))

-(void) draw
{   
    glEnable(GL_SCISSOR_TEST);
             
    if (haveRetina)
        glScissor(20, 296, 600, 600);
    else
        glScissor(10, 148, 300, 300);
             
    Vector *pos = theGameplayLayer.game.head.pos;
    int deltaX = theGameplayLayer.isFancy ? 15 - pos.x : 0, deltaY = theGameplayLayer.isFancy ? 15 - pos.y : 0;
    sprite.position = ccp(160+deltaX*10, 298+deltaY*10);
    [sprite visit];
    if (deltaY)
    {
        sprite.position = ccp(160+deltaX*10, 298+deltaY*10-sgn(deltaY)*300);
        [sprite visit];
    }
    if (deltaX)
    {
        sprite.position = ccp(160+deltaX*10-sgn(deltaX)*300, 298+deltaY*10);
        [sprite visit];
    }
    if (deltaX && deltaY)
    {
        sprite.position = ccp(160+deltaX*10-sgn(deltaX)*300, 298+deltaY*10-sgn(deltaY)*300);
        [sprite visit];
    }
    glDisable(GL_SCISSOR_TEST);
}
@end
