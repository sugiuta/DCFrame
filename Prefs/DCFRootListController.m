
#include "DCFRootListController.h"

@implementation DCFRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	return _specifiers;
}

- (instancetype)init {
    self = [super init];
    if (self) {
		UIColor *defaultColor = [UIColor colorWithRed:95/255.0 green:63/255.0 blue:150/255.0 alpha:1.0];
        HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
        appearanceSettings.tintColor = defaultColor;
        appearanceSettings.tableViewCellSeparatorColor = defaultColor;
        self.hb_appearanceSettings = appearanceSettings;

        self.respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(respring:)];
        self.respringButton.tintColor = defaultColor;
        self.navigationItem.rightBarButtonItem = self.respringButton;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [[self headerImageView] setContentMode:UIViewContentModeScaleAspectFill];
    [[self headerImageView] setImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/DCFrame.bundle/Banner.png"]];
    [[self headerImageView] setClipsToBounds:YES];
    [[self headerView] addSubview:[self headerImageView]];

    self.headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.headerImageView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
        [self.headerImageView.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
        [self.headerImageView.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor],
        [self.headerImageView.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
    ]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableHeaderView = self.headerView;
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


- (void)respring:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Do you want to reflect your settings?" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        pid_t pid;
        int status;
        const char *argv[] = {"killall", "Discord", NULL};
        posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv, NULL);
        waitpid(pid, &status, WEXITED);

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Settings are now reflected." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
