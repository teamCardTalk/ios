//
//  GetImage.h
//  CardTalk_Project
//
//  Created by Hyungjin Ko on 2015. 4. 20..
//  Copyright (c) 2015년 Hyungjin Ko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GetCards.h"
#import "CardModel.h"

@interface GetImage : GetCards

-(instancetype)initWithCardModel:(CardModel*)card;

@property (nonatomic, strong) CardModel* card;

@end
