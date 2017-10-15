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
  var customBarBTn: UIButton!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      handleRightBarBtn()
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
