//
//  Encrpt.m
//  Encrpt
//
//  Created by s009 on 15/11/10.
//  Copyright © 2015年 s009. All rights reserved.
//

#import  "Encrpt.h"
//#import "DataConverter.h"

@implementation Encrpt
{
    NSArray *_reference;
}


-(id)init
{
    NSAssert(NO, @"请调用initWithKey");
    self=[super init];
    return self;
}

-(id)initWithKey:(NSString *)key
{
    self=[super init];
    if (self) {
        if (key&&key.length>0) {
            self.key=key;
        }
        else
        {
            self.key=@"beijOEIuyiiiuingbxltOUIOEIuyiiiuIIPOISefw@!$#&%*()))*%s";
        }
        
        
        _reference = [NSArray arrayWithObjects:@"0a", @"0b", @"0c", @"0d", @"0e", @"0f", @"0g", @"0h", @"0i", @"0j", @"0k", @"0l", @"0m", @"0n", @"0o", @"0p", @"0q", @"0r", @"0s", @"0t", @"0u", @"0v", @"0w", @"0x", @"0y", @"0z", @"1a", @"1b", @"1c", @"1d", @"1e", @"1f", @"1g", @"1h", @"1i", @"1j", @"1k", @"1l", @"1m", @"1n", @"1o", @"1p", @"1q", @"1r", @"1s", @"1t", @"1u", @"1v", @"1w", @"1x", @"1y", @"1z", @"2a", @"2b", @"2c", @"2d", @"2e", @"2f", @"2g", @"2h", @"2i", @"2j", @"2k", @"2l", @"2m", @"2n", @"2o", @"2p", @"2q", @"2r", @"2s", @"2t", @"2u", @"2v", @"2w", @"2x", @"2y", @"2z", @"3a", @"3b", @"3c", @"3d", @"3e", @"3f", @"3g", @"3h", @"3i", @"3j", @"3k", @"3l", @"3m", @"3n", @"3o", @"3p", @"3q", @"3r", @"3s", @"3t", @"3u", @"3v", @"3w", @"3x", @"3y", @"3z", @"4a", @"4b", @"4c", @"4d", @"4e", @"4f", @"4g", @"4h", @"4i", @"4j", @"4k", @"4l", @"4m", @"4n", @"4o", @"4p", @"4q", @"4r", @"4s", @"4t", @"4u", @"4v", @"4w", @"4x", @"4y", @"4z", @"5a", @"5b", @"5c", @"5d", @"5e", @"5f", @"5g", @"5h", @"5i", @"5j", @"5k", @"5l", @"5m", @"5n", @"5o", @"5p", @"5q", @"5r", @"5s", @"5t", @"5u", @"5v", @"5w", @"5x", @"5y", @"5z", @"6a", @"6b", @"6c", @"6d", @"6e", @"6f", @"6g", @"6h", @"6i", @"6j", @"6k", @"6l", @"6m", @"6n", @"6o", @"6p", @"6q", @"6r", @"6s", @"6t", @"6u", @"6v", @"6w", @"6x", @"6y", @"6z", @"7a", @"7b", @"7c", @"7d", @"7e", @"7f", @"7g", @"7h", @"7i", @"7j", @"7k", @"7l", @"7m", @"7n", @"7o", @"7p", @"7q", @"7r", @"7s", @"7t", @"7u", @"7v", @"7w", @"7x", @"7y", @"7z", @"8a", @"8b", @"8c", @"8d", @"8e", @"8f", @"8g", @"8h", @"8i", @"8j", @"8k", @"8l", @"8m", @"8n", @"8o", @"8p", @"8q", @"8r", @"8s", @"8t", @"8u", @"8v", @"8w", @"8x", @"8y", @"8z", @"9a", @"9b", @"9c", @"9d", @"9e", @"9f", @"9g", @"9h", @"9i", @"9j", @"9k", @"9l", @"9m", @"9n", @"9o", @"9p", @"9q", @"9r", @"9s", @"9t", @"9u", @"9v", nil];
        
    }
    return self;
}

- (int)getIndexWithString:(NSString *)str {
    int result = -1;
    for (int i = 0; i < _reference.count; i++) {
        if ([_reference[i] isEqualToString:str]) {
            result = i;
            break;
        }
    }
    return result;
}

- (NSString *)encryptWithString:(NSString *)str {
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (str == nil || str.length <= 0)
        return str;
    NSMutableString *sb = [NSMutableString string];
    
    NSInteger len = _reference.count/2;
    
    NSData *keyData=[self.key dataUsingEncoding:NSUTF8StringEncoding];
    Byte *keyByte=(Byte *)[keyData bytes];
    
    
    NSData *strData=[str dataUsingEncoding:NSUTF8StringEncoding];
    Byte *strByte=(Byte *)[strData bytes];
    
    if (self.key.length > strData.length) {
        
        NSMutableData *tempData=[[NSMutableData alloc] initWithLength:strData.length];
        
        Byte *keyTemp=(Byte *)[tempData bytes];
        
        Byte a=0;
        
        for (int i = (int)strData.length - 1; i < self.key.length; i++) {
            a += keyByte[i];
        }
        keyByte[strData.length - 1] = a;
        for (int i = 0; i < tempData.length; i++) {
            keyTemp[i] = keyByte[i];
        }
        keyByte = keyTemp;
    }
    
    keyData=[NSMutableData dataWithBytes:keyByte length:strData.length];
    
    for (int i = 0; i < strData.length; i++) {
        int index = i % self.key.length;
        
        SInt8 refData=keyByte[index];
        SInt8 data=((SInt8)strByte[i] + (SInt8)refData);
        
        if ((SInt8)data < -128 || (SInt8)data > 127) {
            data = (strByte[i] - refData);
        }
        [sb appendString:_reference[len + data]];
    }
    return sb;
}

