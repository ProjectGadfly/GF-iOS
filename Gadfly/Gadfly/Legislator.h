#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Legislator : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSURL *photo_url;
@end
