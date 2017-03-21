#import "GFRep.h"

static const NSString *repURL = @"http://127.0.0.1:5000/reps";
const NSTimeInterval timeoutInterval = 60.0;

@implementation GFRep

- (GFRep *)initWithDictionary:(NSDictionary *)dict{
    
    GFRep * rep = [GFRep new];
    if ([[dict valueForKey:@"tp"] isEqual:@"federal"]) rep.type=0;
    else rep.type=1;
    rep.name = [dict valueForKey:@"name"];
    rep.phone = [dict valueForKey:@"phone"];
    //rep.email = [dict valueForKey:@"email"];
    rep.picURL = [dict valueForKey:@"picURL"];
    
    return rep;
}

+ (void)fetchRepsWithUser:(GFUser *)user
        completionHandler:(void(^_Nonnull)(NSArray<GFRep *> *))completion{
    
    NSURL *url=[NSURL URLWithString:repURL];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Fetch Reps Unseccessful!");
            return;
        }
        if (!(response)){
            NSLog(@"No Response!");
            return;
        }
        NSLog(@"Successful!");
        NSMutableArray <GFRep*> *reps=[NSMutableArray<GFRep*> new];
        NSError *JSONParsingError;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONParsingError];
        for (NSDictionary *entry in arr){
            GFRep *rep = [[GFRep alloc] initWithDictionary:entry];
            NSLog(@"%@",rep);
            [reps addObject:rep];
        }
        completion(reps);
    }];
    [task resume];

}

- (void)printInfo{
    NSLog(@"%@",self.name);
    NSLog(@"%@",self.phone);
}

@end


