//
//  TimeBonusFood.h
//  Nom
//
//  Created on 11-08-20.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Food.h"

@interface TimeBonusFood: Food
{
    int timeAtCreation;
    Game *_game;
}

+(void) load;

-(id) initWithGame: (Game *) game;
-(BOOL) eat: (Game *) game;
-(ccColor3B) color;

@end
