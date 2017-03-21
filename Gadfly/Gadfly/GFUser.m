

#import "GFUser.h"

@implementation GFUser

- (GFUser *)initWithAddress:(NSString *)address{
    GFUser *user;
    user.address=address;
    user.initialized=true;
    
    return user;
}

@end
