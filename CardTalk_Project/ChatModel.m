//
//  ChatModel.m
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 14..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import "ChatModel.h"

static const NSString* hostName = @"http://125.209.195.202:3000";

@implementation ChatModel

-(instancetype)initWithChatDict:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        _articleid = [dictionary objectForKey:@"articleid"];
        _nickname = [dictionary objectForKey:@"nickname"];
        _userid = [dictionary objectForKey:@"userid"];
        _icon = [dictionary objectForKey:@"icon"];
        _content = [dictionary objectForKey:@"content"];
        _time = [dictionary objectForKey:@"time"];
        _id = [dictionary objectForKey:@"_id"];
        _queue = [[NSOperationQueue alloc] init];
        
        [self iconRequest];
    }
    
    return self;
}

-(void) iconRequest {
    NSString* iconURL = [NSString stringWithFormat:@"%@/image/icon=%@", hostName, self.icon];
    
    NSURLRequest* requestIcon = [NSURLRequest requestWithURL:[NSURL URLWithString:iconURL]];
    
    [NSURLConnection sendAsynchronousRequest:requestIcon queue:self.queue completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
        UIImage* image = [UIImage imageWithData:data];
        self.iconImage = image;
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"detailReload" object:nil];
    }];
}

@end
