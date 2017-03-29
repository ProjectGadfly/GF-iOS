/*
 @file Custom controller for splash page
 */

#import "GFScript.h"
#import "GFUser.h"
#import "GFRep.h"

#import <UIKit/UIKit.h>

@interface SplashPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (strong, nonatomic) NSString* userAddress;
@end
