//
//  SlaveFood.h
//  Nom
//
//  Created by Thomas Zhang on 11-09-12.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "Food.h"

@interface SlaveFood: Food
{
    int timeAtCreation;
    Game *_game;
}

+(void) load;

-(id) initWithGame: (Game *) game;
-(BOOL) eat: (Game *) game;
-(ccColor3B) color;

@end
