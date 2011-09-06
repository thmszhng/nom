//
//  RageFood.h
//  Nom
//
//  Created on 11-09-05.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Food.h"

@interface RageFood: Food
{
}

+(void) load;

-(BOOL) eat: (Game *) game;
-(ccColor3B) color;

@end
