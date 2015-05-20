//
//  CTWriteViewController.m
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 27..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import "CTWriteViewController.h"

@interface CTWriteViewController ()

@end

@implementation CTWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text.delegate = self;
    self.titleOfText.delegate = self;
    isTextWritten = false;
    isTitleWritten = false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGSize frameSize = self.imageView.frame.size;
    CGSize imageSize = self.imageView.image.size;
    CGSize boundSize = self.imageView.bounds.size;
    
    NSLog(@"frame height: %f, width %f",frameSize.height,frameSize.width);
    NSLog(@"image height: %f, width %f",imageSize.height,imageSize.width);
    NSLog(@"bound height: %f, width %f",boundSize.height,boundSize.width);
}



- (IBAction)writeAction:(id)sender {
    NSLog(@"%@ \n %@", self.text.text, self.titleOfText.text);
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://125.209.195.202:3000/card"]];
    
    request.HTTPMethod = @"POST";
    NSString* boundary = @"YOUR_BOUNDARY_STRING";
    NSString* contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];

    
    NSMutableData* body = [NSMutableData data];
    //image array
    
    if (self.chosenImage) {
        NSData* imageData = UIImageJPEGRepresentation(self.chosenImage, 1.0);
    
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"upload\"; filename=\"%@.jpg\"\r\n", self.titleOfText.text] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    //어레이로 만들것.
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n%@", self.titleOfText.text] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"content\"\r\n\r\n%@", self.text.text] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"nickname\"\r\n\r\n%@", @"노란 광대"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"partynumber\"\r\n\r\n%d", 5] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"authorid\"\r\n\r\n%@", @"0000010"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"icon\"\r\n\r\n%@", @"icon/icon2.png"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPBody = body;
    NSURLResponse* response;
    NSError* error;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    GetCards* getCards = [[GetCards alloc] init];
    NSURLRequest* getRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://125.209.195.202:3000/card/all"]];
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:getRequest delegate:getCards];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    if (!isTitleWritten) {
        textField.text = @"";
        textField.textColor = [UIColor blackColor];
        isTitleWritten = true;
    }
}

- (void) textViewDidBeginEditing:(UITextView *)textView {
    if (!isTextWritten) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        isTextWritten = true;
    }
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection*) connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (NSCachedURLResponse*)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error {
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _chosenImage = info[UIImagePickerControllerEditedImage];
    
    CGSize imageSize = _chosenImage.size;
    CGSize imageViewSize = self.imageView.frame.size;
    CGFloat correctImageViewHeight = (imageViewSize.width / imageSize.width) * imageSize.height;
    
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, imageViewSize.width, correctImageViewHeight);
    
    NSDictionary* metrics = @{@"height" : [NSNumber numberWithFloat:correctImageViewHeight]};
    NSDictionary* view = @{@"view":self.imageView};
    NSArray* constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[%@(height)]", @"view"] options:0 metrics:metrics views:view];
    
    [self.imageView addConstraints:constraint_H];
    
    [self.imageView setImage:_chosenImage];
    
//    [self.imageView setNeedsLayout];
//    [self.imageView layoutIfNeeded];
    
    CGSize frameSize = self.imageView.frame.size;
    imageSize = self.imageView.image.size;
    CGSize boundSize = self.imageView.bounds.size;
    NSLog(@"picker");
    NSLog(@"frame height: %f, width %f",frameSize.height,frameSize.width);
    NSLog(@"image height: %f, width %f",imageSize.height,imageSize.width);
    NSLog(@"bound height: %f, width %f",boundSize.height,boundSize.width);
    
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//-(UIImage*)resizeImage:(UIImage*)image imageSize:(CGSize)size {
//}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
