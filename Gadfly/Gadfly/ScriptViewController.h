#import <UIKit/UIKit.h>
#import "LegislatorTableViewCell.h"
#import "LegislatorsTableViewController.h"
#import "Legislator.h"
#import "ApplicationConstraints.m"
#import "GFScript.h"
#import "GFPoli.h"


@interface ScriptViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//@interface ScriptViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *scriptTitle;
@property (weak, nonatomic) IBOutlet UITextView *callScript;
@property (weak, nonatomic) IBOutlet UILabel *scriptTags;
@property (nonatomic, strong) NSMutableArray *legislators;
@property (nonatomic, strong) IBOutlet UITableView *legislatorTable;
@property (strong, nonatomic) NSString *scriptID;
@property (strong, nonatomic) GFScript *script;
@end
