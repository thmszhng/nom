//
//  Food.h
//  Nom
//
//  Created on 11-08-15.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GridObject.h"
#import "cocos2d.h"

@class Game;
@class Vector;

@interface Food: GridObject
{
}

-(id) initWithGame: (Game *) game;
-(ccColor3B) color;

@end
