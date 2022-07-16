#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import "GcUniversal/GcImagePickerUtils.h"

@interface RNSScreen : UIViewController
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIView *dimView;
@end

@interface DCDMessageViewController : UIViewController
@end

@interface DCDChat : UIView
- (id)_viewControllerForAncestor;
@end

@interface RCTView : UIView
- (id)_viewControllerForAncestor;
@end

@interface RNCSafeAreaView : UIView
- (id)_viewControllerForAncestor;
@end

@interface DCDSystemMessageTableViewCell : UITableViewCell
@end

@interface DCDMessageTableViewCell : UITableViewCell
@end

@interface DCDSeparatorTableViewCell : UITableViewCell
@end

