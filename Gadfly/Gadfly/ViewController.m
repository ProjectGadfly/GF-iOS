#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GFUser *user = [[GFUser alloc]initWithAddress:@"Grinnell+College"];
    
    [GFPoli fetchFedWithUser:user completionHandler:^void (NSArray<GFPoli *> *polis) {
        for (GFPoli *p in polis){
            [p printInfo];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
} 


@end
