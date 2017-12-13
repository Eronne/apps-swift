//
//  ViewController.swift
//  TextEditor
//
//  Created by LETUE Erwann on 12/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var loupeView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loupe = UIImageView.init(image: UIImage(named: "Loupe"))
        textField.leftView = loupe
        textField.leftViewMode = .always
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) {
            (notification) in
            if let info = notification.userInfo {
                let infoDict = info as! Dictionary<String, NSValue>
                if let value = infoDict[UIKeyboardFrameEndUserInfoKey] {
                    let keyboardFrame = value.cgRectValue
                    print("keyboard appearing at \(keyboardFrame)")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        textView.resignFirstResponder()
        doneButton.isHidden = true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        doneButton.isHidden = false
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text >= "0" && text <= "9" {
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // Ignore if field is empty
        if let searchString = textField.text {
            if searchString.count > 0 {
                if textView.text.count > 0 {
                    // Make NSString version to get a NSRange not a Swift Range
                    let searchFieldTextNS = textView.text as NSString
                    let range = searchFieldTextNS.range(of: searchString)
                    if (range.location != NSNotFound) {
                        textView.becomeFirstResponder()
                        textView.selectedRange = range
                    }
                }
            }
        }
        return false // Ignore return key in field
    }
}

