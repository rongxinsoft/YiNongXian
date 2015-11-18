//
//  Encrpt.h
//  Encrpt
//
//  Created by s009 on 15/11/10.
//  Copyright © 2015年 s009. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encrpt : NSObject

@property (nonatomic, strong) NSString *key;

-(id)initWithKey:(NSString *)key;

- (NSString *)encryptWithString:(NSString *)str;

- (NSString *)decryptWithString:(NSString *)str;

@end
