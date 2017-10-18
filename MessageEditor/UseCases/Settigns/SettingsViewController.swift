//
//  SettingsViewController.swift
//  MessageEditor
//
//  Created by Asif Sadrul on 10/14/17.
//  Copyright © 2017 Asif Sadrul. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UITextFieldDelegate {

  @IBOutlet weak var nameTextFld: UITextField!
  @IBOutlet weak var saveBtn: UIButton!
  @IBOutlet weak var editBtn: UIButton!
  override func viewDidLoad() {
      super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    let username = UserDefaults.standard.value(forKey: "username")
    if username != nil {
      nameTextFld.text = username as! String?
      handleUIStatusForUserNamePresnce()
    } else {
      handleUIStatusForUserNameAbsence()
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
    handleUIStatusAfterStoring()
  }
  
  @IBAction func editBtnAction(_ sender: Any) {
    nameTextFld.isUserInteractionEnabled = true
    nameTextFld.becomeFirstResponder()
  }
  
  func handleUIStatusAfterStoring() {
    self.editBtn.isUserInteractionEnabled = true
    self.saveBtn.isUserInteractionEnabled = false
    nameTextFld.isUserInteractionEnabled = false
    self.editBtn.backgroundColor = UIColor.init(colorLiteralRed: 108.0/255.0, green: 197.0/255.0, blue: 117.0/255.0, alpha: 1)
    self.saveBtn.backgroundColor = UIColor.init(colorLiteralRed: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 0.5)
  }
  
  func handleUIStatusForUserNamePresnce() {
    self.saveBtn.backgroundColor = UIColor.init(colorLiteralRed: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 0.5)
    self.editBtn.isUserInteractionEnabled = true
    self.saveBtn.isUserInteractionEnabled = false
    nameTextFld.isUserInteractionEnabled = false
  }
  
  func handleUIStatusForUserNameAbsence() {
    self.editBtn.backgroundColor = UIColor.init(colorLiteralRed: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 0.5)
    self.editBtn.isUserInteractionEnabled = false
    self.saveBtn.isUserInteractionEnabled = true
    nameTextFld.isUserInteractionEnabled =  true
  }
  
  func HandleUIStatusForBeginEditing() {
    self.saveBtn.isUserInteractionEnabled = true
    self.saveBtn.backgroundColor = UIColor.init(colorLiteralRed: 108.0/255.0, green: 197/255.0, blue: 117/255.0, alpha: 1)
    self.editBtn.isUserInteractionEnabled = false
    self.editBtn.backgroundColor = UIColor.init(colorLiteralRed: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 0.5)
  }
  
  //MARK:- Textfield delegate methods

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if (textField.text?.isEmpty)! {
      return false
    }
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    HandleUIStatusForBeginEditing()
  }

}
