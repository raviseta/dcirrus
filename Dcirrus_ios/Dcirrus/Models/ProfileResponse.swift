import Foundation
import UIKit
import ObjectMapper

// MARK: - Welcome
class ProfileDataResponse: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.tempObject4 <- map["tempObject4"]
        self.tempObject1 <- map["tempObject1"]
        self.messageCode <- map["messageCode"]
        self.action <- map["action"]
        self.object <- map["object"]
        self.tempObject5 <- map["tempObject5"]
        self.tempObject2 <- map["tempObject2"]
        self.message <- map["message"]
        self.error <- map["error"]
        self.tempObject3 <- map["tempObject3"]
    }
    var tempObject4: String?
    var tempObject1: ObjectLocal?
    var messageCode: Int?
    var action: String?
    var object: ObjectLocal?
    var tempObject5, tempObject2, message: String?
    var error: Bool?
    var tempObject3: String?

    init(tempObject4: String?, tempObject1: ObjectLocal?, messageCode: Int?, action: String?, object: ObjectLocal?, tempObject5: String?, tempObject2: String?, message: String?, error: Bool?, tempObject3: String?) {
        self.tempObject4 = tempObject4
        self.tempObject1 = tempObject1
        self.messageCode = messageCode
        self.action = action
        self.object = object
        self.tempObject5 = tempObject5
        self.tempObject2 = tempObject2
        self.message = message
        self.error = error
        self.tempObject3 = tempObject3
    }
}
