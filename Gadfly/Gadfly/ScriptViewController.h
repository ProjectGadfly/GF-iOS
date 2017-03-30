#import <UIKit/UIKit.h>

@interface ScriptViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *scriptTitle;
@property (weak, nonatomic) IBOutlet UITextView *callScript;
@property (nonatomic, strong) NSMutableArray *legislators;
@end
