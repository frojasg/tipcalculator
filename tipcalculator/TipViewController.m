//
//  TipViewController.m
//  tipcalculator
//
//  Created by Francisco Rojas Gallegos on 9/20/15.
//  Copyright (c) 2015 Rita Miller desgins. All rights reserved.
//

#import "TipViewController.h"
#import "UserPreferences.h"
#import "TipSegmentedControl.h"

@interface TipViewController ()


@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet TipSegmentedControl *tipController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *billTextFieldUpperContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultViewUpperConstraint;
- (IBAction)onUpdate:(id)sender;
- (void) updateValues;
- (float) getTipPercentage;
- (void) hiddeResultView;
- (void) showResultView;
- (void) hiddeResultViewAnimated;
- (void) showResultViewAnimated;
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
    [self.tipController load: preference];
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

- (void) hiddeResultViewAnimated {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5
                          delay: 0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self hiddeResultView];
                         [self.view layoutIfNeeded];
                     }
                     completion: nil];
}

- (void) hiddeResultView {
    self.billTextFieldUpperContraint.constant = 100.0f;
    self.resultViewUpperConstraint.constant = 200.0f;
    self.tipController.alpha = 0.0f;
    self.resultView.alpha = 0.0f;
}

- (void) showResultViewAnimated {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5
                          delay: 0
                        options:UIViewAnimationOptionCurveEaseIn
                        animations:^{
                            [self showResultView];
                            [self.view layoutIfNeeded];
                        }
                        completion: nil];
}
- (void) showResultView {
    self.billTextFieldUpperContraint.constant = 10.0f;
    self.resultViewUpperConstraint.constant = 10.0f;
    self.tipController.alpha = 1.0f;
    self.resultView.alpha = 1.0f;
}

- (IBAction)onUpdate:(id)sender {
    [self updateValues];
    if ([self.billTextField.text isEqualToString:@""]) {
        [self hiddeResultViewAnimated];
    } else {
        [self showResultViewAnimated];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tipController reload];
    [self updateValues];
    if ([self.billTextField.text isEqualToString:@""]) {
        [self hiddeResultView];
    } else {
        [self showResultView];
    }
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
    return [self.tipController getTipPercentage];
}

@end
