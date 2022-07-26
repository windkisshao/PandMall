//
//  RealmManager.m
//  ChengYU
//
//  Created by Sherlock on 2020/1/19.
//  Copyright © 2020 Sherlock. All rights reserved.
//

#import "RealmManager.h"

@implementation RealmManager

+ (void)initRealm {
    
    NSMutableData * key = [[UICKeyChainStore dataForKey:@"ChatStory_EncryptionKey"] mutableCopy];
#ifdef DEBUG
    NSString *keyStr =  [self HexStringWithData:key];
    NSLog(@"keyStr : %@",keyStr);
#endif
    
    //E51067449C1ADC6869BEAC538D0BAA741408B5716BC2DC48B228185DD8D569CBE30F25F96959EC46178610F31EF442683206F5A245FF5291F46CB1FC7A6D7FF6

    if (!key.length) {
        key = [NSMutableData dataWithLength:64];

        (void)SecRandomCopyBytes(kSecRandomDefault, key.length, (uint8_t *)key.mutableBytes);
        [UICKeyChainStore setData:[key copy] forKey:@"ChatStory_EncryptionKey"];
    }
    
    RLMRealmConfiguration * config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 1.0;
//    config.encryptionKey = key;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *pathName = [path stringByAppendingString:@"/supermarket.realm"];
    config.fileURL = [NSURL URLWithString:pathName];

    
//    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"supermarket"] URLByAppendingPathExtension:@"realm"];
    
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {

    };
    NSLog(@"数据库目录 = %@", config.fileURL);
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

+(NSString *)HexStringWithData:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    hexStr = [hexStr uppercaseString];
    return hexStr;
}

@end
