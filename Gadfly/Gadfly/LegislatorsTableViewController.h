/*
 @file Custom UITableViewContorller class
 */

#import <UIKit/UIKit.h>
#import "SplashPageViewController.h"

@interface LegislatorsTableViewController : UITableViewController 
@property (strong, nonatomic) NSString* userAddress;
@property (nonatomic, strong) NSArray *legislators;
@property (nonatomic,strong) NSString *errorMsg;
@end
