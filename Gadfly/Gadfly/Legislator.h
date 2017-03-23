#import <Foundation/Foundation.h>

/* @brief, creates a Legislator object that is a subclass of NSObject
 */
@interface Legislator : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;

@end
