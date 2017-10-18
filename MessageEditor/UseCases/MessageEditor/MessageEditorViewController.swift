//
//  MessageEditorViewController.swift
//  MessageEditor
//
//  Created by Asif Sadrul on 10/14/17.
//  Copyright © 2017 Asif Sadrul. All rights reserved.
//

import UIKit
import AWSSNS
import AWSCore
import AWSCognito
import Alamofire
import AlamofireObjectMapper

class MessageEditorViewController: UIViewController, UITextViewDelegate {

  @IBOutlet weak var placeholderLbl: UILabel!
  @IBOutlet weak var messageTextView: UITextView!
  var wordOfTheDay = String()
 // var definitionArray: [DefinitionArray]?
  var customBlueBand: UIButton!
//  var wordID: String?
//  var publishDate: String?
//  var note: String?
//  var contentProviderID: Int?
//  var contentProvidername: String?
//  var definitionSource: String?
//  var definitionString: String?
//  var name: String?
  var response: WordOfTheDayResonse?
  
  override func viewDidLoad() {
      super.viewDidLoad()
      handleRightBarBtn()
      handleBlueBand()
      getWordOfTheDay()
  }
  
  func getWordOfTheDay(){
    Alamofire.request(APIUrls.server_base_url + Constants.api_key, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
      .responseObject { (response: DataResponse<WordOfTheDayResonse>) in
        
        switch response.result {
        case .success:
          
          guard let wordResponse = response.result.value else {
            return
          }
          self.response = wordResponse
          
          if let word = self.response?.wordOfTheDay{
            self.wordOfTheDay = word
          }
          
        case .failure(let error):
          self.showErrorAlert(error: error as NSError)
        }
    }
  }
  
  func publishPost() {
    let sns = AWSSNS.default  ()
    let request = AWSSNSPublishInput()
    request?.messageStructure = "json"
    
    var id = Int()
    var message = String()
    var publishDate = String()
    var note = String()
    var contentProviderName = String()
    var contentProviderID = Int()
    var definitionText = String()
    var definitionSource = String()
    var definitionPartsOfSpeech = String()

    let username = UserDefaults.standard.value(forKey: "username") as! String
    if let msg = messageTextView.text {
      message = msg
    }
    if let wordID = response?.id{
      id = wordID
    }
    if let publishDT = response?.publishDate{
      publishDate = publishDT
    }
    if let noteText = response?.note{
      note = noteText
    }
    if let providerName = response?.contentProviderName{
      contentProviderName = providerName
    }
    if let providerID = response?.contentProviderID{
      contentProviderID = providerID
    }
    if let defText = response?.definitionArray?[0].definitionText{
      definitionText = defText
    }
    if let defSource = response?.definitionArray?[0].source{
      definitionSource = defSource
    }
    if let partsOfSpeeceh = response?.definitionArray?[0].partsOfSpeech{
      definitionPartsOfSpeech = partsOfSpeeceh
    }
    
    let data = "{ \"name\": \"\(username)\", \"message\": \"\(message)\",\"word\": {\"id\": \(id), \"word\": \"\(wordOfTheDay)\", \"publishDate\": \"\(publishDate)\", \"note\": \"\(note)\",\"contentProvider\": { \"name\": \"\(contentProviderName)\", \"id\": \(contentProviderID)}, \"definitions\": [{ \"text\": \"\(definitionText)\",\"source\": \"\(definitionSource)\",\"partOfSpeech\": \"\(definitionPartsOfSpeech)\"}]}}"

    let dict = ["default": "The default message", "APNS_SANDBOX": data]
    
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dict)
      request?.message = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as? String
      request?.targetArn = "arn:aws:sns:us-west-2:327210751071:statup-challenge-push"
      sns.publish(request!).continue({ (task) -> AnyObject! in
        print("error here  \(task.error), result:; \(task.result)")
        return nil
      })
    }catch {
      print("In catch block")
    }

  }

  func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
      do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
      } catch {
        print(error.localizedDescription)
      }
    }
    return nil
  }
  
  func handleBlueBand() {
    self.customBlueBand = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
    self.customBlueBand.titleLabel?.textColor = UIColor.white
    self.customBlueBand.backgroundColor = UIColor.blue
    self.customBlueBand.setTitle(wordOfTheDay, for: UIControlState.normal)
    self.customBlueBand.addTarget(self, action:#selector(handleBlueBandAction), for: .touchUpInside)

    messageTextView.inputAccessoryView = self.customBlueBand
    messageTextView.inputAccessoryView?.isHidden = true
  }
  
  func handleBlueBandAction() {
    if let defText = response?.definitionArray?[0].definitionText {
      self.showAlert(title: "Definition", message: defText)
    }
  }
  
  func handleRightBarBtn() {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    button.setImage(UIImage(named: "settings"), for: UIControlState.normal)
    button.addTarget(self, action:#selector(goToSettings), for: .touchUpInside)
    let barButton = UIBarButtonItem(customView: button)
    self.navigationItem.rightBarButtonItem = barButton
  }
  
  func goToSettings() {
    self.performSegue(withIdentifier: "settings", sender: self)
  }
  
  func displayBlueBand() {
    self.messageTextView.inputAccessoryView?.isHidden = false
    customBlueBand.setTitle(wordOfTheDay,for: .normal)

    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      self.messageTextView.inputAccessoryView?.isHidden = true
    }
  }
  
  func shakeScreen() {
    self.view.shake()
  }

  
  //MARK:- Textview delegate methods

  func textViewDidBeginEditing(_ textView: UITextView) {
    placeholderLbl.isHidden = true
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    placeholderLbl.isHidden = (textView.text.characters.count > 0)
  }
  
  func textViewDidChange(_ textView: UITextView) {
    placeholderLbl.isHidden = (textView.text.characters.count > 0)
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
    if text == " " {
      if textView.text.lowercased().range(of:wordOfTheDay.lowercased()) != nil {
        displayBlueBand()
        shakeScreen()
        publishPost()
      }
    }
    
    if(text == "\n") {
      textView.resignFirstResponder()
      return false
    }
    return true
  }
}
