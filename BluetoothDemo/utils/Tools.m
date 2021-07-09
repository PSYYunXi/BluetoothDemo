//
//  Tools.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/6.
//

#import "Tools.h"

@implementation Tools

//Uint64转NSData
+ (NSData *)dataFormUint64:(UInt64)val {
    UInt8 bit1 = (val & 0xff00000000000000) >> 56;
    UInt8 bit2 = (val & 0xff000000000000) >> 48;
    UInt8 bit3 = (val & 0xff0000000000) >> 40;
    UInt8 bit4 = (val & 0xff00000000) >> 32;
    UInt8 bit5 = (val & 0xff000000) >> 24;
    UInt8 bit6 = (val & 0xff0000) >> 16;
    UInt8 bit7 = (val & 0xff00) >> 8;
    UInt8 bit8 = (val & 0xff);
    const unsigned char bytes[] = {bit1, bit2, bit3, bit4, bit5, bit6, bit7, bit8};
    NSData * data = [NSData dataWithBytes:bytes length:8];
    return data;
}

//Uint32转NSData
+ (NSData *)dataFormUint32:(UInt32)val {
    UInt8 bit1 = (val & 0xff000000) >> 24;
    UInt8 bit2 = (val & 0xff0000) >> 16;
    UInt8 bit3 = (val & 0xff00) >> 8;
    UInt8 bit4 = (val & 0xff);
    const unsigned char bytes[] = {bit1, bit2, bit3, bit4};
    NSData * data = [NSData dataWithBytes:bytes length:4];
    return data;
}

//Uint16转NSData
+ (NSData *)dataFormUint16:(UInt16)val {
    UInt8 bit1 = (val & 0xff00) >> 8;
    UInt8 bit2 = (val & 0xff);
    const unsigned char bytes[] = {bit1, bit2};
    NSData * data = [NSData dataWithBytes:bytes length:2];
    return data;
}

//Uint8转NSData
+ (NSData *)dataFormUint8:(UInt8)val {
    UInt8 bit1 = (val & 0xff);
    const unsigned char bytes[] = {bit1};
    NSData * data = [NSData dataWithBytes:bytes length:1];
    return data;
}

///** 16进制字符串转NSData*/
//+ (NSData *)hexToByteToNSData:(NSString *)hexString {
//    int j=0;
//    Byte bytes[[hexString length]/2];
//    for(int i=0;i<[hexString length];i++) {
//        int int_ch;  ///两位16进制数转化后的10进制数
//        unichar hex_char1 = [hexString characterAtIndex:i];
//        int int_ch1;
//        if(hex_char1 >= '0' && hex_char1 <='9')
//            int_ch1 = (hex_char1-48)*16;
//        else if(hex_char1 >= 'A' && hex_char1 <='F')
//            int_ch1 = (hex_char1-55)*16;
//        else
//            int_ch1 = (hex_char1-87)*16;
//        i++;
//        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
//        int int_ch2;
//        if(hex_char2 >= '0' && hex_char2 <='9')
//            int_ch2 = (hex_char2-48);
//        else if(hex_char2 >= 'A' && hex_char2 <='F')
//            int_ch2 = hex_char2-55;
//        else
//            int_ch2 = hex_char2-87;
//        int_ch = int_ch1+int_ch2;
//        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
//        j++;
//    }
//    NSData *newData = [[NSData alloc] initWithBytes:bytes length:[hexString length]/2 ];
//    return newData;
//}
//
///** NSData转16进制字符串*/
//+ (NSString *)convertDataToHexStr:(NSData *)data {
//    if (!data || [data length] == 0) {
//        return @"";
//    }
//    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
//    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
//        unsigned char *dataBytes = (unsigned char*)bytes;
//        for (NSInteger i = 0; i < byteRange.length; i++) {
//            NSString * hexStr= [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
//            if([hexStr length] == 2) {
//                [string appendString:hexStr];
//            } else {
//                [string appendFormat:@"0%@", hexStr];
//            }
//        }
//    }];
//    return string;
//}
//
////16进制字符串转10进制number
//+ (NSNumber *) numberHexString:(NSString *)aHexString {
//    if (nil == aHexString){
//        return nil;
//    }
//    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
//    unsigned long long longlongValue;
//    [scanner scanHexLongLong:&longlongValue];
//    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
//    return hexNumber;
//}
//
////10进制转16进制字符串
//+ (NSString *)hexFromInt:(NSInteger)val {
//    return [NSString stringWithFormat:@"%lX", (long)val];
//}
//

@end
