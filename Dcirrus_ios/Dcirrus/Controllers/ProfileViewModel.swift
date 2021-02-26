//
//  ProfileViewModel.swift
//  Dcirrus
//
//  Created by raviseta on 01/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileViewModel : NSObject{
    
    override init() {
        super.init()
    }
    
   // completionHandler:@escaping (_ result: Result<Any,Error>) -> Void
    func wsGetProfileData(completionHandler : @escaping (_ result: Result<ProfileDataResponse,Error>) -> Void){
        _ = APIManager.shared.requestGetJSON(url: eAppURL.admSingleUserProfileServiceAfter, parameters: [:], isShowIndicator: true, completionHandler: { (result) in
            switch result {
            
            case .success(let dicData):
                if let objResponse = dicData as? Dictionary<String,Any> {
                    
                    var statusCode: Int = 0
                    if let statusCodel = objResponse[APIKey.messageCode] as? Int {
                        statusCode = statusCodel
                    }

                    switch statusCode {
                    case 200...299:
                        let objUser: ProfileDataResponse = Mapper().map(JSON: objResponse)!
                        print(objUser)
                        completionHandler(.success(objUser))
                        break
                    case 433 : break
                    case 419 :showInfoMessage(messsage: errorMessage.login_messages_userapprovalrequest.rawValue)
                        break
                    case 421 :showInfoMessage(messsage: errorMessage.login_messages_deviceblockedexceedloginBussiness.rawValue)
                        break
                    case 422 :showInfoMessage(messsage: errorMessage.login_messages_userapprovalrequest.rawValue)
                        break
                    case 428 :showInfoMessage(messsage: errorMessage.login_messages_corporateExpiredUser.rawValue)
                        break
                    case 427 :showInfoMessage(messsage: errorMessage.login_messages_deviceblockedexceedloginIndividual.rawValue)
                        break
                    case 416,417 :showInfoMessage(messsage: errorMessage.login_messages_deviceblocked.rawValue)
                        break
                    case 418 :showInfoMessage(messsage: errorMessage.login_messages_deviceblockedbyuser.rawValue)
                        break
                    case 423 :showInfoMessage(messsage: errorMessage.login_messages_invalidip.rawValue)
                        break
                    case 415,420 :showInfoMessage(messsage: errorMessage.login_messages_userblocked.rawValue)
                        break
                    case 429 :showInfoMessage(messsage: errorMessage.login_messages_userfirstblocked.rawValue)
                        break
                    case 424 :showInfoMessage(messsage: errorMessage.login_messages_captchamismatch.rawValue)
                        break
                    case 425 :showInfoMessage(messsage: errorMessage.login_messages_invalidcredentials.rawValue)
                        break
                    case 431 :showInfoMessage(messsage: errorMessage.login_messages_OTPmismatch.rawValue)
                        break
                    case 432 :showInfoMessage(messsage: errorMessage.login_messages_corpsetupincomplete.rawValue)
                        break
                    case 500...599:
                        if let message = objResponse["message"] as? String {
                            if message.isBlank == false {
                               showInfoMessage(messsage: message)
                            }else {
                                showInfoMessage(messsage: "Internal Server Error server error")
                            }
                        }
                    default:
                        if let message = objResponse["message"] as? String {
                            if message.isBlank == false {
                               showInfoMessage(messsage: message)
                            }else {
                                showInfoMessage(messsage: "Internal Server Error server error")
                            }
                        }
                        break
                    }
                }

            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        })
    }
}

