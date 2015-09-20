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
- (IBAction)onTap:(id)sender;
- (void) updateValues;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Caculator";
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

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValues = @[@(0.01), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipController.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat: @"$%.2f", totalAmount];
    
}
@end
