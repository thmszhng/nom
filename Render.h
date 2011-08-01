#import "cocos2d.h"

// pixels
void glDrawRect(GLfloat x, GLfloat y, GLfloat width, GLfloat height);

// points
void drawBox(int x, int y, int width, int height, GLubyte r, GLubyte g, GLubyte b, GLubyte a);

// grid coordinates
void drawSnake(int x, int y, BOOL ctop, BOOL cleft, BOOL cbottom, BOOL cright);