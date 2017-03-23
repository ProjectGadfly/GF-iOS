#import "GFPoli.h"

static const NSString *stateURL = @"http://127.0.0.1:5000/services/v1/getstate";
static const NSString *federalURL = @"http://127.0.0.1:5000/services/v1/getfederal";
static const NSString *apiKey = @"b9ae3e78eb1c94ee7d7c4cb0cfa0bd889e900f2abefdf75f418c79f133aee28f468f18194b3ce1cd54f1850c332d7b6fd096ee50068cc5cb542efd0bd07cd6f3";
const NSTimeInterval timeoutInterval = 60.0;

@implementation GFPoli

- (GFPoli *)initWithDictionary:(NSDictionary *)dict{
    
    GFPoli * poli = [GFPoli new];
    if ([dict valueForKey:@"fedOrState"] == 0) {
        if ([dict valueForKey:@"senOrRep"] == 0) poli.type=FederalSenate;
        else poli.type=FederalRep;
    }
    else {
        if ([dict valueForKey:@"senOrRep"] == 0) poli.type=StateSenate;
        else poli.type=StateRep;
    }
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
    
    return poli;
}

+ (void)fetchStateWithUser:(GFUser *)user
         completionHandler:(void(^_Nonnull)(NSArray<GFPoli *> *))completion {
    
    NSMutableArray *queryItems = [NSMutableArray<NSURLQueryItem *> new];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"address" value:user.address]];
    
    NSURLComponents *stateComponents = [NSURLComponents componentsWithString:stateURL];
    stateComponents.queryItems = queryItems;
    NSURL *stateURL = stateComponents.URL;
    
    NSMutableURLRequest *stateReq = [NSMutableURLRequest requestWithURL:stateURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [stateReq setHTTPMethod:@"GET"];
    [stateReq setValue:apiKey forHTTPHeaderField:@"key"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:stateReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Fetch State Unseccessful!");
            return;
        }
        if (!(response)){
            NSLog(@"No Response!");
            return;
        }
        NSLog(@"Successful!");
        NSMutableArray <GFPoli*> *states=[NSMutableArray<GFPoli*> new];
        NSError *JSONParsingError;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONParsingError];        for (NSDictionary *entry in arr){
            GFPoli *state = [[GFPoli alloc] initWithDictionary:entry];
            NSLog(@"%@",state);
            [states addObject:state];
        }
        completion(states);
    }];
    [task resume];
}

+ (void)fetchFedWithUser:(GFUser *)user
       completionHandler:(void(^_Nonnull)(NSArray<GFPoli *> *))completion {
    
    NSMutableArray *queryItems = [NSMutableArray<NSURLQueryItem *> new];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"address" value:user.address]];
    
    NSURLComponents *fedComponents = [NSURLComponents componentsWithString:federalURL];
    fedComponents.queryItems = queryItems;
    NSURL *fedURL = fedComponents.URL;
    
    NSMutableURLRequest *fedReq = [NSMutableURLRequest requestWithURL:fedURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [fedReq setHTTPMethod:@"GET"];
    [fedReq setValue:apiKey forHTTPHeaderField:@"key"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:fedReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Fetch Fed Unseccessful!");
            return;
        }
        if (!(response)){
            NSLog(@"No Response!");
            return;
        }
        NSLog(@"Successful!");
        NSMutableArray <GFPoli*> *feds=[NSMutableArray<GFPoli*> new];
        NSError *JSONParsingError;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONParsingError];
        for (NSDictionary *entry in arr){
            GFPoli *fed = [[GFPoli alloc] initWithDictionary:entry];
            NSLog(@"%@",fed);
            [feds addObject:fed];
        }
        completion(feds);
    }];
    [task resume];
}


- (void)printInfo{
    NSLog(@"%@",self.name);
    NSLog(@"%@",self.party);
}

@end
