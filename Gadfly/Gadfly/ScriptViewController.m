#import "ScriptViewController.h"
#import "LegislatorTableViewCell.h"
#import "LegislatorsTableViewController.h"
#import "Legislator.h"
#import "ApplicationConstraints.m"

@interface ScriptViewController ()

@property (nonatomic, assign) id delegate;
//@property (weak, nonatomic) IBOutlet UITableView *legislatorTable;

@end

@implementation ScriptViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _legislatorTable.dataSource = self;
    _legislatorTable.delegate = self;
    self.legislators = [self getLegislatorDataFromWebservice]; // uses server call @see getLegislatorDataFromWebservice
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.legislatorTable.delegate = self;
}

// @brief method to simulate API by connecting to mpls.cx and reading sample json
// @discussion not currently working
- (NSMutableArray*)getLegislatorDataFromWebservice
{
    NSLog(@"start webservice method");
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
            //UITableViewController *tvc = (UITableViewController *)self;
           // [tvc.tableView reloadData]; //refresh table view after data is fetched // BUG HERE not a table view controller
            [self.legislatorTable reloadData];
        }];
    }];
    
    [dataTask resume];
    NSLog(@"%@", temp_legislators);
    return temp_legislators;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// @brief Change if multiple sections are wanted.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"start num sections method");
    return 1;
}

// @brief We want one cell for each legislator.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"start num rows method");
    return [self.legislators count];
}

// @brief method to dequeue and populate custom cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"start cell for row method");
    LegislatorTableViewCell *cell = (LegislatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LegislatorCell"];
    
    Legislator *legislator = (self.legislators)[indexPath.row];
    cell.nameLabel.text = legislator.name;
    cell.phoneLabel.text = legislator.phone;
    
    NSData *image_data = [NSData dataWithContentsOfURL:legislator.photo_url];
    UIImage *image = [UIImage imageWithData:image_data];
    cell.legImage.image = image;
    return cell;
}

/* @brief, hack to fix cell height
 @discussion Cell height is currently hard-coded, cell height should eventually be determined by amount of content in the cell
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LegislatorTableViewCell *cell = (LegislatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LegislatorCell"];
    Legislator *legislator = (self.legislators)[indexPath.row];
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:legislator.phone];
    NSLog(@"The number is %@", phoneNumber);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
