//
//  Food.h
//  Nom
//
//  Created by Qian Zhang on 11-07-26.
//  Copyright 2011 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Food : CCSprite {
    //sprite
    CCSprite *sprite;
    
    //info
    int x;
    int y;
}

-(void) render;
-(void) moveSprite;

-(void) setX: (int) n;
-(void) setY: (int) n;

-(int) reportX;
-(int) reportY;

@end
