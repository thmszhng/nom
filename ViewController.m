#import "ViewController.h"

@implementation ViewController

- (void)loadView 
{
    CGRect  viewRect = CGRectMake(10, 10, 310, 310);
    [self setView:[[[UIView alloc] initWithFrame:viewRect] autorelease]];
    
    
	// -----------------------------
    // One finger, swipe up
	// -----------------------------
    UISwipeGestureRecognizer *oneFingerSwipeUp = 
  	[[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)] autorelease];
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [[self view] addGestureRecognizer:oneFingerSwipeUp];
    
	// -----------------------------
	// One finger, swipe down
	// -----------------------------
    UISwipeGestureRecognizer *oneFingerSwipeDown = 
  	[[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeDown:)] autorelease];
    [oneFingerSwipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [[self view] addGestureRecognizer:oneFingerSwipeDown];
    
	// -----------------------------
	// Two finger rotate  
	// -----------------------------
	UIRotationGestureRecognizer *twoFingersRotate = 
  	[[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingersRotate:)] autorelease];
    [[self view] addGestureRecognizer:twoFingersRotate];
    
	// -----------------------------
	// Two finger pinch
	// -----------------------------
	UIPinchGestureRecognizer *twoFingerPinch = 
  	[[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPinch:)] autorelease];
    [[self view] addGestureRecognizer:twoFingerPinch];
    
}

/*--------------------------------------------------------------
 * One finger, two taps 
 *-------------------------------------------------------------*/
- (void)oneFingerTwoTaps
{
	NSLog(@"Action: One finger, two taps");
}

/*--------------------------------------------------------------
 * Two fingers, two taps
 *-------------------------------------------------------------*/
- (void)twoFingersTwoTaps {
    NSLog(@"Action: Two fingers, two taps");
} 

/*--------------------------------------------------------------
 * One finger, swipe up
 *-------------------------------------------------------------*/
- (void)oneFingerSwipeUp:(UISwipeGestureRecognizer *)recognizer 
{ 
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"Swipe up - start location: %f,%f", point.x, point.y);
}

/*--------------------------------------------------------------
 * One finger, swipe down
 *-------------------------------------------------------------*/
- (void)oneFingerSwipeDown:(UISwipeGestureRecognizer *)recognizer 
{ 
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"Swipe down - start location: %f,%f", point.x, point.y);
}

/*--------------------------------------------------------------
 * Two finger rotate   
 *-------------------------------------------------------------*/
- (void)twoFingersRotate:(UIRotationGestureRecognizer *)recognizer 
{
	// Convert the radian value to show the degree of rotation
	NSLog(@"Rotation in degrees since last change: %f", ([recognizer rotation] * 180) / M_PI);
}

/*--------------------------------------------------------------
 * Two finger pinch
 *-------------------------------------------------------------*/
- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer 
{
	NSLog(@"Pinch scale: %f", recognizer.scale);
}

- (void)dealloc 
{
	[super dealloc];
}

@end
