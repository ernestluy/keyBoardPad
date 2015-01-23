//
//  CommentPad.h
//  TestKeyBoard
//
//  Created by zzt on 15/1/22.
//  Copyright (c) 2015年 61com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentPad;
@protocol CommentPadDelegate <NSObject>
- (void)commentPadHide:(CommentPad *)commentPad;
-(void)commentPadShow:(CommentPad *)commentPad;
-(void)commentPadSubmit:(CommentPad *)commentPad;
@end
@interface CommentPad : UIView<UITextViewDelegate>
{
    UITextView *textView;
    UIButton *btnExit;
    UIButton *btnOk;
}
@property(nonatomic,assign)id<CommentPadDelegate> delegate;
@property(nonatomic)int tTag;
-(void)show;
-(void)exitPad:(id)sender;
-(void)submit:(id)sender;
@end
