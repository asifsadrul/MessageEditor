//
//  MessageEditorViewController.swift
//  MessageEditor
//
//  Created by Asif Sadrul on 10/14/17.
//  Copyright © 2017 Asif Sadrul. All rights reserved.
//

import UIKit

class MessageEditorViewController: UIViewController {

  @IBOutlet weak var placeholderLbl: UILabel!
  @IBOutlet weak var messageTextView: UITextView!
  let wordOfTheDay = "morning"
  var customBlueBand: UIButton!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      handleRightBarBtn()
      handleBlueBand()
  }
  
  func handleBlueBand() {
    self.customBlueBand = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
    self.customBlueBand.titleLabel?.textColor = UIColor.white
    self.customBlueBand.backgroundColor = UIColor.blue
    self.customBlueBand.setTitle(wordOfTheDay, for: UIControlState.normal)
    
    messageTextView.inputAccessoryView = self.customBlueBand
    messageTextView.inputAccessoryView?.isHidden = true
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
    //let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
    self.messageTextView.inputAccessoryView?.isHidden = false
    
    //customView .addSubview(customBTn)
    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
      //self.messageTextView.inputAccessoryView?.isHidden = true
      print("Called")
      self.messageTextView.inputAccessoryView?.isHidden = true
    }
    
  }
  
  
  func shakeScreen() {
    //self.view.shake()
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
      }
    }
    
    if(text == "\n") {
      textView.resignFirstResponder()
      return false
    }
    return true
  }
  
}
