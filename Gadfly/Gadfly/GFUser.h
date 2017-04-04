#import "GFPoli.h"
#import "GFScript.h"
#import "GFTag.h"

#import <Foundation/Foundation.h>

@interface GFUser : NSObject

@property bool initialized;


- (GFUser *)init;
+ (void)cachePolis:(NSArray *)polis;
+ (NSArray *)getPolis;
- (void)reset;

@end
