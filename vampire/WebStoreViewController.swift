//
//  WebStoreViewController.swift
//  vampire
//
//  Created by vikingdr on 3/23/20.
//  Copyright © 2020 vikingdr. All rights reserved.
//

import UIKit
import WebKit

class WebStoreViewController: UIViewController {

    @IBOutlet weak var mWebView: WKWebView!
    
    var urlStr : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: urlStr)
        mWebView.load(URLRequest(url: url!))

        // Do any additional setup after loading the view.
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
