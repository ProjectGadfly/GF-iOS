/*
 @file Custom UITableViewContorller class
 */

#import <UIKit/UIKit.h>
#import "SplashPageViewController.h"
#import "Legislator.h"
#import "LegislatorTableViewCell.h"
#import "ApplicationConstraints.m"
#import "GFPoli.h"
#import "GFUser.h"
#import "GFUser.h"

@interface LegislatorsTableViewController : UITableViewController
@property (strong, nonatomic) NSString* userAddress;
@property (nonatomic, strong) NSArray *legislators;
@property (nonatomic,strong) NSString *errorMsg;
@end
