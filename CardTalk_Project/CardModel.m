//
//  CardModel.m
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 14..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import "CardModel.h"

static const NSString* hostName = @"http://125.209.195.202:3000";

@implementation CardModel

-(instancetype)initWithAuthor:(NSString*)author
                        place:(NSString*)place
                      content:(NSString*)content
                         date:(NSDate*)date
                    iconImage:(UIImage*)iconImage
                contentImages:(NSArray*)contentImages {
    self = [super init];

    if (self) {
        _author = author;
        _place = place;
        _content = content;
        _date = date;
        _iconImage = iconImage;
        _contentImages = [NSMutableArray arrayWithArray:contentImages];
        [self convertDateToString];
    }
    
    return self;
}

- (instancetype)initWithCardDict:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _id = [dictionary objectForKey:@"_id"];
        _authorid = [dictionary objectForKey:@"authorid"];
        _nickname = [dictionary objectForKey:@"nickname"];
        _chatting = [dictionary objectForKey:@"chatting"];
        _chattingtime = [dictionary objectForKey:@"chattingtime"];
        _content = [dictionary objectForKey:@"content"];
        _createtime = [dictionary objectForKey:@"createtime"];
        _file = [dictionary objectForKey:@"file"];
        _status = [[dictionary objectForKey:@"status"] integerValue];
        _partynumber = [[dictionary objectForKey:@"partynumber"] integerValue];
        _title = [dictionary objectForKey:@"title"];
        _icon = [dictionary objectForKey:@"icon"];
        _contentImages = [[NSMutableArray alloc] init];
        _queue = [[NSOperationQueue alloc] init];
        
        [self setAuthorAndPlaceByTitle];
        [self setDateFromCreateTime];
        [self imageRequest];
    }
    
    return self;
}

-(void)setAuthorAndPlaceByTitle {
    @try {
        NSArray* titleArray = [self.title componentsSeparatedByString:@"의 "];
        _author = titleArray[0];
        _place = titleArray[1];
    }
    @catch (NSException *exception) {
        _author = @"오류";
        _place = @"파싱 잘못됨";
    }
}

- (void) setDateFromCreateTime {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd yyyy HH:mm:ss ZZZ"];
    self.date = [dateFormatter dateFromString:self.createtime];
}

-(void) convertDateToString {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM월 dd일 hh:mm a"];
    self.dateString = [dateFormatter stringFromDate:self.date];
}

- (void) imageRequest {
    NSString* iconPath = [self.icon stringByReplacingOccurrencesOfString:@"/" withString:@"="];
    NSString* iconURL = [NSString stringWithFormat:@"%@/image/%@", hostName, iconPath];
    NSURLRequest* requestIcon = [NSURLRequest requestWithURL:[NSURL URLWithString:iconURL]];
  
    [NSURLConnection
     sendAsynchronousRequest:requestIcon
     queue:self.queue
     completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
         self.iconImage = [UIImage imageWithData:data];
         NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
         [nc postNotificationName:@"reload" object:nil];
     }];
    
    for (NSDictionary* imageDict in self.file) {
        NSString* imagePath = [imageDict[@"path"] stringByReplacingOccurrencesOfString:@"data/" withString:@"photo="];
        NSString* imageURL = [NSString stringWithFormat:@"%@/image/%@", hostName, imagePath];
        NSURLRequest* requestImage = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
        [NSURLConnection
         sendAsynchronousRequest:requestImage
         queue:self.queue
         completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
             UIImage* image = [UIImage imageWithData:data];
             [self.contentImages addObject:image];
             NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
             [nc postNotificationName:@"reload" object:nil];
         }];
    }
    
    

}

@end
