#import "GFUser.h"
#import "GFPoli.h"

#import <Foundation/Foundation.h>

@interface GFScript : NSObject

@property (nonatomic,strong,nonnull) NSString *title;
@property (nonatomic,strong,nonnull) NSString *content;

- (GFScript *)initWithDictionary:(NSDictionary *)dict;

+ (void)fetchScriptWithID:(NSString *)ID
        completionHandler:(void(^_Nonnull)(GFScript *))completion;

+ (void)deleteScriptWithID:(NSString *)ID;

@end
