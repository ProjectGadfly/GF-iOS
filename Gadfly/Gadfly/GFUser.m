#import "GFUser.h"

@implementation GFUser

- (GFUser *)init {
    GFUser *user=[GFUser new];
    self.initialized=true;
    return user;
}

- (void)reset {
    self.initialized=false;
}

@end
