#import "ViewController.h"
#import "LegislatorViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLegislators"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //LegislatorViewController *destViewController = segue.destinationViewController;
        //destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
    }
}

- (IBAction)submitPressed:(id)sender {
    [self performSegueWithIdentifier:@"showLegislators" sender:self];
}


@end
