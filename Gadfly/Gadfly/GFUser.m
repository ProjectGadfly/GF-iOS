#import "GFUser.h"

static NSString *user_address;
static NSArray *user_polis;

@implementation GFUser

- (GFUser *)init {
    GFUser *user=[GFUser new];
    self.initialized=true;
    return user;
}

- (void)reset {
    self.initialized=false;
}

+ (void)cacheAddress:(NSString *)address {
    user_address=address;
}

+ (NSString *)getAddress {
    return user_address;
}

+ (void)cachePolis:(NSArray *)polis {
    user_polis=polis;
}

+ (NSArray *)getPolis {
    return user_polis;
}

@end
