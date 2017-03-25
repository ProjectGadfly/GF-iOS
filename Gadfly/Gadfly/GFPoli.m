#import "GFPoli.h"

static const NSString *URL = @"http://gfserver/services/v1/representatives/";
static const NSString *apiKey = @"";
const NSTimeInterval timeoutInterval = 60.0;

@implementation GFPoli

- (GFPoli *)initWithDictionary:(NSDictionary *)dict{
    
    GFPoli * poli = [GFPoli new];
    poli.name = [dict valueForKey:@"name"];
    poli.party = [dict valueForKey:@"party"];
    if ([dict valueForKey:@"phone"]!=(id)[NSNull null]) {
        poli.phone = [dict valueForKey:@"phone"];
    }
    if ([dict valueForKey:@"email"]!=(id)[NSNull null]) {
        poli.email = [dict valueForKey:@"email"];
    }
    if ([dict valueForKey:@"picURL"]!=(id)[NSNull null]) {
        poli.picURL = [dict valueForKey:@"picURL"];
    }
    if ([dict valueForKey:@"tags"]!=(id)[NSNull null]) {
        poli.tags=[NSMutableArray new];
        for (NSString *tag in [dict valueForKey:@"tag_names"]) {
            [_tags addObject:tag];
        }
    }
    
    return poli;
}

+ (void)fetchPoliWithUser:(GFUser *)user
        completionHandler:(void(^_Nonnull)(NSArray<GFPoli *> *))completion {
    
    NSMutableArray *queryItems = [NSMutableArray<NSURLQueryItem *> new];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"address" value:user.address]];
    
    NSURLComponents *stateComponents = [NSURLComponents componentsWithString:URL];
    stateComponents.queryItems = queryItems;
    NSURL *poliURL = stateComponents.URL;
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:poliURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [req setHTTPMethod:@"GET"];
    [req setValue:apiKey forHTTPHeaderField:@"key"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Fetch State Unseccessful!");
            return;
        }
        if (!(response)){
            NSLog(@"No Response!");
            return;
        }
        NSLog(@"Successful!");
        NSMutableArray <GFPoli*> *polis=[NSMutableArray<GFPoli*> new];
        NSError *JSONParsingError;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONParsingError];        for (NSDictionary *entry in arr){
            GFPoli *poli = [[GFPoli alloc] initWithDictionary:entry];
            NSLog(@"%@",poli);
            [polis addObject:poli];
        }
        completion(polis);
    }];
    [task resume];
}

- (void)printInfo{
    NSLog(@"%@",self.name);
    NSLog(@"%@",self.party);
}

@end
