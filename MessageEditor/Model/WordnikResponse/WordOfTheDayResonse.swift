//
//  WordResonse.swift
//  MessageEditor
//
//  Created by Asif Sadrul on 10/18/17.
//  Copyright © 2017 Asif Sadrul. All rights reserved.
//

import Foundation
import ObjectMapper

class WordOfTheDayResonse: Mappable{
  var wordOfTheDay: String?
  var definitionArray: [DefinitionArray]?
  var id: Int?
  var publishDate: String?
  var note: String?
  var contentProviderName: String?
  var contentProviderID: Int?
  
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    wordOfTheDay <- map["word"]
    definitionArray <- map["definitions"]
    id <- map["id"]
    publishDate <- map["publishDate"]
    note <- map["note"]
    contentProviderName <- map["contentProvider.name"]
    contentProviderID <- map["contentProvider.id"]
  }
}
