//
//  PersonalFileViewModel.swift
//  Dcirrus
//
//  Created by raviseta on 03/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import ObjectMapper

class PersonalFileViewModel : NSObject{
    
    override init() {
        super.init()
    }
    
    func wsGetPersonalFiles(completionHandler : @escaping (_ result: Result<PersonalFilesResponse,Error>) -> Void){
        _ = APIManager.shared.requestGetJSON(url: eAppURL.fetchAllAdmFolderChildListResponse, parameters: [:], isShowIndicator: true, completionHandler: { (result) in
            switch result {
            
            case .success(let dicData):
                if let objResponse = dicData as? Dictionary<String,Any> {
                    let objUser: PersonalFilesResponse = Mapper().map(JSON: objResponse)!
                    print(objUser)
                    completionHandler(.success(objUser))
                }

            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        })
    }
}
