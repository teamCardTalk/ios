//
//  DetailModel.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 14..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardModel.h"
#import "ChatModel.h"


@interface DetailModel : NSObject

@property (strong, nonatomic) CardModel* card;
@property (strong, nonatomic) NSString* segueIdentifier;

@end
