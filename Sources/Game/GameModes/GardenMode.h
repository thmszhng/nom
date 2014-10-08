//
//  GardenMode.h
//  Nom
//
//  Created by Thomas Zhang on 11-09-08.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "Game.h"

@interface GardenMode : Game {
    int timeStart;
    int timeLimit;
    int foodQueue;
    int foodEaten;
}

-(id) init;
-(void) onEat:(Food *)food;

@end
