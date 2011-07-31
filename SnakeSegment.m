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