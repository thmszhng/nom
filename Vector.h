//
//  Food.h
//  Nom
//
//  Created by Qian Zhang on 11-07-26.
//  Copyright 2011 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vector : NSObject {
    //info
    int _x;
    int _y;
}

-(void) setX: (int) n;
-(void) setY: (int) n;

-(int) x;
-(int) y;

@end