- (NSString *)decryptWithString:(NSString *)str {
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (str == nil || str.length <= 0)
        return str;
//    NSString *strResult = @"";
    
    unsigned long len = _reference.count / 2;
    NSData *keyData=[self.key dataUsingEncoding:NSUTF8StringEncoding];
    Byte *keyByte=(Byte *)[keyData bytes];
    int strLen = (int)str.length / 2;

    NSMutableData *resultData=[[NSMutableData alloc] initWithLength:strLen];
    Byte *result=(Byte *)[resultData bytes];
    
//    NSMutableString *resultStr=[NSMutableString string];
    
    if (self.key.length > strLen) {
        NSMutableData *tempData=[[NSMutableData alloc] initWithLength:strLen];
        
        Byte *keyTemp=(Byte *)[tempData bytes];
        
        Byte a=0;
        for (int i = strLen - 1; i <self.key.length; i++) {
            a += keyByte[i];
        }
        keyByte[strLen - 1] = a;
        for (int i = 0; i < tempData.length; i++) {
            keyTemp[i] = keyByte[i];
        }
        keyByte = keyTemp;
    }
    for (int i = 0; i < strLen; i++) {
        int index = i % self.key.length;
        NSString *s = [str substringWithRange:NSMakeRange(i * 2, 2)];
        
        SInt8 x = [self getIndexWithString:s];
        SInt8 refData = keyByte[index];
        SInt8 data = x - (int)len;
        SInt8 d =  (data - refData);
        if (d < -128 || d > 127) {
            d =  (data + refData);
        }
        
        result[i]=d;
    }
    
    NSString * strResult = [[NSString alloc] initWithBytes:result length:resultData.length encoding:NSUTF8StringEncoding];
    
    return strResult;
}
//
//- (NSString *)encryptStrWithString:(NSString *)str {
//    NSMutableData *brData=[[NSMutableData alloc] initWithLength:0];
//    Byte *br=(Byte *)[brData bytes];
//    
//    
//    NSData *keyData=[self.key dataUsingEncoding:NSUTF8StringEncoding];
//    Byte *keyByte=(Byte *)[keyData bytes];
//    
//    
//    NSData *strData=[str dataUsingEncoding:NSUTF8StringEncoding];
//    Byte *strByte=(Byte *)[strData bytes];
//    
//    int result[strData.length];
//    
//    if (keyData.length > strData.length) {
//        NSMutableData *tempData=[[NSMutableData alloc] initWithLength:strData.length];
//        
//        Byte *keyTemp=(Byte *)[tempData bytes];
//        
//        Byte a=0;
//        for (int i = (int)strData.length - 1; i <keyData.length; i++) {
//            a += keyByte[i];
//        }
//        keyByte[strData.length - 1] = a;
//        for (int i = 0; i < keyData.length; i++) {
//            keyTemp[i] = keyByte[i];
//        }
//        keyByte = keyTemp;
//    }
//    int pos = 23;
//    for (int i = 0; i < strData.length; i++) {
//        Byte b = strByte[i];
//        int data = 0xffff & b;
//        int index = i % keyData.length;
//        index = abs((int)keyByte[index]) % pos;
//        data = ~data;
//        data = data << index;
//        result[i] = data;
//    }
//    NSString *by = [DataConverter intsToBytes:[NSString stringWithUTF8String:result]];
//    
//    return by;
//    
//}
//
//- (NSString *)decrptByteWithString:(NSString *)str {
//        NSString *strResult = @"";
//        char* keyByte = (char *)[self.key UTF8String];
//    
//        NSString * strInt = [DataConverter bytesToInts:str];
//        char result[(strInt.length)];;
//        if (strlen(keyByte) > strInt.length)
//    {
//          //  byte[] keyTemp = new byte[strInt.length];
//            char keyTemp[strInt.length ];
//            char a = 0;
//            for (int i = strInt.length - 1; i < strlen(keyByte); i++) {
//                a += keyByte[i];
//            }
//            keyByte[strInt.length - 1] = a;
//            for (int i = 0; i < strlen(keyByte); i++) {
//                keyTemp[i] = keyByte[i];
//            }
//            keyByte = keyTemp;
//        }
//        int pos = 23;
//        for (int i = 0; i < strInt.length; i++) {
//            int index = i % strlen(keyByte);
//            index = abs(keyByte[index]) % pos;
//            int a = strInt[i] >> index;
//            a = ~a;
//            byte by = (byte) a;
//            result[i] = by;
//        }
//        strResult = new String(result, "utf-8");
//    
//    return strResult;
//}

@end
