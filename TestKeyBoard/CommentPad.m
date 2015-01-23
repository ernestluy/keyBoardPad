//
//  CommentPad.m
//  TestKeyBoard
//
//  Created by zzt on 15/1/22.
//  Copyright (c) 2015年 61com. All rights reserved.
//

#import "CommentPad.h"
#import "AppDelegate.h"

@interface CommentPad ()
{
    UIView *corePad;
    BOOL isHide;
    
    BOOL isAnimationTime;
}
@end
@implementation CommentPad

-(id)init{
    CGRect boudle = [UIScreen mainScreen].bounds;
//    CGRect tRect  = CGRectMake(0, 0, boudle.size.width, 120);
    if (self = [super initWithFrame:boudle]) {
//        self.backgroundColor = [UIColor lightGrayColor];
        
        
        isHide = NO;
        isAnimationTime = NO;
        
        [self initLayout];
    }
    return self;
}
-(void)initLayout{
    CGRect boudle = [UIScreen mainScreen].bounds;
    
    UIButton *btnHidden = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnHidden setTitle:@"退出" forState:UIControlStateNormal];
    btnHidden.frame = boudle;
    btnHidden.backgroundColor = [UIColor darkGrayColor];
    btnHidden.alpha = 0.5;
    [btnHidden addTarget:self action:@selector(exitPad:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnHidden];
    
    corePad = [[UIView alloc] init];
    corePad.frame = CGRectMake(0, boudle.size.height, boudle.size.width, 120);
    corePad.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:corePad];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    titleLabel.text = @"写跟帖";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [corePad addSubview:titleLabel];
    
    btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnExit setTitle:@"退出" forState:UIControlStateNormal];
    btnExit.frame = CGRectMake(0, 0, 60, 20);
    btnExit.backgroundColor = [UIColor redColor];
    [btnExit addTarget:self action:@selector(exitPad:) forControlEvents:UIControlEventTouchUpInside];
    [corePad addSubview:btnExit];
    
    UIButton *btnSub = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSub setTitle:@"提交" forState:UIControlStateNormal];
    btnSub.frame = CGRectMake(corePad.frame.size.width - 60, 0, 60, 20);
    btnSub.backgroundColor = [UIColor redColor];
    [btnSub addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [corePad addSubview:btnSub];
    
    textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(0, 20, corePad.frame.size.width, 80);
    textView.delegate = self;
    [corePad addSubview:textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)show{
    if (isAnimationTime) {
        return;
    }
    UIWindow *window = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    [window addSubview:self];
    [textView becomeFirstResponder];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(commentPadShow:)]) {
            [self.delegate commentPadShow:self];
        }
        
    }
}


-(void)exitPad:(id)sender{
    NSLog(@"exitPad");
    if (isAnimationTime) {
        return;
    }
    textView.text =  @"";
    [textView resignFirstResponder];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(commentPadHide:)]) {
            [self.delegate commentPadHide:self];
        }
        
    }
}
-(void)submit:(id)sender{
    NSLog(@"submit");
    if (isAnimationTime) {
        return;
    }
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(commentPadSubmit:)]) {
            [self.delegate commentPadSubmit:self];
        }
        
    }
}

#pragma mark - keyboard
/*
 userInfo = {
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardAnimationDurationUserInfoKey = "0.25";
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 184}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 660}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 476}";
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 568}, {320, 184}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 384}, {320, 184}}";
 }}
 */

-(void)keyboardWillShow:(NSNotification *)aNotification{
//    NSLog(@"keyboardWWillShow");
    
}
-(void)keyboardDidHide:(NSNotification *)aNotification{
//    NSLog(@"keyboardDidHide");
}
-(void)keyboardWillChangeFrame:(NSNotification *)aNotification{
//    NSLog(@"keyboardWillChangeFrame");
    NSValue *tr = [aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect boudle = [UIScreen mainScreen].bounds;
    CGRect endRect = [tr CGRectValue];
    if (endRect.origin.y == boudle.size.height) {
        isHide = YES;
    }
    [UIView animateWithDuration:0.25 animations:^{
        isAnimationTime = YES;
        if (isHide) {
            corePad.frame = CGRectMake(0, boudle.size.height, corePad.frame.size.width, corePad.frame.size.height);
            self.alpha = 0.0;
        }else{
            corePad.frame = CGRectMake(0,  endRect.origin.y - corePad.frame.size.height, corePad.frame.size.width, corePad.frame.size.height);
        }
    }completion:^(BOOL finished){
//        NSLog(@"keyboardWillChangeFrame end");
        if (isHide) {
            NSLog(@"is hide");
            isHide = NO;
            self.alpha = 1.0;
            [self removeFromSuperview];
            
        }
        isAnimationTime = NO;
    }];
}

-(void)keyboardDidChangeFrame:(NSNotification *)aNotification{
//    NSLog(@"keyboardDidChangeFrame");

}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
//    NSLog(@"textViewDidChange");
}
@end
