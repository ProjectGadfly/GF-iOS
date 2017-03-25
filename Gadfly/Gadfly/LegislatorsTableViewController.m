#import "LegislatorsTableViewController.h"
#import "Legislator.h"
#import "LegislatorTableViewCell.h"
#import "ApplicationConstraints.m"

@interface LegislatorsTableViewController ()

@property (nonatomic, assign) id delegate;

@end

@implementation LegislatorsTableViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.legislators = [self getLegislatorData];
    
}

- (NSMutableArray*) getLegislatorData
{
    NSMutableArray *legislators = [NSMutableArray arrayWithCapacity:legArraySize];
    
    Legislator *legislator = [[Legislator alloc] init];
    legislator.name = @"Joe Goodguy";
    legislator.phone = @"555-555-5555";
    [legislators addObject:legislator];
    
    legislator = [[Legislator alloc] init];
    legislator.name = @"Sue Democrat";
    legislator.phone = @"666-666-6666";
    [legislators addObject:legislator];
    
    legislator = [[Legislator alloc] init];
    legislator.name = @"Rogue Politican";
    legislator.phone = @"123-456-7899";
    [legislators addObject:legislator];
    
    return legislators;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.legislators count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LegislatorTableViewCell *cell = (LegislatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LegislatorCell"];
    
    Legislator *legislator = (self.legislators)[indexPath.row];
    cell.nameLabel.text = legislator.name;
    cell.phoneLabel.text = legislator.phone;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showLegislators"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        LegislatorsTableViewController *legislatorsTableViewController = [navigationController viewControllers][0];
        legislatorsTableViewController.delegate = self;
    }
}



/*
- (void)setLegislators:(NSMutableArray *)legislators
{
    
}
*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
