//
//  MOUITestsViewController.swift
//  MOSurveySwift
//
//  Created by MikiMo on 2021/3/20.
//

import UIKit

let gSubscribeButtonAccessibilityIdentifier = "MOUITestsViewController_subscribeButton"

class MOUITestsViewController: UIViewController {

    /// MOUITestsViewControllerUITests (相关)
    public var isCanTests: Bool = false
    var subscribeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .gray
        btn.setTitle("订阅", for: .normal)
        btn.setTitle("已订阅", for: .selected)
        btn.addTarget(self, action: #selector(clickSubscribeButton), for: .touchUpInside)
        btn.accessibilityIdentifier = gSubscribeButtonAccessibilityIdentifier
        return btn
    }()
    let num1: CGFloat = 1.0
    let num2: CGFloat = 2.0
    
    /// MOUITestDemo (相关)
    let textField: UITextField = {
        let field = UITextField(frame: .zero)
        field.backgroundColor = .cyan
        field.accessibilityLabel = "textField"
        return field
    }()
    let sendButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Send", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.accessibilityLabel = "sendButton"
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // MOUITestsViewControllerUITests (相关)
        view.addSubview(subscribeButton)
        
        // MOUITestDemo (相关)
        view.addSubview(textField)
        textField.frame = CGRect(x: 50, y: 200, width: 200, height: 50)
        
        sendButton.frame = CGRect(x: 260, y: 200, width: 60, height: 50)
        sendButton.addTarget(self, action: #selector(clickSend), for: .touchUpInside)
        view.addSubview(sendButton)

    }
    
    // MARK: - MOUITestsViewControllerUITests (相关)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.subscribeButton.frame = CGRect(x: 10.0, y: 100.0, width: 100.0, height: 50.0)
    }

    @objc func clickSubscribeButton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: - MOUITestDemo (相关)
    @objc func clickSend(sender: UIButton) {
        print("click send button");
    }
    

}
