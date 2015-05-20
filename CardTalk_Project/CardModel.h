//
//  CardModel.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 14..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CardModel : NSObject

@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* place;
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSDate* date;
@property (strong, nonatomic) UIImage* iconImage;
@property (strong, nonatomic) NSMutableArray* contentImages;
@property (strong, nonatomic) NSString* dateString;

@property (strong, nonatomic) NSString* id;
@property (strong, nonatomic) NSString* authorid;
@property (strong, nonatomic) NSString* nickname;
@property (strong, nonatomic) NSString* chatting;
@property (strong, nonatomic) NSString* chattingtime;
@property (strong, nonatomic) NSString* createtime;
@property (strong, nonatomic) NSArray* file;
@property NSInteger status;
@property NSInteger partynumber;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* icon;

@property (strong, nonatomic) NSOperationQueue* queue;


-(instancetype)initWithAuthor:(NSString*)author
                        place:(NSString*)place
                      content:(NSString*)content
                         date:(NSDate*)date
                    iconImage:(UIImage*)iconImage
                contentImages:(NSArray*)contentImages;

-(instancetype)initWithCardDict:(NSDictionary*)dictionary;

- (void) convertDateToString;

@end
