import UIKit
import Firebase

class createPageViewController: UIViewController {
    
    @IBOutlet var testTextField: UITextField!
    @IBOutlet var commentTextField: UITextField!
    
    //    追加した変数
    var passedIndexPath: Int!
    
    @IBOutlet var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(passedIndexPath)
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        setFirebase()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setFirebase(){
        let ref = Database.database().reference()
        let postModel:[String:Any] = [
            "text": testTextField.text,
            "comment": commentTextField.text
        ]
        ref.child("testComment").childByAutoId().setValue(postModel)
    }
}

extension createPageViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
