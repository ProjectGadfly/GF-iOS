#import "GFPoli.h"
#import "GFScript.h"

#import <Foundation/Foundation.h>

@interface GFUser : NSObject

@property bool initialized;
@property (nonatomic,strong) NSString *address;

- (GFUser *)initWithAddress:(NSString *)address;
- (void)editAddress:(NSString *)address;
- (void)forget;
- (void)reset;

@end
