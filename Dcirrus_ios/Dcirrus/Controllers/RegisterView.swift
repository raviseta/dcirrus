//
//  RegisterView.swift
//  Dcirrus
//
//  Created by Gaadha on 19/09/19.
//  Copyright © 2019 Goodbits. All rights reserved.
//

import UIKit

class RegisterView: UIViewController {
    
    
    @IBOutlet weak var m_btnDone: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initialsettings()
        
    }
    

    @IBAction func actionBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func actionrefreshCaptcha(_ sender: Any) {
        
    }
    
    @IBAction func actionDone(_ sender: Any) {
        self.view.makeToast("Sign-up request has been sent successfully.\nOur team will get in touch with you soon", duration: 1.5, position: .center)
    }
    
}

extension RegisterView {
    
    func initialsettings() {
        self.m_btnDone.layer.cornerRadius = 32
        self.m_btnDone.layer.shadowColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        self.m_btnDone.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.m_btnDone.layer.shadowRadius = 5
        self.m_btnDone.layer.shadowOpacity = 1.0
    }
    
}
