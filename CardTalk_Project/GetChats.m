//
//  GetChats.m
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 28..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import "GetChats.h"

@implementation GetChats

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
    NSLog(@"receive response");
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (NSCachedURLResponse*)connection:(NSURLConnection*)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection {
    NSError* jsonError;
    self.chats = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&jsonError];
    NSDictionary* userInfo = @{@"chats" : self.chats};
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"getChats" object:nil userInfo:userInfo];
    
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error {
    
}


@end
