import Foundation
import UIKit

class destinationTestDataModel{
    //    cellに包含する内容の定義
    var testText: String
    var commentText: String
    
    //    追加した変数：取得したindexPathを格納する
    var passedIndexPath: Int
    
    //    testDataModelを初期化
    init(dic:[String:Any]) {
        self.testText = dic["text"] as! String
        self.commentText = dic["comment"] as! String
        //        追加した変数を初期化する
        self.passedIndexPath = dic["passedIndexPath"] as! Int
    }
    
}

