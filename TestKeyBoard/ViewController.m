//
//  ViewController.m
//  TestKeyBoard
//
//  Created by zzt on 15/1/22.
//  Copyright (c) 2015年 61com. All rights reserved.
//

#import "ViewController.h"
#import "CommentPad.h"
@interface ViewController ()
{
    CommentPad *cp;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textField.placeholder = @"输入";

    
    cp = [[CommentPad alloc] init];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)hideAction:(id)sender{
//    [textField resignFirstResponder];
    [cp show];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}
@end
