//
//  StorageController.swift
//  sharetest
//
//  Created by vampire on 3/20/20.
//  Copyright © 2020 B. All rights reserved.
//

import Foundation
import SwiftyJSON

class StorageController {
    
    static let shared = StorageController()
    
    private init() {
        
    }
    
    func loadJSON(withFilename filename: String) throws -> Any? {

        let filepath : String  = Bundle.main.resourcePath! + "/JSONS/" + filename
        let fileUrl = URL(fileURLWithPath: filepath)

        let data = try Data(contentsOf: fileUrl)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
        return jsonObject
    }

}
