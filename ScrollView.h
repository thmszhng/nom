//  ScrollView.h
//  Nom
//
//  Created on 11-08-30.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "cocos2d.h"

@class InnerScrollView;
@class TouchView;
@class Sprites;

@interface ScrollView: CCNode {
    InnerScrollView *scrollView;
    TouchView *touchView;
    Sprites *spriteView;
    NSDictionary *sprites;
    id initialPage;
}
@property(readwrite, retain) InnerScrollView *scrollView;
@property(readwrite, retain) TouchView *touchView;
@property(readwrite, retain) Sprites *spriteView;
@property(readwrite, retain) NSDictionary *sprites;
@property(readwrite, assign) id initialPage;

-(id) initWithDictionary: (NSDictionary *) sprites;
-(void) dealloc;

-(id) selected;

@end
