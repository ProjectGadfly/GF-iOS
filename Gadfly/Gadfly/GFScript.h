#import "GFUser.h"
#import "GFPoli.h"
#import "GFTag.h"

#import <Foundation/Foundation.h>

@interface GFScript : NSObject

@property (nonatomic,strong,nonnull) NSString *title;
@property (nonatomic,strong,nonnull) NSString *content;
@property (nonatomic,strong,nullable) NSMutableArray *tags;
@property (nonatomic,strong,nullable) NSString *expirationDate;
@property (nonatomic,strong,nullable) NSString *email;

- (GFScript *)initWithDictionary:(NSDictionary *)dict;

+ (void)fetchIDtWithTicket:(NSString *)ticket
        completionHandler:(void(^_Nonnull)(NSInteger))completion;

+ (void)fetchScriptWithID:(NSString *)ID
        completionHandler:(void(^_Nonnull)(GFScript *))completion;

+ (void)postScriptWithScript:(GFScript *)script;

+ (void)deleteScriptWithTicket:(NSString *)ticket;

@end
