//
//  ShieldFood.h
//  Nom
//
//  Created on 11-08-23.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <Foundation/NSObject.h>
#import "Food.h"

@interface ShieldFood: Food
{
}

+(void) load;

-(void) eat: (Game *) game;
-(ccColor3B) color;

@end