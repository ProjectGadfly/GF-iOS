#import "GFScript.h"

static const NSString *idURL = @"http://gfserver/services/v1/id/";
static const NSString *scriptURL = @"http://gfserver/services/v1/script/";
static const NSString *apiKey = @"";
const NSTimeInterval timeoutInterval = 60.0;

@implementation GFScript

- (GFScript *)initWithDictionary:(NSDictionary *)dict {
    GFScript *script=[GFScript new];
    script.title=[dict valueForKey:@"title"];
    script.content=[dict valueForKey:@"content"];
    if ([dict valueForKey:@"tags"]!=(id)[NSNull null]) {
        script.tags=[NSMutableArray new];
        for (NSString *tag in [dict valueForKey:@"tags"]) {
            [script.tags addObject:tag];
        }
    }
    return script;
}

+ (void)fetchIDtWithTicket:(NSString *)ticket
         completionHandler:(void(^_Nonnull)(NSInteger))completion {
    NSMutableArray *queryItems = [NSMutableArray<NSURLQueryItem *> new];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"ticket" value:ticket]];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:idURL];
    components.queryItems = queryItems;
    NSURL *URL = components.URL;
    
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
        NSInteger ID=data;
        completion(ID);
    }];
    [task resume];
}

+ (void)fetchScriptWithID:(NSString *)ID
        completionHandler:(void(^_Nonnull)(GFScript *))completion {
    NSMutableArray *queryItems = [NSMutableArray<NSURLQueryItem *> new];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"id" value:ID]];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:scriptURL];
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

+ (void)postScriptWithScript:(GFScript *)script {
    NSDictionary *dictOfTags = [GFTag fetchTags];
    NSMutableArray *arrOfTagID = [NSMutableArray new];
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setValue:script.title forKey:@"title"];
    [dict setValue:script.content forKey:@"content"];
    if (script.tags !=(id)[NSNull null]){
        for (NSString *tag in script.tags){
            NSString *ID = [dictOfTags valueForKey:tag];
            [arrOfTagID addObject:ID];
        }
        [dict setValue:arrOfTagID forKey:@"tags"];
    }
    if (script.expirationDate !=(id)[NSNull null]){
        [dict setValue:script.expirationDate forKey:@"expiration_date"];
    }
    if (script.email !=(id)[NSNull null]){
        [dict setValue:script.email forKey:@"email"];
    }
    NSError *JsonConvertionError;
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&JsonConvertionError];
    NSString *bodyLength = [NSString stringWithFormat:@"%lu",(unsigned long)[bodyData length]];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:scriptURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [req setHTTPMethod:@"POST"];
    [req setValue:apiKey forHTTPHeaderField:@"key"];
    [req setValue:bodyLength forHTTPHeaderField:@"Content-Length"];
    [req setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    [req setHTTPBody:bodyData];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Post Script Unseccessful!");
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

+ (void)deleteScriptWithTicket:(NSString *)ticket {
    NSMutableArray *queryItems = [NSMutableArray<NSURLQueryItem *> new];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"ticket" value:ticket]];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:scriptURL];
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
        if (data == 200){
            NSLog(@"Delete Successful!");
        }
        else NSLog(@"Delete Unsuccessful!");
    }];
    [task resume];
}

@end
