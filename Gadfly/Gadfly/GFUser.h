#import "GFRep.h"
#import "GFScript.h"

#import <Foundation/Foundation.h>

@interface GFUser : NSObject

@property bool initialized;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSMutableArray *IDs;

- (GFUser *)initWithAddress:(NSString *)address;
- (void)makePhoneCallWithNumber: (NSString*)number;
+ (void)forget;
+ (void)reset;

@end
