//
//  GetImage.m
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 20..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import "GetImage.h"

@implementation GetImage

-(instancetype)initWithCardModel:(CardModel*)card {
    self = [super init];
    
    if (self) {
        _card = card;
    }
    
    return self;
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData = [[NSMutableData alloc] init];
    NSLog(@"receive response");
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (NSCachedURLResponse*)connection:(NSURLConnection*)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection {
    
    UIImage* image = [UIImage imageWithData:self.responseData];
    
    NSDictionary* userInfo = @{@"image" : image};
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"getImage" object:nil userInfo:userInfo];
    
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error {
    
}


@end
