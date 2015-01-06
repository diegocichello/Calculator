//
//  ViewController.m
//  Calculator
//
//  Created by Diego Cichello on 1/5/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property NSString *oldNumber;
@property NSString *currentNumber;
@property bool operatorPressed;
@property bool oldNumberExists;
@property bool numberPressed;
@property int operatorType;

@end

@implementation ViewController

- (IBAction)onNumberButtonPressed:(id)sender {

    UIButton * buttonPressed = (UIButton *)sender;



    if([self.numberLabel.text isEqual: @"0"] || self.operatorPressed)
    {
        self.numberLabel.text=@"";
        self.operatorPressed = false;
    }
    self.numberLabel.text = [self.numberLabel.text stringByAppendingString:buttonPressed.titleLabel.text ];
    self.numberPressed = true;

}
- (IBAction)onDecimalButtonPressed:(id)sender {

    if (![self.numberLabel.text containsString:@"."])
    {
        if (self.operatorPressed)
        {
            self.numberLabel.text = @"0." ;
            self.operatorPressed = false;
        }
        else{
            self.numberLabel.text = [self.numberLabel.text stringByAppendingString:@"." ];
        }
    }

}
- (IBAction)onPlusButtonPressed:(id)sender {

    if (!self.oldNumberExists)
    {

    self.oldNumber = self.numberLabel.text;
    self.operatorPressed = true;
    self.oldNumberExists = true;
    }
    else if (self.numberPressed)
    {
        [self doCalculation];
        self.numberPressed = false;

        self.numberLabel.text = self.oldNumber;
        self.operatorPressed = true;
        self.oldNumberExists = true;

    }
    self.operatorType = 0;


}


- (IBAction)onMinusButtonPressed:(id)sender {

    if (!self.oldNumberExists)
    {

        self.oldNumber = self.numberLabel.text;
        self.operatorPressed = true;
        self.oldNumberExists = true;
    }
    else if (self.numberPressed)
    {
        [self doCalculation];
        self.numberPressed = false;

        self.numberLabel.text = self.oldNumber;
        self.operatorPressed = true;
        self.oldNumberExists = true;

    }
    self.operatorType = 1;

}

- (IBAction)onTimesButtonPressed:(id)sender {

    if (!self.oldNumberExists)
    {

        self.oldNumber = self.numberLabel.text;
        self.operatorPressed = true;
        self.oldNumberExists = true;
    }
    else if (self.numberPressed)
    {
        [self doCalculation];
        self.numberPressed = false;

        self.numberLabel.text = self.oldNumber;
        self.operatorPressed = true;
        self.oldNumberExists = true;

    }
    self.operatorType = 2;
}

- (IBAction)onDivideButtonPressed:(id)sender {

    if (!self.oldNumberExists)
    {

        self.oldNumber = self.numberLabel.text;
        self.operatorPressed = true;
        self.oldNumberExists = true;
    }
    else if (self.numberPressed)
    {
        [self doCalculation];
        self.numberPressed = false;

        self.numberLabel.text = self.oldNumber;
        self.operatorPressed = true;
        self.oldNumberExists = true;

    }
    self.operatorType = 3;
}

- (IBAction)onClearButtonPressed:(id)sender {
    self.numberLabel.text = @"0";
    self.oldNumberExists = false;
    self.oldNumber = @"0";
}

- (IBAction)onPercentButtonPressed:(id)sender {

    self.numberLabel.text = [NSString stringWithFormat:@"%f", [self.numberLabel.text floatValue] / 100];
    self.numberLabel.text = [self clearZeros:self.numberLabel.text];

}

- (IBAction)onEqualsButtonPressed:(id)sender {

    if (!self.oldNumberExists)
    {

        self.oldNumber = self.numberLabel.text;
        self.operatorPressed = true;
        self.oldNumberExists = true;
    }
    else if (self.numberPressed)
    {
        [self doCalculation];

        self.numberLabel.text = self.oldNumber;
        self.operatorPressed = true;
        self.oldNumberExists = false;
        self.numberPressed = false;
        
    }




}
- (IBAction)onChangeSignButtonPressed:(id)sender {

    self.numberLabel.text = [NSString stringWithFormat:@"%f", [self.numberLabel.text floatValue] * -1];
    self.numberLabel.text = [self clearZeros:self.numberLabel.text];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oldNumberExists = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doCalculation
{

    switch (self.operatorType) {
        case 0:
            //adds floatValues of oldNumber and numberLabel and converts back to string
            self.oldNumber = [NSString stringWithFormat:@"%f", [self.oldNumber floatValue] + [self.numberLabel.text floatValue]];
            break;
        case 1:
            self.oldNumber = [NSString stringWithFormat:@"%f", [self.oldNumber floatValue] - [self.numberLabel.text floatValue]];
            break;
        case 2:
            self.oldNumber= [NSString stringWithFormat:@"%f", [self.oldNumber floatValue] * [self.numberLabel.text floatValue]];
            break;
        case 3:
            self.oldNumber = [NSString stringWithFormat:@"%f", [self.oldNumber floatValue] /[self.numberLabel.text floatValue]];
            break;

        default:
            break;
    }
    self.oldNumber = [self clearZeros:(self.oldNumber)];


}
// will only be calculated after a oldNumber already exists
- (NSString *) clearZeros:(NSString *)numberString;
{
    if ([numberString containsString:@"."])
    {
        while ([numberString hasSuffix:@"0"] || [numberString hasSuffix:@"."])
        {

            numberString = [numberString substringToIndex:[numberString length] - 1];
            if (![numberString containsString:@"."])
            {
                break;
            }

        }
    }
    return numberString;

}

@end
