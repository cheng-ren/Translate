//
//  ViewController.swift
//  Translate
//
//  Created by 任成 on 2019/10/18.
//  Copyright © 2019 rencheng Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fromTextView: UITextView!
    @IBOutlet weak var toTextView: UITextView!
    
    var mode: TranslateMode = .AUTO;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.fromTextView.superview?.layer.cornerRadius = 5.0
        self.toTextView.superview?.layer.cornerRadius = 5.0
        self.fromTextView.superview?.layer.masksToBounds = true
        self.toTextView.superview?.layer.masksToBounds = true
        
        self.fromTextView.textContainerInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        self.toTextView.textContainerInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        
        self.toTextView.isEditable = false
        self.fromTextView.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.fromTextView.becomeFirstResponder()
        }
    }

    private func doTranslateAction(_ str: String) {
        Network.requestByYoudao(str: self.fromTextView.text, mode: mode) { (response) in
            if let res = response {
                let arr = res["translateResult"] as? Array<Any>
                let arr1 = arr?.first as? Array<Dictionary<String, String>>
                let dict = arr1?.first
                let result = dict?["tgt"]
                self.toTextView.text = result
            } else {
                self.toTextView.text = "无法翻译, 请重试"
            }
        }
    }
    
    
    @IBAction func translateModeChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                mode = .C2E
            case 2:
                mode = .E2C
            default:
                mode = .AUTO
        }
        doTranslateAction(self.fromTextView.text)
    }
    
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            doTranslateAction(textView.text)
        }
        else {
            self.toTextView.text = ""
        }
    }
}
