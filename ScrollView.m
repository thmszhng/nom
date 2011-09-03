//  ScrollView.m
//  Nom
//
//  Created on 11-08-30.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "ScrollView.h"

#define ITEM_WIDTH 120
#define ITEM_HEIGHT 135
#define PADDING 10
#define ITEM_TOTAL_WIDTH (ITEM_WIDTH + PADDING*2)
#define VIEW_WIDTH 280

@interface InnerScrollView: UIScrollView<UIScrollViewDelegate>
{
    CCNode *target;
}
@property(readwrite, retain) CCNode *target;
-(id) initWithFrame: (CGRect) frame numPages: (int) num target: (CCNode *) target;
@end

@implementation InnerScrollView
@synthesize target;
-(id) initWithFrame: (CGRect) frame numPages: (int) num target: (CCNode *) tget
{
    self = [super initWithFrame: frame];
    if (self != nil)
    {
        self.contentSize = CGSizeMake(ITEM_TOTAL_WIDTH * num, ITEM_HEIGHT);
        self.bounces = YES;
        self.delaysContentTouches = NO;
        self.delegate = self;
        self.pagingEnabled = YES;
        self.scrollsToTop = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = YES;
        self.target = tget;
    }
    return self;
}

-(void) dealloc
{
    self.target = nil;
    [super dealloc];
}

-(void) scrollViewDidScroll: (UIScrollView *) scrollView
{
    CGPoint pos = [[CCDirector sharedDirector] convertToGL: [self contentOffset]];
    //    NSLog(@"offset %lf,%lf", pos.x, pos.y);
    CGPoint targetPosition = target.position;
    targetPosition.x = (VIEW_WIDTH - ITEM_TOTAL_WIDTH)/2 - pos.x;
    target.position = targetPosition;
}
@end

@interface TouchView: UIView
{
    InnerScrollView *scrollView;
}
@property(readwrite, retain) InnerScrollView *scrollView;
@end

@implementation TouchView
@synthesize scrollView;
-(void) dealloc
{
    self.scrollView = nil;
    [super dealloc];
}
-(UIView *) hitTest: (CGPoint) point withEvent: (UIEvent *) event
{
    if ([self pointInside: point withEvent: event]) return scrollView;
    return nil;
}
@end

@interface Sprites: CCNode
{
    NSArray *sprites;
}
@property(readwrite, retain) NSArray *sprites;
-(id) initWithSprites: (NSArray *) sprites;
@end

@implementation Sprites
@synthesize sprites;
-(id) initWithSprites: (NSArray *) _sprites
{
    self = [super init];
    if (self != nil)
    {
        self.sprites = _sprites;
    }
    return self;
}
-(void) dealloc
{
    self.sprites = nil;
    [super dealloc];
}
-(void) onEnter
{
    int x = ITEM_TOTAL_WIDTH/2;
    for (id sprite in sprites)
    {
        CCSprite *realSprite = nil;
        CCSprite *shadow = [CCSprite spriteWithFile: @"120Shadow.png"];
        if ([sprite isKindOfClass: [NSString class]])
            realSprite = [CCSprite spriteWithFile: sprite];
        else if ([sprite isKindOfClass: [CCSprite class]])
            realSprite = sprite;
        else
            [NSException raise: @"TypeError" format: @"Incorrect type given to Sprites"];
        shadow.position = realSprite.position = CGPointMake(x, ITEM_HEIGHT/2);
        x += ITEM_TOTAL_WIDTH;
        [self addChild: realSprite z: 1];
        [self addChild: shadow z: 0];
    }
    [super onEnter];
}
@end

@implementation ScrollView
@synthesize scrollView;
@synthesize touchView;
@synthesize spriteView;
@synthesize sprites;
@synthesize initialPage;

-(id) initWithDictionary: (NSDictionary *) _sprites
{
    self = [super init];
    if (self != nil)
    {
        self.sprites = _sprites;
    }
    return self;
}

-(void) dealloc
{
    self.scrollView = nil;
    self.touchView = nil;
    self.spriteView = nil;
    self.sprites = nil;
    self.initialPage = nil;
    [super dealloc];
}

-(void) onEnter
{
    int numPages = [sprites count];
    spriteView = [[Sprites alloc] initWithSprites: [sprites allValues]];
    [self addChild: spriteView];
    int initialOffset = 0;
    {
        int i = 0;
        for (NSObject *key in sprites)
        {
            if ([key isEqual: initialPage]) initialOffset = i;
            ++i;
        }
    }
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    spriteView.position = CGPointMake((VIEW_WIDTH - ITEM_TOTAL_WIDTH)/2, 0);
    CGRect frame = CGRectMake(0, self.position.y,
                              winSize.width, ITEM_HEIGHT);
    frame.origin.y = [[CCDirector sharedDirector] winSize].height - frame.origin.y - frame.size.height;
    touchView = [[TouchView alloc] initWithFrame: frame];
    frame.origin.x = self.position.x;
    frame.size.width = ITEM_TOTAL_WIDTH;
    scrollView = [[InnerScrollView alloc] initWithFrame: frame
                                               numPages: numPages
                                                 target: spriteView];
    touchView.scrollView = scrollView;
    [scrollView setContentOffset: CGPointMake(ITEM_TOTAL_WIDTH * initialOffset, 0)];
    [[[CCDirector sharedDirector] openGLView] addSubview: touchView];
    [[[CCDirector sharedDirector] openGLView] addSubview: scrollView];
    
    [super onEnter];
}

-(void) onExit
{
    [scrollView removeFromSuperview];
    [touchView removeFromSuperview];
    self.scrollView = nil;
    self.touchView = nil;
    self.spriteView = nil;
    self.sprites = nil;
    self.initialPage = nil;
    
    [super onExit];
}

-(void) visit
{
    if (!self.visible) return;
    glEnable(GL_SCISSOR_TEST);
    CGSize winSize = [[CCDirector sharedDirector] winSizeInPixels];
    int retinaMultiplier = winSize.width / 320;
    glScissor(self.position.x * retinaMultiplier, 0,
              VIEW_WIDTH * retinaMultiplier, winSize.height);
    [super visit];
    glDisable(GL_SCISSOR_TEST);
}

-(id) selected
{
    NSUInteger index = scrollView.contentOffset.x / (double) ITEM_TOTAL_WIDTH + 0.5;
    return [[sprites allKeys] objectAtIndex: index];
}

@end
