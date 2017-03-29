#import "GFUser.h"
#import "GFPoli.h"
#import "GFTag.h"

#import <Foundation/Foundation.h>

@interface GFScript : NSObject

@property (nonatomic,strong,nonnull) NSString *title;
@property (nonatomic,strong,nonnull) NSString *content;
@property (nonatomic,strong,nullable) NSMutableArray *tags;

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
+ (void)fetchScriptWithID:(NSInteger)ID
        completionHandler:(void(^_Nonnull)(GFScript *))completion;

@end
