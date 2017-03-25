#import "GFTag.h"

static NSMutableDictionary *dictOfTags;

static const NSString *URL = @"http://gfserver/services/v1/alltags/";
static const NSString *apiKey = @"";
const NSTimeInterval timeoutInterval = 60.0;

@implementation GFTag

+ (void)initTags {
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [req setHTTPMethod:@"GET"];
    [req setValue:apiKey forHTTPHeaderField:@"key"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Fetch ID Unseccessful!");
            return;
        }
        if (!(response)){
            NSLog(@"No Response!");
            return;
        }
        NSLog(@"Successful!");
        
        NSError *JSONParsingError;
        dictOfTags = [NSMutableDictionary new];
        dictOfTags = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONParsingError];
    }];
    [task resume];
}

+ (NSDictionary *)fetchTags {
    return dictOfTags;
}

@end
