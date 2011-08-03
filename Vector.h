//
//  Food.h
//  Nom
//
//  Created on 11-07-26.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vector : NSObject {
    @private int x;
    @private int y;
}

-(id) initWithX: (int) newX withY: (int) newY;
@property (readwrite, assign) int x;
@property (readwrite, assign) int y;

@end
