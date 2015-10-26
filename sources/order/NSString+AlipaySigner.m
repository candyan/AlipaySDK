//
//  NSString+AlipaySigner.m
//  AlipayDemo
//
//  Created by liuyan on 10/23/15.
//  Copyright © 2015 Candyan. All rights reserved.
//

#import "NSString+AlipaySigner.h"
#import <PupaFoundation/PupaFoundation.h>

#import <OpenSSL/rsa.h>
#import <OpenSSL/pem.h>
#import <string.h>

#pragma mark - RSA

int rsa_sign_with_private_key_pem(char *message, int message_length, unsigned char *signature,
                                  unsigned int *signature_length, char *private_key_file_path)
{
    unsigned char sha1[20];
    SHA1((unsigned char *)message, message_length, sha1);
    int success = 0;
    BIO *bio_private = NULL;
    RSA *rsa_private = NULL;
    bio_private = BIO_new(BIO_s_file());
    BIO_read_filename(bio_private, private_key_file_path);
    rsa_private = PEM_read_bio_RSAPrivateKey(bio_private, NULL, NULL, "");
    if (rsa_private != nil) {
        if (1 == RSA_check_key(rsa_private)) {
            int rsa_sign_valid = RSA_sign(NID_sha1, sha1, 20, signature, signature_length, rsa_private);
            if (1 == rsa_sign_valid) {
                success = 1;
            }
        }
        BIO_free_all(bio_private);
    } else {
        NSLog(@"rsa_private read error : private key is NULL");
    }

    return success;
}

#pragma mark - Signer

@implementation NSString (AlipaySigner)

- (NSString *)alipayOrderRSASignWithPrivateKey:(NSString *)privateKey
{
    // Create Privatekey file in Document folder
    NSString *signedString = nil;
    NSString *documentPath =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [documentPath stringByAppendingPathComponent:@"AlipayOrder-RSAPrivateKey"];

    //
    // Write private key to file 把密钥写入文件
    //
    NSString *formattedKey = [NSString fileFormattedStringForPrivateKey:privateKey];

    NSError *error = nil;
    [formattedKey writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];

    const char *message = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned long messageLength = strlen(message);
    unsigned char *sig = (unsigned char *)malloc(256);
    unsigned int sig_len;
    int ret =
        rsa_sign_with_private_key_pem((char *)message, (int)messageLength, sig, &sig_len, (char *)[path UTF8String]);
    // base64 & URL Encode signed string
    if (ret == 1) {
        NSData *signatureData = [NSData dataWithBytes:sig length:sig_len];
        int signatureLength = (int)[signatureData length];
        unsigned char *outputBuffer = (unsigned char *)malloc(2 * 4 * (signatureLength / 3 + 1));
        int outputLength = EVP_EncodeBlock(outputBuffer, [signatureData bytes], signatureLength);
        outputBuffer[outputLength] = '\0';
        NSString *base64String = [NSString stringWithCString:(char *)outputBuffer encoding:NSASCIIStringEncoding];
        free(outputBuffer);
        signedString = [base64String encodingStringUsingURLEscape];
    }

    free(sig);

    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];

    return signedString;
}

+ (NSString *)fileFormattedStringForPrivateKey:(NSString *)privateKey
{
    NSString *trimmedString = [privateKey stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    const char *c = [trimmedString UTF8String];
    int len = (int)[trimmedString length];
    NSMutableString *result = [NSMutableString string];
    [result appendString:@"-----BEGIN PRIVATE KEY-----\n"];
    int index = 0;
    while (index < len) {
        char cc = c[index];
        [result appendFormat:@"%c", cc];
        if ((index + 1) % 64 == 0) {
            [result appendString:@"\n"];
        }
        index++;
    }
    [result appendString:@"\n-----END PRIVATE KEY-----"];
    return result;
}

@end
