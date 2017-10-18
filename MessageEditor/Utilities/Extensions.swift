//
//  ViewControllerExtension.swift
//  RSS News Reader
//
//  Created by Asif Sadrul on 7/16/17.
//  Copyright © 2017 Asif Sadrul. All rights reserved.
//

import UIKit

public extension UIViewController {
  
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title,
                                            message: message, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                            style: UIAlertActionStyle.default, handler: nil))
    self.present(alertController, animated: true, completion: nil)
  }
  
  func showErrorAlert(error: NSError) {
    let title = error.localizedDescription
    showAlert(title: title, message: error.localizedFailureReason ?? "")
  }
  
  func displayToast(alertMsg : String){
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-40, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.gray
    toastLabel.textColor = UIColor.white
    toastLabel.font = UIFont(name: toastLabel.font.fontName, size: 12)
    toastLabel.textAlignment = NSTextAlignment.center;
    self.view.addSubview(toastLabel)
    
    toastLabel.text = alertMsg
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
      
      toastLabel.alpha = 0.0
      
    }, completion: nil)
  }
  
  func setTitle(title: String) {
    self.title = title
  }
}

public extension UIView {
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.duration = 0.6
    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
    layer.add(animation, forKey: "shake")
  }
}

