/*
 @file Custom controller for splash page
 */
#import "LegislatorsTableViewController.h"
#import "GFScript.h"
#import "GFUser.h"
#import "GFPoli.h"
#import "GFTag.h"

#import <UIKit/UIKit.h>

@interface SplashPageViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (strong, nonatomic) NSString* userAddress;
@property (nonatomic, strong) NSMutableArray *legislators;
@property (nonatomic,strong) NSString *errorMsg;
@end
