//
//  WCSCloudVGetToken.m
//  WCSiOS
//
//  Created by wangwayhome on 2017/7/24.
//  Copyright © 2017年 CNC. All rights reserved.
//

#import "WCSCloudVGetToken.h"
#import "WCSCommonAlgorithm.h"
@implementation WCSCloudVGetToken
#define WCSPStrEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? @"" : str )

//获取视频上传令牌
-(void)getTokenWithUserId:(NSString *)userId
                    Token:(NSString *)token
           OriginFileName:(NSString *)originFileName
                  fileURL:(NSURL *)fileURL
                   domian:(NSString *)domian
                      cmd:(NSString *)cmd
                overwrite:(NSString *)overwrite
              videoSource:(NSString *)videoSource
        completionHandler:(void (^)(NSData *  data, NSURLResponse *  response, NSError *  error))completionHandler
{
  NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
  NSString *fileMd5 =[WCSCommonAlgorithm MD5StringFromString:fileURL.absoluteString];
  
  UInt64 fileSize = 0;
  NSError *error = nil;
  NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fileURL.absoluteString error:&error];
  if(!error){
    fileSize = (UInt64)[attributes fileSize];
  }  
  NSString *post =[NSString stringWithFormat:@"userId=%@&token=%@&timeStamp=%@&originFileName=%@&fileMd5=%@&originFileSize=%@&domian=%@&cmd=%@&overwrite=%@&videoSource=%@",userId,token,timeStamp,originFileName,fileMd5,@(fileSize),WCSPStrEmpty(domian),WCSPStrEmpty(cmd),WCSPStrEmpty(overwrite),WCSPStrEmpty(videoSource)];
  NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
  NSString *postLength = [NSString stringWithFormat:@"%d",(int)[postData length]];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.cloudv.haplat.net/vod/videoManage/getUploadToken"]]];
  [request setHTTPMethod:@"POST"];
  [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPBody:postData];
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:completionHandler
                               ];
  [task resume];
}
@end