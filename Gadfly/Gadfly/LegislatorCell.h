#import <UIKit/UIKit.h>

/* @file, creates a LegislatorCell, a subclass of the UITableViewCell
   creates properties for each cell
 */
@interface LegislatorCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *legislator_photo;
@property (weak, nonatomic) IBOutlet UILabel *legislator_name;
@property (weak, nonatomic) IBOutlet UILabel *legislator_email;
@property (weak, nonatomic) IBOutlet UILabel *legislator_phone;

@end
