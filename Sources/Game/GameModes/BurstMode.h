//
//  BurstMode.h
//  Nom
//
//  Created on 11-08-29.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Game.h"

@interface BurstMode: Game {
}

-(id) init;

-(void) onEat: (Food *) food;

@end
