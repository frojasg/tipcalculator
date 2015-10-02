//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Francisco Rojas Gallegos on 9/22/15.
//  Copyright (c) 2015 Rita Miller desgins. All rights reserved.
//

#import "SettingsViewController.h"
#import "TipSegmentedControl.h"
#import "UserPreferences.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *lowTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *mediumTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *highTipTextField;
@property (weak, nonatomic) IBOutlet TipSegmentedControl *tipControl;
- (IBAction)onTap:(id)sender;
- (IBAction)editingDidEnd:(UITextField *)sender;
- (IBAction)editingDidBegin:(UITextField *)sender;
- (void) updateValues;
- (NSInteger) parseInt: (NSString*) value;

@end

@implementation SettingsViewController
{
    UserPreferences *preference;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    preference = [[UserPreferences alloc] init];
    self.lowTipTextField.delegate = self;
    self.mediumTipTextField.delegate = self;
    self.highTipTextField.delegate = self;
    [self.tipControl load: preference];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {

    self.lowTipTextField.text = [[NSNumber numberWithInteger:[preference getLowTip]] stringValue];
    self.mediumTipTextField.text = [[NSNumber numberWithInteger:[preference getMediumTip]] stringValue];
    self.highTipTextField.text = [[NSNumber numberWithInteger:[preference getHighTip]] stringValue];
    [self.tipControl reload];

    [self editingDidEnd:self.lowTipTextField];
    [self editingDidEnd:self.mediumTipTextField];
    [self editingDidEnd:self.highTipTextField];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [self updateValues];
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

- (void)updateValues {

    [preference setLowTip: [self parseInt: self.lowTipTextField.text]];
    [preference setMediumTip: [self parseInt: self.mediumTipTextField.text]];
    [preference setHighTip: [self parseInt: self.highTipTextField.text]];

    [self.tipControl save];

    [preference commit];
}

- (IBAction)onTap:(id)sender {
    [self updateValues];
    [self.tipControl reload];
    [self.view endEditing:(YES)];
}

- (IBAction)editingDidEnd:(UITextField *)sender {
    sender.text = [NSString stringWithFormat:@"%ld %@", [self parseInt: sender.text], @"%"];
    [self updateValues];
    [self.tipControl reload];
}

- (IBAction)editingDidBegin:(UITextField *)sender {
    sender.text = [@([self parseInt:sender.text]) stringValue];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([self isPercentage: newString]) {
        return NO;
    } else {
        return [self parseInt: newString] <= 100;
    }
}

- (BOOL) isPercentage: (NSString*) string {
    return[string rangeOfCharacterFromSet: [[NSCharacterSet characterSetWithCharactersInString:@"0123456789 %"] invertedSet]].location != NSNotFound;
}

- (NSInteger) parseInt: (NSString*) value {
    NSString *cleanedString = [[value componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    return [cleanedString integerValue];
}

@end
