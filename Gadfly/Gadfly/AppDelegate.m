#import "AppDelegate.h"
#import "Legislator.h"
#import "LegislatorsTableViewController.h"
#import "LegislatorTableViewCell.h"
#import "ApplicationConstraints.m"

@interface AppDelegate ()

@end

@implementation AppDelegate

{
    NSMutableArray *_legislators;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _legislators = [NSMutableArray arrayWithCapacity:legArraySize];
    /*
    Legislator *legislator = [[Legislator alloc] init];
    legislator.name = @"Joe Goodguy";
    legislator.phone = @"555-555-5555";
    [_legislators addObject:legislator];
    
    legislator = [[Legislator alloc] init];
    legislator.name = @"Sue Democrat";
    legislator.phone = @"666-666-6666";
    [_legislators addObject:legislator];
    
    legislator = [[Legislator alloc] init];
    legislator.name = @"Rogue Politican";
    legislator.phone = @"123-456-7899";
    [_legislators addObject:legislator];
    
    //something related to transitions from pages
    LegislatorsTableViewController *legController = (LegislatorsTableViewController *)self.window.rootViewController;
   // UINavigationController *navigationController = [UITabBarController viewControllers][0]; BUG HERE
  //  LegislatorsTableViewController *playersViewController = [navigationController viewControllers][0]; BUG HERE
    legController.legislators = _legislators;
     */
    
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
