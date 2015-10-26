//
//  NSString+AlipayOrder.h
//  AlipayDemo
//
//  Created by liuyan on 10/22/15.
//  Copyright © 2015 Candyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AlipayOrder)

+ (NSString *)generateAlipayTradeNo;

+ (NSString *)alipayOrderWithPartner:(NSString *)partnerId
                              seller:(NSString *)sellerId
                         productName:(NSString *)subject
                  productDescription:(NSString *)body
                              amount:(NSString *)totalFee
                           notifyURL:(NSString *)notifiURL
                         tradeNumber:(NSString *)tradeNO
                       rsaPrivateKey:(NSString *)rsaPrivateKey;

/**
 Create Alipay order description. you can call `payOrder:fromScheme:callback:` with it straightforward.
 @warning You‘d better to create the order description on your server.
*/

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
                       rsaPrivateKey:(NSString *)rsaPrivateKey;

@end
