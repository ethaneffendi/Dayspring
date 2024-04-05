import SwiftUI
import UserNotifications
import UserNotificationsUI

class AppStatus: ObservableObject{
    @Published var openOutdoor: Bool
    @Published var openSick: Bool
    @Published var openApple: Bool
    init(openOutdoor: Bool, openSick: Bool, openApple: Bool){
        self.openOutdoor = openOutdoor
        self.openSick = openSick
        self.openApple = openApple
    }
}

class NotificationManager{
    static var needNotification = true
    static func noNotification(noNotificationTime: Int){
        needNotification = false
        Timer.scheduledTimer(withTimeInterval: TimeInterval(noNotificationTime), repeats: false){timer in
            needNotification = true
        }
    }
}

@main
struct MyApp: App {
    @ObservedObject var appStatus = AppStatus(openOutdoor: false, openSick: false, openApple: false)
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup{
            if appStatus.openApple {
                AdventureLoop().environmentObject(appStatus)
            } else if appStatus.openSick{
                SickDay().environmentObject(appStatus)
            }else{
                Homebase().environmentObject(appStatus)
            }
        }.onChange(of: scenePhase){phase in
            if phase == .background{
                Timer.scheduledTimer(withTimeInterval: 5, repeats: true){timer in
                    let content = UNMutableNotificationContent()
                    content.sound = UNNotificationSound.default
                    content.title = "Remember your commitment to wellness!"
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request)
                    if NotificationManager.needNotification == false{
                        timer.invalidate()
                    }
                }
                
                print("background")
            } else if phase == .active{
                print("foreground")
            }
        }
        
        
        
        
    }
}
