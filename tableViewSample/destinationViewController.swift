import UIKit
import Firebase

class destinationViewController: UIViewController {
    
    
    @IBOutlet var destinationTableView: UITableView!
    
    //    遷移前の画面から渡されたindexPath
    var recievedIndexPath: Int!
    
    var sampleArray = [destinationTestDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        カスタムセルの登録
        let nib = UINib(nibName: "sampleTableViewCell", bundle: Bundle.main)
        destinationTableView.dataSource = self
        destinationTableView.delegate = self
        destinationTableView.register(nib, forCellReuseIdentifier: "cell")
        //        不要な線を消す
        destinationTableView.tableFooterView = UIView()
        //        セルの高さを指定
        destinationTableView.rowHeight = 100
        observeInfoFromFirebase()
        
    }
    
    private func observeInfoFromFirebase(){
        let ref = Database.database().reference()
        ref.child("sampleComment").observe(.value) { (snapshot) in
            //            配列を初期化
            self.sampleArray = []
            for data in snapshot.children{
                let snapData = data as! DataSnapshot
                let dicData = snapData.value as! [String:Any]
                
                let testData = destinationTestDataModel(dic: dicData)
                if testData.passedIndexPath == self.recievedIndexPath{
                    self.sampleArray.append(testData)
                }
            }
            self.destinationTableView.reloadData()
        }
    }
}

extension destinationViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! sampleTableViewCell
        let samplePost = sampleArray[indexPath.row]
        //        cellの内容
        let testText = cell.viewWithTag(1) as! UILabel
        testText.text = samplePost.testText
        
        let commentText = cell.viewWithTag(2) as! UILabel
        commentText.text = samplePost.commentText
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreatePage"{
            let createDestinationPageVC = segue.destination as! createDestinationPageViewController
            createDestinationPageVC.recievedIndexPath = recievedIndexPath
        }
    }
    
    
}
