//
//  ViewController.m
//  Calculator
//
//  Created by Yi-Chin and Diego Cichello on 1/5/15.
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

//------------------------------------------ Numbers Actions -------------------------------------------
- (IBAction)onNumberButtonPressed:(id)sender {

    UIButton * buttonPressed = (UIButton *)sender;


    //Check if the calculator is still with a 0 showing or an operator already been pressed
    //After that we append the new number pressed into the calculator label.
    if([self.numberLabel.text isEqual: @"0"] || self.operatorPressed)
    {
        self.numberLabel.text=@"";
        self.operatorPressed = false;
    }
    self.numberLabel.text = [self.numberLabel.text stringByAppendingString:buttonPressed.titleLabel.text ];
    self.numberPressed = true;

}

//------------------------------------------- Operators Actions ---------------------------------------

//Decimal Button - %
- (IBAction)onDecimalButtonPressed:(id)sender {


    //Can't add two . signs to the same number, so first we need to check if the number is already decimal
    if (![self.numberLabel.text containsString:@"."])
    {
        //If we press decimal right after we press an operator we should add a 0 before the ., otherwise
        //it would just append the .
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

//Plus Button: +
- (IBAction)onPlusButtonPressed:(id)sender {


    //We first need to check if a number was already pressed, if not, the operator does nothing
    if (!self.oldNumberExists)
    {
        //We need to store the number typed on a property so we can use it later to do the calculation
        //As well we need to make it true that an old number already exists and an operator has been
        //pressed.
        self.oldNumber = self.numberLabel.text;
        self.operatorPressed = true;
        self.oldNumberExists = true;
    }
    // To prevent we could be pressing the operator button several times, we have to check if a new number
    // was already pressed
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

// Minus Button: -
- (IBAction)onMinusButtonPressed:(id)sender {

    //We first need to check if a number was already pressed, if not, the operator does nothing
    if (!self.oldNumberExists)
    {
        //We need to store the number typed on a property so we can use it later to do the calculation
        //As well we need to make it true that an old number already exists and an operator has been
        //pressed.
        self.oldNumber = self.numberLabel.text;
        self.operatorPressed = true;
        self.oldNumberExists = true;
    }
    // To prevent we could be pressing the operator button several times, we have to check if a new number
    // was already pressed
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

// Times Button: *
- (IBAction)onTimesButtonPressed:(id)sender {

    //We first need to check if a number was already pressed, if not, the operator does nothing
    if (!self.oldNumberExists)
    {
        //We need to store the number typed on a property so we can use it later to do the calculation
        //As well we need to make it true that an old number already exists and an operator has been
        //pressed.
        self.oldNumber = self.numberLabel.text;
        self.operatorPressed = true;
        self.oldNumberExists = true;
    }
    // To prevent we could be pressing the operator button several times, we have to check if a new number
    // was already pressed
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

//Divide Button: /
- (IBAction)onDivideButtonPressed:(id)sender {

    //We first need to check if a number was already pressed, if not, the operator does nothing
    if (!self.oldNumberExists)
    {
        //We need to store the number typed on a property so we can use it later to do the calculation
        //As well we need to make it true that an old number already exists and an operator has been
        //pressed.
        self.oldNumber = self.numberLabel.text;
        self.operatorPressed = true;
        self.oldNumberExists = true;
    }
    // To prevent we could be pressing the operator button several times, we have to check if a new number
    // was already pressed
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

//Percent Button: %
- (IBAction)onPercentButtonPressed:(id)sender {

    //Logic here is that we only have to divide by 100
    self.numberLabel.text = [NSString stringWithFormat:@"%f", [self.numberLabel.text floatValue] / 100];
    self.numberLabel.text = [self clearZeros:self.numberLabel.text];

}

//Equals Button: =
- (IBAction)onEqualsButtonPressed:(id)sender {

    //We first need to check if a number was already pressed, if not, the operator does nothing
    if (!self.oldNumberExists)
    {
        //We need to store the number typed on a property so we can use it later to do the calculation
        //As well we need to make it true that an old number already exists and an operator has been
        //pressed.
        self.oldNumber = self.numberLabel.text;
        self.operatorPressed = true;
        self.oldNumberExists = true;
    }
    // To prevent we could be pressing the operator button several times, we have to check if a new number
    // was already pressed
    else if (self.numberPressed)
    {
        [self doCalculation];

        self.numberLabel.text = self.oldNumber;
        self.operatorPressed = true;
        self.oldNumberExists = false;
        self.numberPressed = false;
        
    }

}

//Change Sign Button:  +/-
- (IBAction)onChangeSignButtonPressed:(id)sender {

    //Just need to multiply by -1 to change between positive and negative
    self.numberLabel.text = [NSString stringWithFormat:@"%f", [self.numberLabel.text floatValue] * -1];
    self.numberLabel.text = [self clearZeros:self.numberLabel.text];


}

//Clear Button: C
//Just erases everything and all variables;
- (IBAction)onClearButtonPressed:(id)sender {
    self.numberLabel.text = @"0";
    self.oldNumberExists = false;
    self.oldNumber = @"0";
}

// --------------------------------------- View Methods ---------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.oldNumberExists = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ---------------------------------------- Other Methods -------------------------------------------


//Method that do the calculations, each operator has an operator type being:
//0: + ;
//1: - ;
//2: * ;
//3: / ;
-(void)doCalculation
{

    //Switch to check what operator should we do.
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

            if ([self.numberLabel.text isEqualToString:@"0"])
            {
                self.oldNumber = @"Err";
                self.numberLabel.text = @"Ere";
                self.oldNumberExists = false;
            }
            else
            {
                self.oldNumber = [NSString stringWithFormat:@"%f", [self.oldNumber floatValue] /[self.numberLabel.text floatValue]];

            }
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
