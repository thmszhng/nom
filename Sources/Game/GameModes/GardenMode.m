//
//  GardenMode.m
//  Nom
//
//  Created by Thomas Zhang on 11-09-08.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "GardenMode.h"
#import "SlaveFood.h"

@implementation GardenMode
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        timeStart = timestamp;
        timeLimit = 4;
        foodQueue = 0;
        foodEaten = 0;
        
        //for (int i = 0; i < foodQueue; i++)
        //{
            [self createFood: [SlaveFood class]];
        //}
    }
    
    return self;
}

-(BOOL) moveSnake
{
    BOOL survived = [super moveSnake];
    
    if (survived)
    {
        if((timestamp - timeStart) > timeLimit)
        {
            for(int i = 0; i <= foodQueue; i++)
                [self createFood: [SlaveFood class]];
            timeStart = timestamp;
        }
    }
    
    return survived;
}

-(void) onEat:(Food *)food
{
    if(++foodEaten == 5)
    {
        foodEaten = 0;
        foodQueue++;
        if((foodQueue + timeLimit)%2 == 1)
            timeLimit++;
    }
}

@end
