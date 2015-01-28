//
//  NSString+RSASigner.h
//  AlipaySDK-2.0
//
//  Created by liuyan on 15-1-28.
//  Copyright (c) 2015年 Candyan. All rights reserved.
//

#import <Foundation/Foundation.h>

int rsa_sign_with_private_key_pem(char *message,
                                  int message_length,
                                  unsigned char *signature,
                                  unsigned int *signature_length,
                                  char *private_key_file_path);

@interface NSString (RSASigner)

- (NSString *)rsaSignWithPrivateKey:(NSString *)privateKey;

@end
