//
//  NSString+AlipayOrder.m
//  AlipayDemo
//
//  Created by liuyan on 10/22/15.
//  Copyright © 2015 Candyan. All rights reserved.
//

#import "NSString+AlipayOrder.h"
#import <PupaFoundation/PupaFoundation.h>

#import "NSString+AlipaySigner.h"

@implementation NSString (AlipayOrder)

+ (NSString *)generateAlipayTradeNo
{
    NSMutableString *tradeNo = [NSMutableString string];
    [tradeNo appendString:[[NSDate date] stringWithFormat:@"yyyyMMddHHmmss"]];
    [tradeNo appendFormat:@"%d", arc4random() % 100000];
    return tradeNo;
}

+ (NSString *)alipayOrderWithPartner:(NSString *)partnerId
                              seller:(NSString *)sellerId
                         productName:(NSString *)subject
                  productDescription:(NSString *)body
                              amount:(NSString *)totalFee
                           notifyURL:(NSString *)notifiURL
                         tradeNumber:(NSString *)tradeNO
                       rsaPrivateKey:(NSString *)rsaPrivateKey
{
    return [NSString alipayOrderWithPartner:partnerId
                                     seller:sellerId
                                productName:subject
                         productDescription:body
                                     amount:totalFee
                                  notifyURL:notifiURL
                                tradeNumber:tradeNO
                                    service:nil
                                paymentType:nil
                               inputCharset:nil
                                     itBPay:nil
                                    showURL:nil
                                      appId:nil
                                extraParams:nil
                              rsaPrivateKey:rsaPrivateKey];
}

+ (NSString *)alipayOrderWithPartner:(NSString *)partnerId
                              seller:(NSString *)sellerId
                         productName:(NSString *)subject
                  productDescription:(NSString *)body
                              amount:(NSString *)totalFee
                           notifyURL:(NSString *)notifiURL
                         tradeNumber:(NSString *)tradeNO
                             service:(NSString *)service
                         paymentType:(NSString *)paymentType
                        inputCharset:(NSString *)inputCharset
                              itBPay:(NSString *)itBPay
                             showURL:(NSString *)showURL
                               appId:(NSString *)appId
                         extraParams:(NSDictionary *)extraParams
                       rsaPrivateKey:(NSString *)rsaPrivateKey
{
    if (partnerId == nil || sellerId == nil || subject == nil || body == nil || totalFee == nil || notifiURL == nil ||
        rsaPrivateKey == nil) {
        return nil;
    }

    NSMutableString *orderDescription = [NSMutableString string];

    [orderDescription appendFormat:@"partner=\"%@\"", partnerId];
    [orderDescription appendFormat:@"&seller_id=\"%@\"", sellerId];
    [orderDescription appendFormat:@"&subject=\"%@\"", subject];
    [orderDescription appendFormat:@"&body=\"%@\"", body];
    [orderDescription appendFormat:@"&total_fee=\"%@\"", totalFee];
    [orderDescription appendFormat:@"&notify_url=\"%@\"", notifiURL];
    [orderDescription
        appendFormat:@"&out_trade_no=\"%@\"", (tradeNO == nil) ? [NSString generateAlipayTradeNo] : tradeNO];
    [orderDescription appendFormat:@"&service=\"%@\"", (service != nil ? service : @"mobile.securitypay.pay")];
    [orderDescription appendFormat:@"&payment_type=\"%@\"", (paymentType != nil ? paymentType : @"1")];
    [orderDescription appendFormat:@"&_input_charset=\"%@\"", (inputCharset != nil ? inputCharset : @"utf-8")];
    [orderDescription appendFormat:@"&it_b_pay=\"%@\"", (itBPay != nil ? itBPay : @"30m")];

    if (showURL != nil) {
        [orderDescription appendFormat:@"&show_url=\"%@\"", showURL];
    }

    if (appId != nil) {
        [orderDescription appendFormat:@"&app_id=\"%@\"", appId];
    }

    for (NSString *key in [extraParams allKeys]) {
        [orderDescription appendFormat:@"&%@=\"%@\"", key, [extraParams objectForKey:key]];
    }

    NSString *signedString = [orderDescription alipayOrderRSASignWithPrivateKey:rsaPrivateKey];

    return [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderDescription, signedString, @"RSA"];
}

@end
