//
//  QuestFood.h
//  Nom
//
//  Created on 07-10-20.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Food.h"

@interface QuestFood: Food
{
}


-(BOOL) eat: (Game *) game;
-(ccColor3B) color;

@end
