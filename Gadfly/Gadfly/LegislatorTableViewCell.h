/*
 @file Custom cell class.
 */

#import <UIKit/UIKit.h>

@interface LegislatorTableViewCell : UITableViewCell
// @ brief IBOutlets should link with UILabels on Storyboard. 
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *legImage;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *partyLabel;
@end
