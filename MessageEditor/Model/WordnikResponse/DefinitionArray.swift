//
//  DefinitionArray.swift
//  MessageEditor
//
//  Created by Asif Sadrul on 10/18/17.
//  Copyright © 2017 Asif Sadrul. All rights reserved.
//

import Foundation
import ObjectMapper

class DefinitionArray: Mappable{
  
  var definitionText: String?
  var partsOfSpeech: String?
  var source: String?
  
  required init?(map: Map){
    
  }
  
  func mapping(map: Map) {
    definitionText <- map["text"]
    partsOfSpeech <- map["partOfSpeech"]
    source <- map["source"]
  }
}

