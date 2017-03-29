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
    // Do any additional setup after loading the view, typically from a nib.
 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitPressed:(id)sender {
    self.userAddress = [NSString alloc];
    self.userAddress = userInput.text;
    [userInput endEditing:YES];
    NSLog(@"Received: %@", self.userAddress);
}

- (void)dismissKeyBoard {
    [self.view endEditing:YES];
}

@end
