#import "ScriptViewController.h"

@interface ScriptViewController ()

//@property (nonatomic, assign) id delegate;

@end

@implementation ScriptViewController

//@synthesize delegate;

- (void)viewDidLoad {
    // Load the view
    [super viewDidLoad];
    // Additional setup after loading the view.
    _legislatorTable.dataSource = self;
    _legislatorTable.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Get script id from GFScript class
    self.scriptID=[GFScript getID];
    
    // API Call
    [GFScript fetchScriptWithID:self.scriptID completionHandler:^(GFScript *script) {
        self.script=script;
        // Fill UI elements
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"Start to reload data on script page");
            _scriptTitle.text = _script.title;
            NSLog(@"title %@", _script.title);
            _callScript.text = _script.content;
            NSLog(@"content %@", _script.content);
            // If there are tags, unwrap them
            if(_script.tags){
                NSDictionary *tagDict=[GFTag getTags];
                NSString *tagNames=@"";
                for (id tag_id in _script.tags) {
                    NSString *tag_name=[tagDict valueForKey:[NSString stringWithFormat:@"%@",tag_id]];
                    tagNames=[tagNames stringByAppendingString:@" "];
                    tagNames=[tagNames stringByAppendingString:tag_name];
                }
                tagNames=[tagNames stringByAppendingString:@"s"]; //Pluralize
                _scriptTags.text = [_scriptTags.text stringByAppendingString:[tagNames capitalizedString]];

            }
        });
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.legislatorTable.delegate = self;
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
    NSLog(@"number of polis: %ld", [[GFUser getPolis] count]);
    return [[GFUser getPolis] count];
}

// @brief Method to dequeue and populate custom cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LegislatorTableViewCell *cell = (LegislatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LegislatorCell"];
    
    NSArray *polis = [GFUser getPolis];
    GFPoli *poli = polis[indexPath.row];
    cell.nameLabel.text = poli.name;
    NSLog(@"Poli: %@", poli.name);
    cell.phoneLabel.text = poli.phone;
    cell.partyLabel.text = poli.party;
    
    NSString *tagNames=@"";
    
    NSDictionary *tagDict=[GFTag getTags];
    for (id tag_id in poli.tags) {
        //NSLog(@"%@",tag_id);
        NSString *tag_name=[tagDict valueForKey:[NSString stringWithFormat:@"%@",tag_id]];
        tagNames=[@" " stringByAppendingString:tagNames];
        //NSLog(@"tag_name!!!!!!!%@",tag_name);
        tagNames=[tag_name stringByAppendingString:tagNames];
        //NSLog(@"tagnames first!!!!!!!!!!%@",tagNames);
        
        NSLog(@"tagnames!!!!!!!!!!%@",tagNames);
    }
   // NSLog(@"tag!!!!!!!!!%@",tagNames);
    cell.tagsLabel.text = [tagNames capitalizedString];
    
    NSURL *picURL=[NSURL URLWithString:poli.picURL];
    NSData *image_data = [NSData dataWithContentsOfURL:picURL];
    UIImage *image = [UIImage imageWithData:image_data];
    cell.legImage.image = image;
    return cell;
}

/* @brief Hack to fix cell height
 @discussion Cell height is currently hard-coded, cell height should eventually be determined by amount of content in the cell
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// @brief Method to prompt call to legislator if cell is tapped
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LegislatorTableViewCell *cell = (LegislatorTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LegislatorCell"];
    GFPoli *poli = [GFUser getPolis][indexPath.row];
    if (poli.phone) {
        NSString *phoneNumber = [@"telprompt://" stringByAppendingString:poli.phone];
        NSLog(@"The number is %@", poli.phone);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No phone number"
                                                                       message:@"This representative does not have a phone number in our database."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
