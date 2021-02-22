import Foundation
import UIKit

class testDataModel{
    //    cellに包含する内容の定義
    var testText: String
    var commentText: String
    
    //    testDataModelを初期化
    init(dic:[String:Any]) {
        self.testText = dic["text"] as! String
        self.commentText = dic["comment"] as! String
    }
    
}
