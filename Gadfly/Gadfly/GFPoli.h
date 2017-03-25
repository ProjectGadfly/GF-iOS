#import <Foundation/Foundation.h>
#import "GFTag.h"
#import "GFScript.h"
@class GFUser;

@interface GFPoli : NSObject

@property (nonatomic,strong,nonnull) NSString *name;
@property (nonatomic,strong,nonnull) NSString *party;
@property (nonatomic,strong,nullable) NSString *picURL;
@property (nonatomic,strong,nullable) NSString *phone;
@property (nonatomic,strong,nullable) NSString *email;
@property (nonatomic,strong,nullable) NSMutableArray *tags;

- (GFPoli *)initWithDictionary:(NSDictionary *)dict;

+ (void)fetchPoliWithUser:(GFUser *)user
         completionHandler:(void(^_Nonnull)(NSArray<GFPoli *> *))completion;

- (void)printInfo;

@end
