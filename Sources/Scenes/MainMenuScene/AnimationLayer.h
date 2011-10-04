//
//  AnimationLayer.h
//  Nom
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define MAX_RUNNERS 200

#define WIDTH 32
#define HEIGHT 48

@interface AnimationLayer : CCLayer 
{
    int X[MAX_RUNNERS];
    int Y[MAX_RUNNERS];
    int dX[MAX_RUNNERS];
    int dY[MAX_RUNNERS];
    int freeList[MAX_RUNNERS];
    int numFree;
    
    int grid[WIDTH][HEIGHT];
}

-(id) init;

-(int) newRunner;
-(void) deleteRunner: (int) which;
-(void) moveRunner: (int) which;

-(void) update: (ccTime) deltaTime;
-(void) draw;

@end