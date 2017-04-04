#import <UIKit/UIKit.h>
#import "LegislatorTableViewCell.h"
#import "LegislatorsTableViewController.h"
#import "Legislator.h"
#import "ApplicationConstraints.m"

@interface ScriptViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *scriptTitle;
@property (weak, nonatomic) IBOutlet UITextView *callScript;
@property (nonatomic, strong) NSMutableArray *legislators;
@property (nonatomic, strong) IBOutlet UITableView *legislatorTable;
@end
