//
//  TimeBonusFood.h
//  Nom
//
//  Created on 11-08-20.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <Foundation/NSObject.h>
#import "Food.h"

@interface TimeBonusFood: Food
{
    int stepsOnCreation;
}

-(id) initWithGame: (Game *) game;
-(void) eat: (Game *) game;
-(ccColor3B) color;

@end