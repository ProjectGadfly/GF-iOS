#import <UIKit/UIKit.h>

/* @file, makes a subclass LegislatorViewController of UITableViewController
    Also makes a variable-sized array of legislators to be displayed on the LegislatorViewController
 */
@interface LegislatorViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *legislators;
@end
