//
//  SearchViewController.swift
//  vampire
//
//  Created by vikingdr on 3/23/20.
//  Copyright © 2020 vikingdr. All rights reserved.
//

import UIKit
import CoreData
import JGProgressHUD
import SDWebImage
import WebKit

class SearchViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var recentChangesLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var developerAddressLbl: UILabel!
    @IBOutlet weak var developerLbl: UILabel!
    @IBOutlet weak var developerEmailLbl: UILabel!
    
    var dataApps : Array<Apps> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search App by email"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickSearchClicked(_ sender: Any) {
        self.emailTextField.resignFirstResponder()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Apps")
        let cond2 = NSPredicate(format: "developerEmail CONTAINS[c] %@", emailTextField.text!)
        fetchRequest.predicate = cond2
        dataApps = try! manageContent.fetch(fetchRequest) as! [Apps]
        
        if(dataApps.count > 0) {
            
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Will display first app only"
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 1.0)
            
            let app = dataApps.first!
            titleLbl.text = "Title" + app.title!
            summaryLbl.text = app.summary
            if(app.isSent) {
                status.text = "Status: Email Sent"
            } else {
                status.text = "Status: Not Send"
            }
            
            photoImageView?.contentMode = .scaleAspectFit
            photoImageView?.sd_setImage(with: URL(string: app.icon!), placeholderImage: UIImage(named: "placeh.png"))
            developerEmailLbl.text = "Developer Email: " + (app.developerEmail ?? "")
            developerLbl.text = "Developer: " + (app.developer ?? "")
            developerAddressLbl.text = "Developer Address: " + (app.developerAddress ?? "")
            genreLbl.text = "Genre (type): " + app.genreId!
            recentChangesLbl.text = "Recent Updates: " + (app.recentChanges ?? "")
            
        } else {
            
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Sorry, Not found"
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)

        }
    }
    
    @IBAction func gotoStoreClicked(_ sender: Any) {
        
        if(dataApps.count>0) {
            
            let app = dataApps.first!
            let webVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebStoreViewController") as? WebStoreViewController
            webVC?.urlStr = app.url
            self.navigationController!.pushViewController(webVC!, animated: true)
            
        } else {
            
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Sorry, Not found"
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)

        }
    }
    
    @IBAction func didKeyEnded(_ sender: Any) {
        self.clickSearchClicked(AnyClass.self)
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
