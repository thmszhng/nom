//
//  LevelEditorLayer.h
//  Nom
//
//  Created by Eddy Gao on 11-08-20.
//  Copyright 2011 Eddy Gao, Thomas Zhang, Geoffry Song. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Render.h"
#import "Constants.h"




@interface LevelEditorLayer: CCLayer {
    CCRenderTexture *texture;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch; 
@end
