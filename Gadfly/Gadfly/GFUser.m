#import "GFUser.h"

@implementation GFUser

- (GFUser *)initWithAddress:(NSString *)address{
    GFUser *user = [GFUser new];
    user.address=address;
    user.initialized=true;
    
    return user;
}

- (void)editAddress:(NSString *)address {
    self.address=address;
}

- (void)forget {
    self.address=(NSString *)[NSNull null];
}

- (void)reset {
    self.address=(NSString *)[NSNull null];
    self.initialized=false;
}

@end
