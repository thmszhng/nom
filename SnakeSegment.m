//
//  SnakeSegment.m
//  Nom
//
//  Created by Qian Zhang on 11-07-25.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "SnakeSegment.h"


@implementation SnakeSegment
-(void) render
{
    sprite = [CCSprite spriteWithFile:@"Snake.png"];
    [sprite setPosition: CGPointMake(x, y)];
    [self addChild:sprite];
}

-(void) move
{
    //updates the snake segment coordinates
    switch (direction) 
    {
        case up:
            if(y == 465)
            {
                y = 175;
            }
            else
            {
                y += 10;
            }
            break;
            
        case down:
            if(y == 175)
            {
                y = 465;
            }
            else
            {
                y -= 10;
            }
            break;
            
        case left:
            if(x == 15)
            {
                x = 305;
            }
            else
            {
                x -= 10;
            }
            break;
            
        case right:
            if(x == 305)
            {
                x = 15;
            }
            else
            {
                x += 10;
            }
            break;
        default:
            break;
    }
    
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

-(void) setDirection: (enum direction) n
{
    direction = n;
}

-(int) reportX
{
    return x;
}

-(int) reportY
{
    return y;
}
 
-(enum direction) reportDirection
{
    return direction;
}
@end