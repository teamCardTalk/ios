//
//  CTWriteViewController.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 27..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "GetCards.h"

@interface CTWriteViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, NSURLConnectionDataDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    BOOL isTitleWritten;
    BOOL isTextWritten;
}

@property (weak, nonatomic) IBOutlet UITextField *titleOfText;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSMutableData* responseData;
@property (strong, nonatomic) UIImage* chosenImage;

- (IBAction)selectPhoto:(id)sender;

@end
