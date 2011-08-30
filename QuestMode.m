//
//  QuestMode.m
//  Nom
//
//  Created on 11-08-29.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "QuestMode.h"
#import "FoodRandomizer.h"
#import "GameplayLayer.h"
#import "Render.h"
#import "Swizzle.h"

@implementation GameplayLayer (DisplayOrigin)
-(void) drawWithOrigin
{
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    ccColor3B color = {255, 200, 170};
    ccColor3B darkened = {DARKEN(color.r), DARKEN(color.g), DARKEN(color.b)};
    drawBox(15 * 10 + 10, 15 * 10 + 148, 10, 10, color, darkened);
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    [self drawWithOrigin];
}
@end

@implementation QuestMode

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        Swizzle([GameplayLayer class], @selector(draw), @selector(drawWithOrigin));
        for (int i = 15; i--; )
        {
            [self createFood: [FoodRandomizer randomFood]];
        }
    }
    return self;
}
-(void) dealloc
{
    Swizzle([GameplayLayer class], @selector(draw), @selector(drawWithOrigin));
    [super dealloc];
}

-(BOOL) headChecks: (Vector *)head
{
    if (![super headChecks: head]) return NO;
    if ([head isEqualTo: [self beginSpace]] && foodAmount == 0) {
        for (int i = 15; i--; )
        {
            [self createFood: [FoodRandomizer randomFood]];
        }
    }
    return YES;
}

-(void) onEat: (Food *) eaten
{
}

-(Vector *) findSpace
{
    Vector *r;
    do {
        r = [super findSpace];
    } while ([r isEqualTo: [self beginSpace]]);
    return r;
}

-(Vector *) findSpaceNear: (Vector *) where
{
    Vector *r;
    do {
        r = [super findSpaceNear: where];
    } while ([r isEqualTo: [self beginSpace]]);
    return r;
}

@end
