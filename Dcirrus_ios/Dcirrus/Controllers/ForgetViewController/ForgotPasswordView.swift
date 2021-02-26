//
//  ForgotPasswordView.swift
//  Dcirrus
//
//  Created by Gaadha on 18/09/19.
//  Copyright © 2019 Goodbits. All rights reserved.
//

import UIKit

class ForgotPasswordView: UIViewController {

    @IBOutlet weak var m_btnDone: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initialsettings()
        
    }
    
    
    @IBAction func actionback(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func actiondone(_ sender: Any) {
        Utilities.showCustomAlert(presentingView: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ForgotPasswordView{
    
    func initialsettings(){
        self.m_btnDone.layer.cornerRadius = 32
        self.m_btnDone.layer.shadowColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        self.m_btnDone.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.m_btnDone.layer.shadowRadius = 5
        self.m_btnDone.layer.shadowOpacity = 1.0
    }
}
