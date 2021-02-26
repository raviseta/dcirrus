//
//  LoginViewModel.swift
//  Dcirrus
//
//  Created by raviseta on 28/01/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation

class LoginViewModel : NSObject{
    
    override init() {
        super.init()
        
    }
    
    func checkValidation(with LoginId : String?, Password : String? , BusinessID : String?){
        if let loginID = LoginId, loginID.isBlank == true {
            
        }else if !(LoginId!.isValidEmail){
          
        }
        if let pass = Password, pass.isBlank == true {
        }
        if let businessID = BusinessID, businessID.isBlank == true {
           
        }
    }
    
    func loginaction() {
           Utilities.setRootViewController(vcName: "TabBarViewController")
       }
    
}
