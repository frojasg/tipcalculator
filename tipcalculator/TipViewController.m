//
//  TipViewController.m
//  tipcalculator
//
//  Created by Francisco Rojas Gallegos on 9/20/15.
//  Copyright (c) 2015 Rita Miller desgins. All rights reserved.
//

#import "TipViewController.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Caculator";
    [self.billTextField becomeFirstResponder];
    [self updateValues];
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
    NSLog(@"view will appear");
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
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat: @"$%.2f", totalAmount];
    
}

- (float) getTipPercentage {
    NSArray *tipValues = @[@(0.01), @(0.15), @(0.2)];
    return [tipValues[self.tipController.selectedSegmentIndex] floatValue];
}

@end
