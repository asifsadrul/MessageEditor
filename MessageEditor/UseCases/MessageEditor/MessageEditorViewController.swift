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
  

}
