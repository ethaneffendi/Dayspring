import Foundation
import SwiftUI
import UIKit

class ChallengeManager{
    static var parkChallenges = ["logo", "leaf", "keyboard", "stage"]
    static var sickChallenges = ["apple", "banana", "thermometer", "leaf"]
    static var currentChallenge = 0
    static var itemFound = false
    static var wwHeaders = ["☘ Leaf",  " Apple Logo", "★ Magic Keyboard", "🎤 Rainbow Stage"]
    static var wwInstructions = ["Apple's going carbon neutral by 2030. Place a leaf in the camera frame above to celebrate.", "Place any Apple logo in the camera frame above.", "Dream it. Chase it. Code it. Place a magic keyboard in the camera frame above.", "It's showtime. Place the rainbow stage at Apple Park within the camera frame above."]
    static var sickHeaders = ["An Apple", "A Banana", "Oral Thermometer", "A Leaf"]
    static var sickInstructions = ["An apple a day keeps the doctor away. Place a red, juicy apple in the camera frame above.", "It's time for some potassium! Place a banana within the camera frame above.", "Make sure to take your temperature! Place an oral thermometer within the camera frame above.", "Get ready to return outdoors! Nature brings great healing! Place a leaf within the camera frame above."]
//    static var modelList = [Models.VNleavesModel, Models.VNkeyboardModel, Models.VNlogoModel, Models.VNstageModel, Models.VNappleModel, Models.VNbananaModel, Models.VNthermometerModel, Models.VNleavesModel]
    static var modelList = [Models.leavesModel, Models.logoModel, Models.keyboardModel, Models.stageModel, Models.appleModel, Models.bananaModel, Models.thermometerModel, Models.leavesModel]
}
