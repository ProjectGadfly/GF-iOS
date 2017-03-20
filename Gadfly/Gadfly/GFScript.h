#import "GFUser.h"
#import "GFRep.h"

#import <Foundation/Foundation.h>

@interface GFScript : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *ID;

- (GFScript *)initWithDictionary:(NSDictionary *)dict;

+ (void)storeScriptToServer:(GFScript *)script;

+ (void)fetchScriptWithID:(NSString *)ID
        completionHandler:(void(^_Nonnull)(GFScript *))completion;

@end
