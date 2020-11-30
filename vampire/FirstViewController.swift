//
//  FirstViewController.swift
//  vampire
//
//  Created by Matthew James on 3/22/20.
//  Copyright © 2020 Matthew James. All rights reserved.
//

import UIKit
import CoreData
import SCLAlertView
import JGProgressHUD

class FirstViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let cellReuseIdentifier = "cell"
    var jsonfiles: Array<String> = []
    var dataFiles : Array<Files> = []

    @IBAction func validateBtnClicked(_ sender: Any) {
        
        let title = "Validate your keyword"
        let message = "Please validate your keyword to avoid duplicate resource"
        let appearance = SCLAlertView.SCLAppearance(
           showCloseButton: false,
           hideWhenBackgroundViewIsTapped: true
        )

        let alert = SCLAlertView(appearance: appearance)
        let keyword = alert.addTextField("Keyword")

        alert.addButton("Validate") {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
            let cond = NSPredicate(format: "fileName CONTAINS[c] %@", keyword.text!)
            fetchRequest.predicate = cond
            let jFiles = try! manageContent.fetch(fetchRequest) as! [Files]
            
            if(jFiles.count > 0) {
                
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false,
                    hideWhenBackgroundViewIsTapped: true
                )
                let alertSubView = SCLAlertView(appearance: appearance)
                alertSubView.showWarning("Sorry", subTitle: "Already exist")
                
            } else {
                
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false,
                    hideWhenBackgroundViewIsTapped: true
                )
                let alertSubView = SCLAlertView(appearance: appearance)
                alertSubView.showSuccess("Great!", subTitle: "New keyword")

            }

        }
        alert.showNotice(title, subTitle: message)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: cellReuseIdentifier)
        
        let file:Files = dataFiles[indexPath.row];
        if file.isLoad {
            cell.textLabel?.text = "Loaded"

        } else {
            cell.textLabel?.text = ""

        }

        cell.detailTextLabel?.text = file.fileName
        cell.detailTextLabel?.font = UIFont(name:"Arial", size:22)

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let file:Files = dataFiles[indexPath.row];
        let filename : String = file.fileName!
        
        do {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
            let predicate = NSPredicate(format: "fileName LIKE[cd] %@",filename)
            fetchRequest.predicate = predicate
            
            var files = [Files]()
            files = try! manageContent.fetch(fetchRequest) as! [Files]
            if(files.count == 1) {
                let file:Files = files[0];
                if(!file.isLoad) {
                    let appsArray = [try StorageController.shared.loadJSON(withFilename: filename)!]
                    
                    if let appsRealArray = appsArray.first as? [[String:Any]] {
                        for appDict in appsRealArray {
                            let developerEmail = appDict["developerEmail"] as? String
                            let fetchRequestSub = NSFetchRequest<NSFetchRequestResult>(entityName: "Apps")
                            fetchRequestSub.predicate = NSPredicate(format: "developerEmail = %@", developerEmail!)
                            var subApps = [Apps]()
                            subApps = try! manageContent.fetch(fetchRequestSub) as! [Apps]
                            if(subApps.count == 0) {
                                //Not Exist
                                let userEntity = NSEntityDescription.entity(forEntityName: "Apps", in: manageContent)!
                                let app: Apps = NSManagedObject(entity: userEntity, insertInto: manageContent) as! Apps
                                app.developer = appDict["developer"] as? String
                                app.developerAddress = appDict["developerAddress"] as? String
                                app.developerEmail = appDict["developerEmail"] as? String
                                app.developerWebsite = appDict["developerWebsite"] as? String
                                app.summary = appDict["summary"] as? String
                                app.genreId = appDict["genreId"] as? String
                                app.icon = appDict["icon"] as? String
                                app.recentChanges = appDict["recentChanges"] as? String
                                app.version = appDict["version"] as? String
                                app.url = appDict["url"] as? String
                                app.title = appDict["title"] as? String
                                app.keyword = file.fileName
                                
                                app.isSent = false
                                app.released = appDict["released"] as? Date
                                app.score = appDict["score"] as? Float ?? 0
                                app.updatedDate = appDict["updated"] as? Double ?? 0
                                app.files = file
                                app.didSave()
                            } else {
                                //Exist
                                print("exist developer already")
                            }
                        }
                        file.isLoad = true
                        file.loadDate = Date()
                        do{
                            try manageContent.save()
                        }catch let error as NSError {
                            print("could not save . \(error), \(error.userInfo)")
                        }
                    }
                    self.mTableView.reloadData()

                }
            }

        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    
    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let docsPath = Bundle.main.resourcePath! + "/JSONS"
        let fileManager = FileManager.default

        do {
            jsonfiles = try fileManager.contentsOfDirectory(atPath: docsPath)
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            
            for filename in jsonfiles {
                var files = [Files]()
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
                let predicate = NSPredicate(format: "fileName LIKE[cd] %@",filename)
                fetchRequest.predicate = predicate

                files = try! manageContent.fetch(fetchRequest) as! [Files]
                if(files.count == 0) {
                
                    let userEntity = NSEntityDescription.entity(forEntityName: "Files", in: manageContent)!
                    let file: Files = NSManagedObject(entity: userEntity, insertInto: manageContent) as! Files
                    file.fileName = filename;
                    file.isLoad = false
                    file.loadDate = Date()
                    file.didSave()
                }
                
            }
            do{
                try manageContent.save()
            }catch let error as NSError {
                print("could not save . \(error), \(error.userInfo)")
            }
            let allfetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Files")
            dataFiles = try! manageContent.fetch(allfetchRequest) as! [Files]
            self.title = String(dataFiles.count)
        } catch {
            print(error)
        }        // Do any additional setup after loading the view.
        
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

    }
    
}

