//
//  SecondViewController.swift
//  vampire
//
//  Created by vikingdr on 3/22/20.
//  Copyright © 2020 vikingdr. All rights reserved.
//

import UIKit
import CoreData
import MailController
import SDWebImage

class SecondViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    let cellReuseIdentifier = "cell"
    var isDisplayEmail = true
    var dataApps : Array<Apps> = []

    @IBOutlet weak var mTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        self.refreshBtnClicked((Any).self)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        // set the text from the data model
        let app = dataApps[indexPath.row]
        cell.imageView?.sd_setImage(with: URL(string: app.icon!), placeholderImage: UIImage(named: "placeh.png"))
        cell.imageView?.contentMode = .scaleAspectFit
        if isDisplayEmail {
            cell.textLabel?.text = app.developerEmail
        } else {
            cell.textLabel?.text = app.developerAddress
        }
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext

            let app = dataApps[indexPath.row]
            app.isSent = true
            app.didSave()
            
            tableView.beginUpdates()
            dataApps.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            do{
                try manageContent.save()
            }catch let error as NSError {
                print("could not save . \(error), \(error.userInfo)")
            }

            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let app = dataApps[indexPath.row]

        let webVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebStoreViewController") as? WebStoreViewController
        webVC?.urlStr = app.url
        self.navigationController!.pushViewController(webVC!, animated: true)
        
    }
    @IBAction func changeDisplayBtnClicked(_ sender: Any) {
        
        isDisplayEmail = !isDisplayEmail
        self.mTableView.reloadData()
    }
    
    @IBAction func refreshBtnClicked(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Apps")
        
        let isSent = NSPredicate(format: "isSent == %@", NSNumber(value: false))

        let cond1 = NSPredicate(format: "updatedDate < %lf", 1579537093000.0)
        let cond2 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", "mail.ru")
        let cond3 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", "yandex")
        let cond4 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", "co.uk")
        let cond5 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", ".in")
        let cond6 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", ".sg")
        let cond7 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", ".hk")
        let cond8 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", ".fi")
        let cond9 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", ".nl")
        let cond10 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", ".pl")
        let cond11 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", ".br")
        let cond12 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", ".de")
        let cond13 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", ".co.kr")
        let cond14 = NSPredicate(format: "NOT (developerEmail CONTAINS[c] %@)", ".se")

        let add1 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "India")
        let add2 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Ukraine")
        let add3 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Israel")
        let add4 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Korea")
        let add5 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "INDIA")
        let add6 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Vietnam")
        let add7 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Viet Nam")
        let add8 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Turkey")
        let add9 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Russia")
        let add10 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "China")
        let add11 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Pakistan")
        let add12 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Bangladesh")
        let add13 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "市")
        let add14 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "mbh")
        let add15 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Philippines")
        let add16 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "mbh")
        let add17 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "mbh")
        let add18 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "mbh")
        let add19 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "도")
        let add20 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "大")
        let add21 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "区")
        let add22 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Hanoi")
        let add23 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Zoho")
        let add24 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Ha Noi")
        let add25 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Guangzhou")
        let add26 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Indonesia")
        let add27 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Beijing")
        let add28 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "BeiJing")
        let add29 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "surat")
        let add30 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "kiev")
        let add31 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "baku")
        let add32 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "HongKong")
        let add33 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "Hong Kong")
        let add34 = NSPredicate(format: "NOT (developerAddress CONTAINS[c] %@)", "delhi")
        let add35 = NSPredicate(format: "NOT (genreId CONTAINS[c] %@)", "Game")

        let orPredicate = NSCompoundPredicate(type: .and, subpredicates: [isSent,cond1,cond2,cond3,cond4,cond5,cond6,cond7,cond8,cond9,cond10,cond11,cond12,cond13,cond14,add1,add2,add3,add4,add5,add6,add7,add8,add9,add10,add11,add12,add13,add14,add15,add16,add17,add18,add19,add20,add21,add22,add23,add24,add25,add26,add27,add28,add29,add30,add31,add32,add33,add34,add35])
        fetchRequest.predicate = orPredicate
        dataApps = try! manageContent.fetch(fetchRequest) as! [Apps]
        
        self.title = String(dataApps.count)
        self.mTableView.reloadData()
        
    }
    
    @IBAction func sendEmailBtnClicked(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext

        if let mailComposeViewController = MailController.shared.mailComposeViewController() {

            mailComposeViewController.setToRecipients(["email@example.com"])
            mailComposeViewController.setSubject("Test")
            mailComposeViewController.setMessageBody("Hello world!", isHTML: false)

            present(mailComposeViewController, animated:true, completion:nil)
        } else {
            var emails = ""
            var counter = 0
            for app in dataApps {
                emails += app.developerEmail! + ","
                counter += 1
//                if counter % 5 == 0 {
//                    emails += "\n"
//                }
                app.isSent = true
                app.didSave()
                
                if counter == 5 {
                    UIPasteboard.general.string = emails
                    
                    do{
                        try manageContent.save()
                    }catch let error as NSError {
                        print("could not save . \(error), \(error.userInfo)")
                    }
                    counter = 0
                    
                    break;
                }
            }
            self.refreshBtnClicked(AnyClass.self)
        }
    }
}

