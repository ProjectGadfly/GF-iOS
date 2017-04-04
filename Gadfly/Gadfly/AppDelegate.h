#import <UIKit/UIKit.h>
#import "Legislator.h"
#import "LegislatorsTableViewController.h"
#import "LegislatorTableViewCell.h"
#import "ApplicationConstraints.m"
#import "GadflyAPI.h"
#import "BarcodeScannerViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *legislatorData;

@end
