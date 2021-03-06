#import "GFUser.h"
#import "GFPoli.h"
#import "GFTag.h"

#import <Foundation/Foundation.h>

@interface GFScript : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSMutableArray *tags;

+ (void)cacheID:(NSString *)scriptID;

+ (NSString *)getID;

- (GFScript *)initWithDictionary:(NSDictionary *)dict;

/*!
 @discussion No matter success or failure, this method directly returns the dictionary returned by
 the API. See Web-Server Wiki on Github.
 */
+ (void)fetchIDtWithTicket:(NSString *)ticket
         completionHandler:(void(^_Nonnull)(NSDictionary *))completion;

/*!
 @discussion Upon Success, this method returns a GFScript Object corresponding to the ID. Upon Failure,
 this method returns a fake GFScript Object whose title contains the error message.
 */
+ (void)fetchScriptWithID:(NSString *)ID
        completionHandler:(void(^_Nonnull)(GFScript *))completion;

@end
