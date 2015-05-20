//
//  DataConnect.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 20..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCards : NSObject <NSURLConnectionDelegate>

@property (strong, nonatomic) NSMutableData* responseData;
@property (strong, nonatomic) NSMutableArray* cards;

@end
