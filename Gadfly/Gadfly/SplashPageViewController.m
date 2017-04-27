/*
 @file Custom controller for splash page
 */

#import "SplashPageViewController.h"

@interface SplashPageViewController ()

@end

@implementation SplashPageViewController
@synthesize userInput;

- (void)viewDidLoad {
    [super viewDidLoad];
    [GFTag initTags]; // method to get tag dictionary from server, may not need to be called this often
    // Do any additional setup after loading the view, typically from a nib.
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitPressed:(id)sender {
    //self.userAddress = [NSString alloc];
    NSString *tempAddress = userInput.text;
    tempAddress = [tempAddress stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [GFUser cacheAddress:tempAddress];
    NSLog(@"finished caching address!!!!!!!!!!");
    //NSLog(@"%@",self.userAddress);
    [userInput endEditing:YES];
    //NSLog(@"Received: %@", self.userAddress);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"Start new segue method");
    if ([segue.identifier isEqualToString:@"showLegislators"]) {
        //NSLog(@"right segue");
        //LegislatorsTableViewController *legislatorsTableViewController = [segue destinationViewController];
        //NSLog(@"The addresus passing is %@",self.userAddress);
        //legislatorsTableViewController.userAddress = self.userAddress; // MUST DELETE USER ADDRESS FOR SECURITY
        //legislatorsTableViewController.legislators = self.legislators;
        //NSLog(@"The address passed is %@",legislatorsTableViewController.userAddress);
    }
    /*
    [GFPoli fetchPoliWithAddress:self.userAddress completionHandler: ^void(NSArray *arr){
        LegislatorsTableViewController *legislatorsTableViewController = [segue destinationViewController];
        if ([arr count]<2) {
            legislatorsTableViewController.errorMsg=arr[0];
        }
        else {
            legislatorsTableViewController.legislators=arr;
            //legislatorsTableViewController.legislators = self.legislators;
            //NSLog(@"new stuff %@", legislatorsTableViewController.legislators[0]);
            //[legislatorsTableViewController.tableView reloadData];
        }
    }];*/

}

- (void)dismissKeyBoard {
    [self.view endEditing:YES];
}

@end
