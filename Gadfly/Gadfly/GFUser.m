#import "GFUser.h"

static NSArray *userPolis;

@implementation GFUser

- (GFUser *)init{
    GFUser *user=[GFUser new];
    self.initialized=true;
    return user;
}

+ (void)cachePolis:(NSArray *)polis {
    userPolis=polis;
}

+ (NSArray *)getPolis {
    return userPolis;
}

- (void)reset {
    self.initialized=false;
}

@end
