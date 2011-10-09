#import "AnimationLayer.h"
#import "Render.h"

BOOL edged(int x, int y)
{
    return (x < 0 || y < 0 || x >= WIDTH || y >= HEIGHT);
}

/*const static int trail[] = { 10, 8, 6, 4, 2, 1 };
const static int trailLength = sizeof(trail)/sizeof(trail[0]);*/

#define RUNNER_STRENGTH 20

@implementation AnimationLayer

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCRenderTexture *texture = [CCRenderTexture renderTextureWithWidth: screenSize.width height: screenSize.height];
        [texture setPosition: CGPointMake (screenSize.width/2, screenSize.height/2)];
        [self addChild: texture z: -1];
        
        [texture beginWithClear: 1.f g: 1.f b: 1.f a: 1.f];
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        glDisableClientState(GL_COLOR_ARRAY);
        
        for (int x = 0; x < WIDTH; ++x) {
            for (int y = 0; y < HEIGHT; ++y) {
                drawBox(x * 10, y * 10, 10, 10, ccc3(249, 249, 249), ccc3(240, 240, 240));
                grid[x][y] = 0;
            }
        }
        
        glEnableClientState(GL_COLOR_ARRAY);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glEnable(GL_TEXTURE_2D);
        [texture end];
        
        for (int i = 0; i < MAX_RUNNERS; ++i)
        {
            dX[i] = dY[i] = 0;
            freeList[i] = MAX_RUNNERS - i - 1;
        }
        numFree = MAX_RUNNERS;
        
        [self scheduleUpdate];
    }
    
    return self;
}

-(int) newRunner
{
    if (numFree == 0) return -1;
    int index = freeList[--numFree];
    switch (random() % 4)
    {
        case 0:
            dX[index] = -1;
            dY[index] = 0;
            X[index] = WIDTH-1;
            Y[index] = random()%HEIGHT;
            break;
        case 1:
            dX[index] = 1;
            dY[index] = 0;
            X[index] = 0;
            Y[index] = random()%HEIGHT;
            break;
        case 2:
            dX[index] = 0;
            dY[index] = -1;
            X[index] = random()%WIDTH;
            Y[index] = HEIGHT-1;
            break;
        case 3:
            dX[index] = 0;
            dY[index] = 1;
            X[index] = random()%WIDTH;
            Y[index] = 0;
            break;
    }
    grid[X[index]][Y[index]] += RUNNER_STRENGTH;
    
    return index;
}

-(void) deleteRunner: (int) which
{
    freeList[numFree++] = which;
    dX[which] = 0;
    dY[which] = 0;
}

-(void) moveRunner: (int) which
{
    X[which] += dX[which];
    Y[which] += dY[which];
    if (edged(X[which], Y[which]))
    {
        [self deleteRunner: which];
        if (random() % 5 == 0) [self newRunner];
    }
    else
    {
        grid[X[which]][Y[which]] += RUNNER_STRENGTH;
    }
}

-(void) update: (ccTime) deltaTime
{
    for (int x = 0; x < WIDTH; ++x)
        for (int y = 0; y < HEIGHT; ++y)
            grid[x][y] = (grid[x][y] * 7) >> 3;
    
    for (int i = 0; i < MAX_RUNNERS; ++i)
    {
        if (dX[i] == 0 && dY[i] == 0) continue;
        [self moveRunner: i];
    }
    if (random() % 5 == 0) [self newRunner];
}

-(void) draw
{
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    
    for (int x = 0; x < WIDTH; ++x) {
        for (int y = 0; y < HEIGHT; ++y) {
            glColor4ub(0, 0, 0, grid[x][y]);
            glDrawRect(x*10, y*10 + 1, 9, 9);
        }
    }
    
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
}

@end
