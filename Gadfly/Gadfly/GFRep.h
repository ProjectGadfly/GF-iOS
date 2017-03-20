#import <Foundation/Foundation.h>
#import "GFUser.h"
#import "GFScript.h"

typedef enum {Federal, State} GFRepType;

@interface GFRep : NSObject

@property (nonatomic) GFRepType type;
@property (nonatomic,strong,nonnull) NSString *firstName;
@property (nonatomic,strong,nonnull) NSString *lastName;
@property (nonatomic,strong,nullable) NSString *picURL;
@property (nonatomic,strong,nonnull) NSString *phone;
@property (nonatomic,strong,nullable) NSString *email;
@property (nonatomic,strong,nullable) NSString *address;

- (GFRep *)initWithDictionary:(NSDictionary *)dict;

+ (void)fetchRepsWithUser:(GFUser *)user
        completionHandler:(void(^_Nonnull)(NSArray<GFRep *> *))completion;

@end
