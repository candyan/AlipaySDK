//
//  NSString+AlipaySigner.h
//  AlipayDemo
//
//  Created by liuyan on 10/23/15.
//  Copyright © 2015 Candyan. All rights reserved.
//

#import <Foundation/Foundation.h>

int rsa_sign_with_private_key_pem(char *message, int message_length, unsigned char *signature,
                                  unsigned int *signature_length, char *private_key_file_path);

@interface NSString (AlipaySigner)

- (NSString *)alipayOrderRSASignWithPrivateKey:(NSString *)privateKey;
+ (NSString *)fileFormattedStringForPrivateKey:(NSString *)privateKey;

@end
