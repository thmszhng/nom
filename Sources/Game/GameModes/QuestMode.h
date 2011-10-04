//
//  QuestMode.h
//  Nom
//
//  Created on 11-08-29.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Game.h"

@interface QuestMode: Game {
}

-(id) init;
-(void) dealloc;

-(BOOL) headChecks: (Vector *) head;
-(void) onEat: (Food *) food;

-(Vector *) findSpace;
-(Vector *) findSpaceNear: (Vector *) where;

@end
