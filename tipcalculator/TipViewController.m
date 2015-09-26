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
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipController;
- (IBAction)onUpdate:(id)sender;
- (void) updateValues;
- (float) getTipPercentage;
@end

@implementation TipViewController
{
    UserPreferences *preference;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Caculator";
    [self.billTextField becomeFirstResponder];
    preference = [UserPreferences new];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    self.tipLabel.text = [numberFormatter stringFromNumber:@(tipAmount)];
    self.totalLabel.text = [numberFormatter stringFromNumber: @(totalAmount)];
    
}

- (float) getTipPercentage {
    NSArray *tipValues = @[@([preference getLowTip]), @([preference getMediumTip]), @([preference getHighTip])];
    return [tipValues[self.tipController.selectedSegmentIndex] floatValue]/100;
}

@end
