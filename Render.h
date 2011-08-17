//
//  Render.h
//  Nom
//
//  Created on 11-08-01.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "cocos2d.h"

// takes points
void glDrawRect(GLfloat x, GLfloat y, GLfloat width, GLfloat height);
void drawBox(int x, int y, int width, int height, GLubyte r, GLubyte g, GLubyte b, GLubyte a);

// grid coordinates
void drawSnake(int x, int y, BOOL ctop, BOOL cleft, BOOL cbottom, BOOL cright);