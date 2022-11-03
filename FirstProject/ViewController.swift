//
//  ViewController.swift
//  FirstProject
//
//  Created by 동희 on 2022/10/27.
//

import UIKit

class ViewController: UIViewController {
     
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        //텍스트필드를 self 가관리하겠다
        /// self가 자신이라는 의미이니 Viewcontroller를 가리킴
        /// textFieldShouldReturn, textFieldDidBeginEditing 을 사용하기 위해 반드시 추가해야한다.
        messageTextField.delegate = self
        /// textField가 변경될때마다 반응할수 있게 만드는 명령어
        /// self가 target , target이란 이벤트를 받을 대상
        /// action이란 어떤 행동을 할지 정의
        /// for:에서 어떤 이벤트를 관찰할지 정의
        messageTextField.addTarget(self, action: #selector(textEditing), for: .editingChanged)
        
        
        ///NotificationCenter : 앱의 전체 상태를 읽어오는 객체
        ///1. 관측자를 등록
        ///2. 어떤 event를 관측하는지 , 미리정의된 name으로 명시해줌
        ///3. 이벤트 관측이 발생하면 개발자가 정의한 함수로 이동
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    @IBOutlet weak var label: UILabel!
    
    // 뷰의 크기나 색, 뷰를 코드로 만들때 꼭 viewDidAppear, 그냥 뷰컨트롤러 하나 만들면 무조건 만든다고 외운다
    /// 뷰의 크기나 위치를 설정
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// label 모서리를 둥굴게한다
        /// 1. clipsToBounds를 적용하여 cornerRadiuos 을 설정할 수 있게 해준다.
        /// 2. cornerRadius를 설정하여 둥근정도를 정해준다.
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
    }
}

// 코드가 지저분 해지는것을 방지하기 위해 Viewcontroller를 확장했다, textField를 관리하기 위해 UITextFieldDelegate 채택했다
extension ViewController: UITextFieldDelegate {
    /// 리턴 키를 누르면 이 함수로 온다
    /// UITextFieldDelegate 에 정의되어 있는 함수
    /// -> 는 출력의 의미 , 해당 데이터를 뱉어낸다!!!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        /// 엔터를 누르면 label의 글자를 textField의 글자로 변경
        label.text = textField.text
        ///키보드를 내려가게하는 명령어
        textField.resignFirstResponder()
        
        /// text입력이 끝나면 isHidden을 off해서 label을 보여준다
        label.isHidden = false
        return true
    }
 
    
    /// textfield를 변경하기 시작하면 들어오는곳
    /// UITextFieldDelegate 에 정의되어 있는 함수
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /// text입력이 시작하면 isHidden을 on해서 label을 없애준다.
        label.isHidden = true
    }
    
    
    //텍스트필드가 변경될때 여기서 반응을 해준다
    /// ViewDidLoad의 messegeTextField.addTarget을 통해서 연결해준 함수
    @objc
    func textEditing() {
        /// textfield가 변경될때마다 label의 글자도 변경해준다
        label.text = messageTextField.text
    }
    
    //UIKeyboardFrameEndUserInfoKey
    ///4. 해당함수로 이동후 명령문 실행
    /// 키보드가 보이면 실행되는 함수
    @objc
    func keyboardWillShow(notification: NSNotification) {
        /// (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue 의 값이 존재하면
        /// keyboardSize에 위의 값을 대입한다
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            ///keyboardSize 값이 존재하면 들어와서 실행이되고 , constant를 변경해줌으로써 textfield의 위치를 변경해줌
            bottomViewBottomConstraint.constant = keyboardSize.height
        }
    }
    
    ///키보드가 사라질때 호출되는 함수
    @objc
    func keyboardWillHide(notification: NSNotification) {
        /// 키보드를 다시 원래자리로 되돌아가게함 , constraint를 변경해 줌으로써
        bottomViewBottomConstraint.constant = 0
    }
}

