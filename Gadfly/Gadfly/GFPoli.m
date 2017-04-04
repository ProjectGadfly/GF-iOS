#import "GFPoli.h"

static const NSString *URL = @"http://gadfly.mobi/services/v1/representatives";
static const NSString *APIKey = @"v1key";
const NSTimeInterval timeoutInterval = 60.0;
BOOL callAgain = YES; // to handle bug where we need to submit twice to avoid error

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
        poli.tags=[dict valueForKey:@"tags"];
    }
    
    return poli;
}

+ (void)fetchPoliWithAddress:(NSString *)address
           completionHandler:(void(^_Nonnull)(NSArray *))completion {
    
    NSLog(@"Start to fetch Polis!!!!!!!!!!!!!!!!!! THE ADDRESS IS %@",address);
    
    NSMutableArray *queryItems = [NSMutableArray<NSURLQueryItem *> new];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"address" value:address]];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:URL];
    components.queryItems = queryItems;
    NSURL *poliURL = components.URL;
    
    NSLog(@"The url is %@",poliURL);
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:poliURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [req setHTTPMethod:@"GET"];
    [req setValue:APIKey forHTTPHeaderField:@"APIKey"];
    
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
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONParsingError];
        //NSLog(@"%@",result);
        NSString *status=[result valueForKey:@"Status"];
        if (![status isEqualToString:@"OK"]){
            NSLog(@"Error!!!!!!!!!!!!!!!!!!!!!!!!");
            /*if(callAgain) {
                //to handle bug where we need to submit address twice to avoid error
                callAgain = NO;
                NSLog(@"Second try THE ADDRESS IS %@",address);
                
                NSMutableArray *queryItems = [NSMutableArray<NSURLQueryItem *> new];
                [queryItems addObject:[NSURLQueryItem queryItemWithName:@"address" value:address]];
                
                NSURLComponents *components = [NSURLComponents componentsWithString:URL];
                components.queryItems = queryItems;
                NSURL *poliURL = components.URL;
                
                NSLog(@"The url is %@",poliURL);
                
                NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:poliURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
                [req setHTTPMethod:@"GET"];
                [req setValue:APIKey forHTTPHeaderField:@"APIKey"];
                
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
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONParsingError];
                    NSLog(@"%@",result);
                    NSString *status=[result valueForKey:@"Status"];
                    if (![status isEqualToString:@"OK"]){
                        NSLog(@"Error!!!!!!!!!!!!!!!!!!!!!!!!");
                        if(callAgain) {
                            //to handle bug where we need to submit address twice to avoid error
                            
                        }
                        NSMutableArray *error=[NSMutableArray new];
                        [error addObject:status];
                        completion(error);
                    }
                    else {
                        NSMutableArray *arr=[result valueForKey:@"Results"];
                        for (NSDictionary *entry in arr){
                            GFPoli *poli = [[GFPoli alloc] initWithDictionary:entry];
                            NSLog(@"%@",poli);
                            [polis addObject:poli];
                        }
                        completion(polis);
                    }
                }];
                [task resume];
            }*/
            NSMutableArray *error=[NSMutableArray new];
            [error addObject:status];
            completion(error);
        }
        else {
            NSMutableArray *arr=[result valueForKey:@"Results"];
            for (NSDictionary *entry in arr){
                GFPoli *poli = [[GFPoli alloc] initWithDictionary:entry];
                //NSLog(@"%@",poli);
                [polis addObject:poli];
            }
            completion(polis);
        }
    }];
    [task resume];
}

- (void)printInfo{
    NSLog(@"%@",self.name);
    NSLog(@"%@",self.party);
}

@end
