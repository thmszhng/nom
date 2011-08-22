#import "ViewController.h"



@implementation ViewController
@synthesize delegate;
- (void)loadView 
{
    CGRect  viewRect = CGRectMake(10, 10, 310, 310);
    [self setView:[[[UIView alloc] initWithFrame:viewRect] autorelease]];
    lastScale=1.0;
    currentScale=1.0;
	// -----------------------------
    // One finger pan
	// -----------------------------
    UIPanGestureRecognizer *oneFingerPan = 
  	[[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerPan:)] autorelease];
    [oneFingerPan setMaximumNumberOfTouches:1];
    [oneFingerPan setMinimumNumberOfTouches:1];
    [[self view] addGestureRecognizer:oneFingerPan];
    
	// -----------------------------
    // Two finger pan
	// -----------------------------
    UIPanGestureRecognizer *twoFingerPan = 
  	[[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPan:)] autorelease];
    [twoFingerPan setMaximumNumberOfTouches:2];
    [twoFingerPan setMinimumNumberOfTouches:2];
    [[self view] addGestureRecognizer:twoFingerPan];
    
    
	// -----------------------------
	// Two finger pinch
	// -----------------------------
	UIPinchGestureRecognizer *twoFingerPinch = 
  	[[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPinch:)] autorelease];
    [[self view] addGestureRecognizer:twoFingerPinch];
    
}

/*--------------------------------------------------------------
 * One finger swipe
 *-------------------------------------------------------------*/
- (void)oneFingerPan:(UISwipeGestureRecognizer *)recognizer 
{ 
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"Swipe - start location: %f,%f", point.x, point.y);
}

/*--------------------------------------------------------------
 * Two finger swipe
 *-------------------------------------------------------------*/
- (void)twoFingerPan:(UISwipeGestureRecognizer *)recognizer 
{ 
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"2 finger swipe - start location: %f,%f", point.x, point.y);
}

/*--------------------------------------------------------------
 * Two finger pinch
 *-------------------------------------------------------------*/
- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer 
{
    
    if([recognizer state] == UIGestureRecognizerStateEnded) {
		lastScale = 1.0;
		return;
	}
    
	currentScale*=(1.0 - (lastScale - [recognizer scale]));
    [delegate redrawScale:currentScale beginX:0 beginY:0];
    
    lastScale = [recognizer scale];
    
}

- (void)dealloc 
{
	[super dealloc];
}

@end
