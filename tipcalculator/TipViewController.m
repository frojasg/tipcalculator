//
//  TipViewController.m
//  tipcalculator
//
//  Created by Francisco Rojas Gallegos on 9/20/15.
//  Copyright (c) 2015 Rita Miller desgins. All rights reserved.
//

#import "TipViewController.h"
#import "UserPreferences.h"

@interface TipViewController ()


@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipController;
- (IBAction)onUpdate:(id)sender;
- (void) updateValues;
- (float) getTipPercentage;
@end

@implementation TipViewController
{
    UserPreferences *preference;
    NSNumberFormatter *numberFormatter;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Caculator";
    [self.billTextField becomeFirstResponder];
    preference = [UserPreferences new];
    numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    self.tipController.selectedSegmentIndex = [preference getTipIndex];
    NSNumber* billAmount = [preference getBillAmount];
    if ([billAmount doubleValue] > 0) {
        self.billTextField.text = [billAmount stringValue];
    } else {
        self.billTextField.text = @"";
        self.billTextField.placeholder = [numberFormatter stringFromNumber:@(0)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onUpdate:(id)sender {
    [self updateValues];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateValues];
    [self.tipController setTitle:[NSString stringWithFormat:@"%ld%@", [preference getLowTip], @"%"] forSegmentAtIndex: 0];
    [self.tipController setTitle:[NSString stringWithFormat:@"%ld%@", [preference getMediumTip], @"%"] forSegmentAtIndex: 1];
    [self.tipController setTitle:[NSString stringWithFormat:@"%ld%@", [preference getHighTip], @"%"] forSegmentAtIndex: 2];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

- (void) updateValues {
    float billAmount = [self.billTextField.text floatValue];
    float tipAmount = billAmount * [self getTipPercentage];
    float totalAmount = tipAmount + billAmount;
    
    [preference setBillAmount:@(billAmount)];
    self.tipLabel.text = [numberFormatter stringFromNumber:@(tipAmount)];
    self.totalLabel.text = [numberFormatter stringFromNumber: @(totalAmount)];
    
}

- (float) getTipPercentage {
    NSArray *tipValues = @[@([preference getLowTip]), @([preference getMediumTip]), @([preference getHighTip])];
    [preference setTipIndex: self.tipController.selectedSegmentIndex];
    return [tipValues[self.tipController.selectedSegmentIndex] floatValue]/100;
}

@end
