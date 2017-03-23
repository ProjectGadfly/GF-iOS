#import <UIKit/UIKit.h>

@interface LegislatorCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *legislator_photo;
@property (weak, nonatomic) IBOutlet UILabel *legislator_name;
@property (weak, nonatomic) IBOutlet UILabel *legislator_email;
@property (weak, nonatomic) IBOutlet UILabel *legislator_phone;

@end
