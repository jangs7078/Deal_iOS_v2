/***********************************************************************************************************************
 *
 * API.AI iOS SDK - client-side libraries for API.AI
 * ==========================================
 *
 * Copyright (C) 2014 by Speaktoit, Inc. (https://www.speaktoit.com)
 * https://www.api.ai
 *
 ***********************************************************************************************************************
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 ***********************************************************************************************************************/
#import "AIRequest.h"

typedef void(^SoundLevelHandleBlock)(AIRequest *request, float level);
typedef void(^SoundRecordBeginBlock)(AIRequest *request);
typedef void(^SoundRecordEndBlock)(AIRequest *request);

@interface AIVoiceRequest : AIRequest

@property(nonatomic, copy) SoundLevelHandleBlock soundLevelHandleBlock;

@property(nonatomic, copy) SoundRecordBeginBlock soundRecordBeginBlock;
@property(nonatomic, copy) SoundRecordEndBlock soundRecordEndBlock;

@property(nonatomic, assign) BOOL useVADForAutoCommit;

- (void)commitVoice;

@end
