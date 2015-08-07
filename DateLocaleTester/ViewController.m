//
//  ViewController.m
//  DateLocaleTester
//
//  Created by Eric Freitas on 8/7/15.
//  Copyright © 2015 Eric Freitas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UIButton *localeSelectorButton;
@property (nonatomic, strong) NSLocale *selectedLocale;
@property (nonatomic, strong) NSDate *fixedDate;

@end

static const NSString *localeIdentifierUS = @"en-US";
static const NSString *localeIdentifierAU = @"en-AU";

static const NSString *localeTitleUS = @"US English";
static const NSString *localeTitleAU = @"AU English";


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fixedDate = [[self internetInputDateFormatter] dateFromString:@"2015-08-01T12:01:01Z"];
    
    [self changeLocaleWithTitle:localeTitleUS andLocale:localeIdentifierUS];
}

#pragma mark - Locale Selector

- (void)changeLocaleWithTitle:(const NSString * __strong)title andLocale:(const NSString * __strong)localeIdentifier {
    self.selectedLocale = [NSLocale localeWithLocaleIdentifier:(NSString * _Nonnull)localeIdentifier];
    [self.localeSelectorButton setTitle:(NSString * _Nullable)title forState:UIControlStateNormal];
    [[self shortDateFormatterLocalized] setLocale:self.selectedLocale];
    [self.dateLabel setText:[[self shortDateFormatterLocalized] stringFromDate:self.fixedDate]];
}

- (IBAction)handleSelectorButtonTap:(id)sender {
    UIAlertController *activitySheet = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"SELECT LOCALE", @"Select the locale to format the date with.") preferredStyle:UIAlertControllerStyleActionSheet];
    
    [activitySheet addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"The cancel function.") style:UIAlertActionStyleCancel handler:nil]];

    [activitySheet addAction:[UIAlertAction actionWithTitle:(NSString * _Nullable)localeTitleUS style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (self.selectedLocale.localeIdentifier != localeIdentifierUS) {
            [self changeLocaleWithTitle:localeTitleUS andLocale:localeIdentifierUS];
        }
    }]];
    
    [activitySheet addAction:[UIAlertAction actionWithTitle:(NSString * _Nullable)localeTitleAU style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (self.selectedLocale.localeIdentifier != localeIdentifierAU) {
            [self changeLocaleWithTitle:localeTitleAU andLocale:localeIdentifierAU];
        }
    }]];
    
    [self presentViewController:activitySheet animated:YES completion:nil];
}

#pragma mark - Date Formatters

- (NSDateFormatter*)internetInputDateFormatter {
    static NSDateFormatter *inputFormatter = nil;
    if (!inputFormatter) {
        inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    }
    return inputFormatter;
}

- (NSDateFormatter*)shortDateFormatterLocalized {
    static NSDateFormatter *shortFormatter = nil;
    if (!shortFormatter) {
        shortFormatter = [[NSDateFormatter alloc] init];
        [shortFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    return shortFormatter;
}


@end
