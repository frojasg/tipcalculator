//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Francisco Rojas Gallegos on 9/22/15.
//  Copyright (c) 2015 Rita Miller desgins. All rights reserved.
//

#import "SettingsViewController.h"
#import "UserPreferences.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *lowTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *mediumTipTextField;
@property (weak, nonatomic) IBOutlet UITextField *highTipTextField;
- (IBAction)onTap:(id)sender;
- (void) updateValues;

@end

@implementation SettingsViewController
{
    UserPreferences *preference;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"this is beig call");
    preference = [[UserPreferences alloc] init];
    self.lowTipTextField.delegate = self;
    self.mediumTipTextField.delegate = self;
    self.highTipTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");

    self.lowTipTextField.text = [[NSNumber numberWithInteger:[preference getLowTip]] stringValue];
    self.mediumTipTextField.text = [[NSNumber numberWithInteger:[preference getMediumTip]] stringValue];
    self.highTipTextField.text = [[NSNumber numberWithInteger:[preference getHighTip]] stringValue];
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

    [preference setLowTip: [self.lowTipTextField.text integerValue]];
    [preference setMediumTip: [self.mediumTipTextField.text integerValue]];
    [preference setHighTip: [self.highTipTextField.text integerValue]];
    [preference commit];
}

- (IBAction)onTap:(id)sender {
    NSLog(@"tap!");
    [self updateValues];
    [self.view endEditing:(YES)];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *newString = [[[textField.text stringByReplacingCharactersInRange:range withString:string] componentsSeparatedByCharactersInSet:
                            [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                           componentsJoinedByString:@""];
    return [newString integerValue] <= 100;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
