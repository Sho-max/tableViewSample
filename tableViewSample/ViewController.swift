import UIKit
import Firebase

class ViewController: UIViewController {
    
    //    tableview定義
    @IBOutlet var sampleTableView: UITableView!
    
    //    indexpathを取得するための変数定義
    var passedIndexPath: Int!
    
    //    tableViewに表示する内容を配列に格納
    var testArray = [testDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleTableView.delegate = self
        sampleTableView.dataSource = self
        //        カスタムセルの登録
        let nib = UINib(nibName: "sampleTableViewCell", bundle: Bundle.main)
        sampleTableView.register(nib, forCellReuseIdentifier: "cell")
        //        不要な線を消す
        sampleTableView.tableFooterView = UIView()
        //        セルの高さを指定
        sampleTableView.rowHeight = 100
        
        observeInfoFromFirebase()
    }
    
    private func observeInfoFromFirebase(){
        let ref = Database.database().reference()
        ref.child("testComment").observe(.value) { (snapshot) in
            //            配列を初期化
            self.testArray = []
            for data in snapshot.children{
                let snapData = data as! DataSnapshot
                let dicData = snapData.value as! [String:Any]
                
                let testData = testDataModel(dic: dicData)
                    self.testArray.append(testData)
            }
            self.sampleTableView.reloadData()
        }
        
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! sampleTableViewCell
        let testPost = testArray[indexPath.row]
        //        cellの内容
        let testText = cell.viewWithTag(1) as! UILabel
        testText.text = testPost.testText
        
        let commentText = cell.viewWithTag(2) as! UILabel
        commentText.text = testPost.commentText
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        追加したコード。didselectRowAtが起動した時（cellが押された時）に、上で定義した変数にindexPathを格納する。
        passedIndexPath = Int(indexPath.row)
        //        セルを選択した後に選択状態を解除する
        sampleTableView.deselectRow(at: indexPath as IndexPath, animated: true)
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        segueが成功した時に起動
        if segue.identifier == "toDetail"{
            let DestinationVC = segue.destination as! destinationViewController
            //        遷移後画面の変数のrecievedIndexPathにこの画面で格納したpassedIndexPathを値渡しする
            DestinationVC.recievedIndexPath = passedIndexPath
        }
    }
}
