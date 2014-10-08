//
//  SnakeTail.h
//  Nom
//
//  Created on 11-09-05.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Wall.h"

@interface SnakeTail: Wall {
    SnakeTail *forward; // the next segment toward the head
}
@property (readwrite, assign) SnakeTail *forward;

@end
