import UIKit
import Firebase

class createDestinationPageViewController: UIViewController {
    
    @IBOutlet var testTextField: UITextField!
    @IBOutlet var commentTextField: UITextField!
    
    var recievedIndexPath: Int!
    
    @IBOutlet var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(recievedIndexPath)
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        setFirebase()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setFirebase(){
        let ref = Database.database().reference()
        let postModel:[String:Any] = [
            "text": testTextField.text,
            "comment": commentTextField.text,
            // 追加した事項。投稿内容と同時にRealtime Databaseに保存する。
            "passedIndexPath": recievedIndexPath
        ]
        ref.child("sampleComment").childByAutoId().setValue(postModel)
    }
}

extension createDestinationPageViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

