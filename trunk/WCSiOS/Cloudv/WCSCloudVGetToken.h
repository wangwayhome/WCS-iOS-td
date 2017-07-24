//
//  WCSCloudVGetToken.h
//  WCSiOS
//
//  Created by wangwayhome on 2017/7/24.
//  Copyright © 2017年 CNC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCSCloudVGetToken : NSObject


/**
 获取视频上传令牌
 
 @param userId 用户id （必填）
 @param token 校验凭证 （必填）
 @param originFileName 上传文件名 （必填）
 @param fileURL 上传文件路径 （必填）
 @param domian 视频域名
 @param cmd 一体化命令
 @param overwrite 上传策略
 @param videoSource 视频来源
 @param completionHandler 回调结果（必填）
 */
-(void)getTokenWithUserId:(NSString *)userId
                    Token:(NSString *)token
           OriginFileName:(NSString *)originFileName
                  fileURL:(NSURL *)fileURL
                   domian:(NSString *)domian
                      cmd:(NSString *)cmd
                overwrite:(NSString *)overwrite
              videoSource:(NSString *)videoSource
        completionHandler:(void (^)(NSData *  data, NSURLResponse *  response, NSError *  error))completionHandler;
@end
