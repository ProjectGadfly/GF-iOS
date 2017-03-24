#import "GFScript.h"

static const NSString *getScriptURL = @"http://127.0.0.1:5000/services/v1/getscript";
static const NSString *delScriptURL = @"http://127.0.0.1:5000/services/v1/delscript";
static const NSString *apiKey = @"";
const NSTimeInterval timeoutInterval = 60.0;

@implementation GFScript

- (GFScript *)initWithDictionary:(NSDictionary *)dict {
    GFScript *script=[GFScript new];
    script.title=[dict valueForKey:@"title"];
    script.content=[dict valueForKey:@"content"];
    return script;
}

+ (void)fetchScriptWithID:(NSString *)ID
        completionHandler:(void(^_Nonnull)(GFScript *))completion {
    NSMutableArray *queryItems = [NSMutableArray<NSURLQueryItem *> new];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"scriptID" value:ID]];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:getScriptURL];
    components.queryItems = queryItems;
    NSURL *URL = components.URL;
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [req setHTTPMethod:@"GET"];
    [req setValue:apiKey forHTTPHeaderField:@"key"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Fetch Script Unseccessful!");
            return;
        }
        if (!(response)){
            NSLog(@"No Response!");
            return;
        }
        NSLog(@"Successful!");
        NSDictionary *scriptData=[NSDictionary new];
        NSError *JSONParsingError;
        scriptData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONParsingError];
        GFScript *script=[[GFScript alloc]initWithDictionary:scriptData];
        completion(script);
    }];
    [task resume];
}

+ (void)deleteScriptWithID:(NSString *)ID {
    NSMutableArray *queryItems = [NSMutableArray<NSURLQueryItem *> new];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"scriptID" value:ID]];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:delScriptURL];
    components.queryItems = queryItems;
    NSURL *URL = components.URL;
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [req setHTTPMethod:@"DELETE"];
    [req setValue:apiKey forHTTPHeaderField:@"key"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Delete Script Unseccessful!");
            return;
        }
        if (!(response)){
            NSLog(@"No Response!");
            return;
        }
        NSLog(@"Successful!");
    }];
    [task resume];
}

@end
