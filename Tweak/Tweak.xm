#import "Tweak.h"

BOOL enabled = NO;

%group Tweak

%hook RNSScreen
%property (nonatomic, retain) UIImageView *imageView;
%property (nonatomic, retain) UIView *dimView;
- (void)viewWillAppear:(BOOL)animated {
    %orig;
    self.imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.imageView.image = [GcImagePickerUtils imageFromDefaults:@"com.sugiuta.dcframe" withKey:@"kWallpaper"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
    [self.view insertSubview:self.imageView atIndex:0];

    self.dimView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.dimView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    [self.view insertSubview:self.dimView atIndex:1];
}
%end

%hook DCDMessageViewController
- (void)viewWillAppear:(BOOL)animated {
    %orig;
    self.view.backgroundColor = [UIColor clearColor];
}
%end

%hook DCDChat
- (void)layoutSubviews {
    %orig;
    if ([[self _viewControllerForAncestor] isKindOfClass:objc_getClass("RNSScreen")]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
}
%end

%hook RNCSafeAreaView
- (void)layoutSubviews {
    %orig;
    if ([[self _viewControllerForAncestor] isKindOfClass:objc_getClass("RNSScreen")]) {
        [self setBackgroundColor:[UIColor colorWithRed:0.184 green:0.192 blue:0.211 alpha:1.0]];
    }
}
%end

%hook RCTView
- (void)layoutSubviews {
    %orig;
    if ([[self _viewControllerForAncestor] isKindOfClass:objc_getClass("RNSScreen")]) {
        [self setBackgroundColor:[UIColor clearColor]];
        if ([[self superview] isKindOfClass:objc_getClass("DCDChat")]) {
            [self setBackgroundColor:[UIColor colorWithRed:0.184 green:0.192 blue:0.211 alpha:1.0]];
        }
    }
}
%end

%hook DCDSystemMessageTableViewCell
- (void)layoutSubviews {
    %orig;
    [self setBackgroundColor:[UIColor clearColor]];
}
%end

%hook DCDMessageTableViewCell
- (void)layoutSubviews {
    %orig;
    [self setBackgroundColor:[UIColor clearColor]];
}
%end

%hook DCDSeparatorTableViewCell
- (void)layoutSubviews {
    %orig;
    [self setBackgroundColor:[UIColor clearColor]];
}
%end

%end

%ctor {
    HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.sugiuta.dcframe"];
    [preferences registerBool:&enabled default:NO forKey:@"kEnabled"];
    if(enabled) %init(Tweak);
}
