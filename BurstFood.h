//
//  BurstFood.h
//  Nom
//
//  Created on 11-08-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Food.h"

@interface BurstFood: Food
{
}

-(void) eat: (Game *) game;
-(ccColor3B) color;

@end