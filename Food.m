//
//  Food.m
//  Nom
//
//  Created by Qian Zhang on 11-07-26.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "Food.h"


@implementation Food
-(void) render
{
    sprite = [CCSprite spriteWithFile:@"Food.png"];
    [sprite setPosition: CGPointMake(x, y)];
    [self addChild:sprite];
}

-(void) moveSprite
{
    //moves the snake segment sprite
    [sprite setPosition: CGPointMake(x, y)];
}

-(void) setX: (int) n
{
    x = n;
}

-(void) setY: (int) n
{
    y = n;
}

-(int) reportX
{
    return x;
}

-(int) reportY
{
    return y;
}

@end
