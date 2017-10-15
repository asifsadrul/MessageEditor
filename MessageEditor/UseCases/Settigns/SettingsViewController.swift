//
//  SettingsViewController.swift
//  MessageEditor
//
//  Created by Asif Sadrul on 10/14/17.
//  Copyright © 2017 Asif Sadrul. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  @IBOutlet weak var nameTextFld: UITextField!
  @IBOutlet weak var saveBtn: UIButton!
  @IBOutlet weak var editBtn: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    let username = UserDefaults.standard.value(forKey: "username")
    if username != nil {
      nameTextField.text = username as! String?
      self.saveBtn.backgroundColor = UIColor.init(colorLiteralRed: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 0.5)
      self.editBtn.isUserInteractionEnabled = true
      self.saveBtn.isUserInteractionEnabled = false
      nameTextField.isUserInteractionEnabled = false
    } else {
      self.editBtn.backgroundColor = UIColor.init(colorLiteralRed: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 0.5)
      self.editBtn.isUserInteractionEnabled = false
      self.saveBtn.isUserInteractionEnabled = true
      nameTextField.isUserInteractionEnabled =  true
      
    }
  }
  
  @IBAction func saveBtnAction(_ sender: Any) {
    if (nameTextFld.text?.isEmpty)! {
      return
    }
    let username = nameTextFld.text
    UserDefaults.standard.set(username, forKey: "username")
    nameTextFld.resignFirstResponder()
    self.displayToast(alertMsg: AlertMessages.user_store_successful)
    handleStatusAfterStoring()
  }
  
  func handleStatusAfterStoring() {
    self.editBtn.isUserInteractionEnabled = true
    self.saveBtn.isUserInteractionEnabled = false
    nameTextFld.isUserInteractionEnabled = false
    self.editBtn.backgroundColor = UIColor.init(colorLiteralRed: 74.0/255.0, green: 171.0/255.0, blue: 247.0/255.0, alpha: 1)
    self.saveBtn.backgroundColor = UIColor.init(colorLiteralRed: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 0.5)
  }
  
  @IBAction func editBtnAction(_ sender: Any) {
    nameTextFld.isUserInteractionEnabled = true
    nameTextFld.becomeFirstResponder()
  }
}
