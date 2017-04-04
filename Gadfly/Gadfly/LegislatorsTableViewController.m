/*
 @file Custom UITableViewContorller class
 */

#import "LegislatorsTableViewController.h"
#import "Legislator.h"
#import "LegislatorTableViewCell.h"
#import "ApplicationConstraints.m"
#import "GFPoli.h"
#import "GFUser.h"

@interface LegislatorsTableViewController ()
@property (nonatomic, assign) id delegate;
@end

@implementation LegislatorsTableViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Call to API
    NSString *address = [GFUser getAddress];
    NSLog(@"Address is %@",address);
    [GFPoli fetchPoliWithAddress:address completionHandler: ^void(NSArray *arr){
        if ([arr count]<2) {
            self.errorMsg=arr[0];
        }
        else {
            NSArray *polis=arr;
            [GFUser cachePolis:arr];
            NSLog(@"FirstPolis!!!!!!!!%@",[GFUser getPolis]);
            dispatch_async(dispatch_get_main_queue(), ^(void){
                //NSLog(@"start to reload data!!!!!!!!");
                [self.tableView reloadData];
            });
        }
    }];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// @brief Change if multiple sections are wanted.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// @brief We want one cell for each legislator.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"num legs: %lu", [self.legislators count]);
    return [[GFUser getPolis] count];
}

// @brief method to dequeue and populate custom cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LegislatorTableViewCell *cell = (LegislatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LegislatorCell"];
    
    NSArray *polis = [GFUser getPolis];
    NSLog(@"Polis!!!!!!!%@",polis);
    GFPoli *legislator = polis[indexPath.row];
    cell.nameLabel.text = legislator.name;
    cell.phoneLabel.text = legislator.phone;
    NSString *tagNames=@"";
    
    NSDictionary *tagDict=[GFTag getTags];
    for (id tag_id in legislator.tags) {
        NSLog(@"%@",tag_id);
        //NSLog(@"it is a string: T/f: %d", [tag_id isKindOfClass:[NSString class]]);
        //NSString *ID = (NSString *)tag_id;
        //NSLog(@"%@",ID);
        //NSLog(@"it is a string: T/f: %d", [ID isKindOfClass:[NSString class]]);
        NSString *tag_name=[tagDict valueForKey:[NSString stringWithFormat:@"%@",tag_id]];
        NSLog(@"tag_name!!!!!!!%@",tag_name);
        tagNames=[tagNames stringByAppendingString:tag_name];
        NSLog(@"tagnames first!!!!!!!!!!%@",tagNames);
        tagNames=[tagNames stringByAppendingString:@" "];
        NSLog(@"tagnames!!!!!!!!!!%@",tagNames);
    }
    NSLog(@"tag!!!!!!!!!%@",tagNames);
    cell.tagsLabel.text = tagNames;
    
    cell.partyLabel.text = legislator.party;
    
    NSURL *pic=[NSURL URLWithString:legislator.picURL];
    NSData *image_data = [NSData dataWithContentsOfURL:pic];
    UIImage *image = [UIImage imageWithData:image_data];
    cell.legImage.image = image;
    return cell;
    /*
    LegislatorTableViewCell *cell = (LegislatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LegislatorCell"];
    
    Legislator *legislator = (self.legislators)[indexPath.row];
    cell.nameLabel.text = legislator.name;
    cell.phoneLabel.text = legislator.phone;
    cell.tagsLabel.text = legislator.tags;
    
    NSData *image_data = [NSData dataWithContentsOfURL:legislator.photo_url];
    UIImage *image = [UIImage imageWithData:image_data];
    cell.legImage.image = image;
    return cell;
  */
}

/*
// @brief Segue between splash page and legislator page
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{ 
    NSLog(@"HERERERERERE22222");
   
    if ([segue.identifier isEqualToString:@"showLegislators"]) {
        
        UINavigationController *firstNavigationController = segue.destinationViewController;
        LegislatorsTableViewController *legislatorsTableViewController = [firstNavigationController viewControllers][0];
        legislatorsTableViewController.delegate = self;
        UINavigationController *secondNavigationController = segue.sourceViewController;
        SplashPageViewController *splashPageViewController = [secondNavigationController viewControllers][0];
        NSLog(@"The address passing is %@",splashPageViewController.userAddress);
        self.userAddress = splashPageViewController.userAddress; // MUST DELETE USER ADDRESS FOR SECURITY
        NSLog(@"The address passed is %@",self.userAddress);
    }
   
 
    if ([segue.identifier isEqualToString:@"showLegislators"]) {
        //UINavigationController *firstNavigationController = segue.destinationViewController;
        //LegislatorsTableViewController *legislatorsTableViewController = [firstNavigationController viewControllers][0];
        self.delegate = self;
 
    }
}*/


/* @brief, hack to fix cell height
   @discussion Cell height is currently hard-coded, cell height should eventually be determined by amount of content in the cell
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

// @brief Empty method used for debugging. 
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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LegislatorTableViewCell *cell = (LegislatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LegislatorCell"];
    GFPoli *poli = [GFUser getPolis][indexPath.row];
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:poli.phone];
    NSLog(@"The number is %@", phoneNumber);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

@end
