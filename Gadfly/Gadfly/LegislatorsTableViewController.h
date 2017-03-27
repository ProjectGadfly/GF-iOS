/*
 @file Custom UITableViewContorller class
 */

#import <UIKit/UIKit.h>

@interface LegislatorsTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet LegislatorsTableViewController *dataSource;
@property (strong, nonatomic) IBOutlet LegislatorsTableViewController *delegate;
@property (nonatomic, strong) NSMutableArray *legislators;
@end
