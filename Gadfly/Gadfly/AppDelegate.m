#import "AppDelegate.h"
#import "Legislator.h"
#import "LegislatorViewController.h"
#import "ApplicationConstraints.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

NSMutableArray *_legislators;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //creating an array with specified capacity
    _legislators = [NSMutableArray arrayWithCapacity:MAX_LEGIS];
    
    
    
    //making and initializing a Legislator object
    Legislator *legislator = [[Legislator alloc] init];
    legislator.name = @"Dick Durbin";
    legislator.email = @"state_scheduler@durbin.senate.gov";
    legislator.phone = @"202-224-2152";
    //adds Legislator object to array
    [_legislators addObject:legislator];
    
    //Esther's messing around
    Legislator *legislator2 = [[Legislator alloc] init];
    legislator2.name = @"Tammy Duckworth";
    legislator2.email = @"scheduling@duckworth.senate.gov";
    legislator2.phone = @"202-224-2854";
    //adds Legislator object to array
    [_legislators addObject:legislator2];
    
    Legislator *legislator3 = [[Legislator alloc] init];
    legislator3.name = @"Tim Duckworth";
    legislator3.email = @"scheduling@duckworth.senate.gov";
    legislator3.phone = @"202-224-2854";
    //adds Legislator object to array
    [_legislators addObject:legislator3];
     
    
    //something related to transitions from pages
    LegislatorViewController *legController = (LegislatorViewController *)self.window.rootViewController;
    legController.legislators = _legislators;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
