//
//  FoundItemModel.swift
//  
//
//  Created by Lauren Traum on 4/20/18.
//

import Foundation
class FoundItemModel{
    var dateFound: String?
    var description: String?
    var location: String?
    var id: String?
    
    init(id:String?, dateFound: String?, description: String?, location: String?){
        self.id = id
        self.dateFound = dateFound
        self.description = description
        self.location = location
    }
    
}





