//
//  ChatModel.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 14..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ChatModel : NSObject

@property (strong, nonatomic) NSString* articleid;
@property (strong, nonatomic) NSString* nickname;
@property (strong, nonatomic) NSString* userid;
@property (strong, nonatomic) NSString* icon;
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSString* time;
@property (strong, nonatomic) NSString* id;
@property (strong, nonatomic) NSOperationQueue* queue;
@property (strong, nonatomic) UIImage* iconImage;

-(instancetype)initWithChatDict:(NSDictionary*)dictionary;

@end
