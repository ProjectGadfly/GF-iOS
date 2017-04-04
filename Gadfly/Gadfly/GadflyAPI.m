/*
 @file methods for calling the Gadfly API
 @detail placeholder code for now
 */

#import "GadflyAPI.h"
#import "ApplicationConstraints.m"
#import "Legislator.h"

@implementation GadflyAPI

// @brief class method to simulate API call by returning sample data. 
+ (NSMutableArray*) GetLegislatorData
{
    NSMutableArray *legislators = [NSMutableArray arrayWithCapacity:LEG_ARRAY_SIZE];
    
    Legislator *legislator = [[Legislator alloc] init];
    legislator.name = @"Joe Goodguy";
    legislator.phone = @"555-555-5555";
    [legislators addObject:legislator];
    
    legislator = [[Legislator alloc] init];
    legislator.name = @"Sue Democrat";
    legislator.phone = @"666-666-6666";
    [legislators addObject:legislator];
    
    legislator = [[Legislator alloc] init];
    legislator.name = @"Rogue Politican";
    legislator.phone = @"123-456-7899";
    [legislators addObject:legislator];
    
    return legislators;
}

@end
