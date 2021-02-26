//
//  TermsAndConditionsViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 25/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import WebKit

class TermsAndConditionsViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Terms and Conditions"
        let htmlPath = Bundle.main.path(forResource: "sample_TC", ofType: "html")
        let htmlUrl = URL(fileURLWithPath: htmlPath!, isDirectory: false)
        webView.loadFileURL(htmlUrl, allowingReadAccessTo: htmlUrl)
       
    }
    
    
}
