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

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    // @brief methods to simulate API calls
    
    self.legislators = [self getLegislatorDataFromWebservice]; // uses server call @see getLegislatorDataFromWebservice
    //self.legislators = [self getLegislatorData]; //uses local data @see getLegislatorData
}


// @brief method to simulate API by connecting to mpls.cx and reading sample json
// @discussion not currently working
- (NSMutableArray*)getLegislatorDataFromWebservice
{
    //NSLog(@"start webservice method");
    NSMutableArray *temp_legislators = [NSMutableArray arrayWithCapacity:LEG_ARRAY_SIZE];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://mpls.cx/foo/foo.pl"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [json enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *offices = obj[@"offices"][0]; //Get dict from one element array
            NSString *current_phone = offices[@"phone"];
            NSString *current_name = obj[@"full_name"];
 
            //NSLog(@"%@", image_data);
            Legislator *legislator = [[Legislator alloc] init];
            legislator.name = current_name;
            legislator.phone = current_phone;
            legislator.photo_url = [NSURL URLWithString:obj[@"photo_url"]];
            [temp_legislators addObject:legislator];
            [self.tableView reloadData]; //refresh table view after data is fetched
        }];
    }];

    [dataTask resume];
    return temp_legislators;
}

/*
// @brief method to simular API by using sample data
- (NSMutableArray*) getLegislatorData
{
    NSMutableArray *legislators = [NSMutableArray arrayWithCapacity:LEG_ARRAY_SIZE];
    
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
}*/


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
    return [self.legislators count];
}

// @brief method to dequeue and populate custom cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LegislatorTableViewCell *cell = (LegislatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LegislatorCell"];
    
    Legislator *legislator = (self.legislators)[indexPath.row];
    cell.nameLabel.text = legislator.name;
    cell.phoneLabel.text = legislator.phone;
    
    NSData *image_data = [NSData dataWithContentsOfURL:legislator.photo_url];
    UIImage *image = [UIImage imageWithData:image_data];
    cell.legImage.image = image;
    return cell;
}

// @brief Segue between splash page and legislator page
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showLegislators"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        LegislatorsTableViewController *legislatorsTableViewController = [navigationController viewControllers][0];
        legislatorsTableViewController.delegate = self;
    }
}

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
    
    Legislator *legislator = (self.legislators)[indexPath.row];
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:legislator.phone];
    NSLog(@"The number is %@", phoneNumber);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

@end
