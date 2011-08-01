//
//  SnakeSegment.m
//  Nom
//
//  Created by Qian Zhang on 11-07-25.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "SnakeSegment.h"


@implementation SnakeSegment
-(void) move
{
    //updates the snake segment coordinates
    switch (direction) 
    {
        case up:
            if (++y >= 30) y = 0;
            break;
            
        case down:
            if (--y < 0) y = 29;
            break;
            
        case left:
            if (--x < 0) x = 29;
            break;
            
        case right:
            if (++x >= 30) x = 0;
            break;

        default:
            break;
    }
}

-(void) setX: (int) n
{
    x = n;
}

-(void) setY: (int) n
{
    y = n;
}

-(void) setDirection: (enum Direction) n
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
 
-(enum Direction) reportDirection
{
    return direction;
}
@end