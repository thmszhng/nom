//
//  ShieldFood.h
//  Nom
//
//  Created on 11-08-23.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Food.h"

@interface ShieldFood: Food
{
}

+(void) load;

-(BOOL) eat: (Game *) game;
-(ccColor3B) color;

@end
