//
//  Article.swift
//  MVPTEST
//
//  Created by Eang Pheara on 12/22/16.
//  Copyright © 2016 Eang Pheara. All rights reserved.
//

import Foundation
import SwiftyJSON
class Article{
    var id: Int?
    var title: String?
    var description: String?
    var imageUrl : String?
    init() {
        self.id = 0
        self.title = ""
        self.description = ""
        self.imageUrl = ""
    }
    
    init(article: JSON){
        self.id = article["ID"].int
        self.title = article["TITLE"].string
        self.description = article["DESCRIPTION"].string
        self.imageUrl = article["IMAGE"].string
    }
    
    func convertToObjecct() -> [String: Any] {
        let data = ["TITLE": self.title!,
                    "DESCRIPTION": self.description!,
                    "AUTHOR": 1,
                    "CATEGORY_ID": 1,
                    "SATUS": "1",
                    "IMAGE": self.imageUrl!
        ] as [String : Any]
        return data
    }
}
