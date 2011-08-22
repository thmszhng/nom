#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    id delegate;
    double lastScale;
    double currentScale;
}
@property (assign) id delegate;
@end
