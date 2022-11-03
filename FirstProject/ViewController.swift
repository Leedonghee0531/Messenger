//
//  ViewController.swift
//  FirstProject
//
//  Created by 동희 on 2022/10/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //텍스트필드를 self 가관리하겠다
        messageTextField.delegate = self
        // textField가 변경될때마다 반응할수 있게 만드는 명령어
        messageTextField.addTarget(self, action: #selector(textEditing), for: .editingChanged)
    }
    @IBOutlet weak var label: UILabel!
    
    // 뷰의 크기나 색, 뷰를 코드로 만들때 꼭 viewDidAppear, 그냥 뷰컨트롤러 하나 만들면 무조건 만든다고 외운다
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

// 코드가 지저분 해지는것을 방지하기 위해 Viewcontroller를 확장했다, lee를 관리하기 위해 UITextFieldDelegate 채택했다
extension ViewController: UITextFieldDelegate {
    
    // 리턴 키를 누르면 이 함수로 온다
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //키보드를 내려가게하는 명령어
        label.text = textField.text
        textField.resignFirstResponder()
        return true
    }
    
  
    //텍스트필드가 변경될때 여기서 반응을 해준다
    @objc
    func textEditing() {
        label.text = messageTextField.text
    }
}

