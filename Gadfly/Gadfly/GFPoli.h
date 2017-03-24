#import <Foundation/Foundation.h>

#import "GFScript.h"
@class GFUser;

typedef enum {FederalSenate, FederalRep, StateSenate, StateRep} GFPoliType;

@interface GFPoli : NSObject

@property (nonatomic) GFPoliType type;
@property (nonatomic,strong,nonnull) NSString *name;
@property (nonatomic,strong,nonnull) NSString *party;
@property (nonatomic,strong,nullable) NSString *picURL;
@property (nonatomic,strong,nullable) NSString *phone;
@property (nonatomic,strong,nullable) NSString *email;

- (GFPoli *)initWithDictionary:(NSDictionary *)dict;

+ (void)fetchStateWithUser:(GFUser *)user
         completionHandler:(void(^_Nonnull)(NSArray<GFPoli *> *))completion;

+ (void)fetchFedWithUser:(GFUser *)user
       completionHandler:(void(^_Nonnull)(NSArray<GFPoli *> *))completion;

- (void)printInfo;

@end
