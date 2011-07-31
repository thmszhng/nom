//
//  SnakeSegment.h
//  Nom
//
//  Created by Qian Zhang on 11-07-25.
//  Copyright 2011 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface SnakeSegment : NSObject
{
    //info
    enum Direction {up, down, left, right} direction;
    int x;
    int y;
}

-(void) move;

-(void) setX: (int) n;
-(void) setY: (int) n;
-(void) setDirection: (enum Direction) n;

-(int) reportX;
-(int) reportY;
-(enum Direction) reportDirection;
@end
