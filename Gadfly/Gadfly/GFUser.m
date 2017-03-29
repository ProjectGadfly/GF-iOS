

#import "GFUser.h"

@implementation GFUser

- (GFUser *)initWithAddress:(NSString *)address{
    GFUser *user=[GFUser new];
    user.address=address;
    user.initialized=true;
    
    return user;
}

@end
