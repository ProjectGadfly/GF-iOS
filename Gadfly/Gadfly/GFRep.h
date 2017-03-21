#import <Foundation/Foundation.h>

#import "GFScript.h"
@class GFUser;

typedef enum {Federal, State} GFRepType;

@interface GFRep : NSObject

@property (nonatomic) GFRepType type;
@property (nonatomic,strong,nonnull) NSString *name;
@property (nonatomic,strong,nullable) NSString *picURL;
@property (nonatomic,strong,nonnull) NSString *phone;
@property (nonatomic,strong,nullable) NSString *email;

- (GFRep *)initWithDictionary:(NSDictionary *)dict;

+ (void)fetchRepsWithUser:(GFUser *)user
        completionHandler:(void(^_Nonnull)(NSArray<GFRep *> *))completion;

- (void)printInfo;

@end
