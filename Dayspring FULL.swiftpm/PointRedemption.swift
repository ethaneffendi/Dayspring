import SwiftUI
import Foundation

struct PointRedemption: View{
    @State var screenHeight = UIScreen.main.bounds.height + 30
    @State var screenWidth = UIScreen.main.bounds.width
    var body: some View{
        VStack{
            
            HStack{
                var pointCount = UserData().loadPointCount()
                Text(String(pointCount)).foregroundStyle(Color.init("SonomaGreenDark")).font(.system(size: 80, design: .rounded))
                Text("points").foregroundStyle(Color.init("SonomaGreenDark")).font(.system(size: 50, design: .rounded))
            }.frame(width: screenWidth-20-(screenWidth/5), height: screenHeight/6).background{Color.white.opacity(0.3)}.cornerRadius(30)
            
            VStack{
                Text("In redeeming your points, you receive time to exit this application without any disturbance.").foregroundStyle(Color.init("SonomaGreenLight")).font(.system(.body, design: .rounded)).bold().multilineTextAlignment(.center)
                Spacer().frame(height: screenHeight/30)
                HStack{
                    Text("1").font(.system(.title, design: .rounded)).foregroundColor(Color.init("SonomaGreenLight"))
                    Image.init(systemName: "medal.fill").font(.system(.title, design: .rounded)).foregroundColor(Color.init("SonomaGreenLight"))
                    Text("=").font(.system(.title, design: .rounded)).foregroundColor(Color.init("SonomaGreenLight"))
                    Text("1 minute").font(.system(.title, design: .rounded)).foregroundColor(Color.init("SonomaGreenLight"))
                }
            }.frame(width: screenWidth-20-(screenWidth/5), height: screenHeight/6).background{Color.white.opacity(0.3)}.cornerRadius(30)
            
            Spacer().frame(height: screenHeight/4)
            
            Button(action:{
                var pointCount = UserData().loadPointCount()
                var silentTime = pointCount*60
                NotificationManager.noNotification(noNotificationTime: Int(silentTime))
            }){
                VStack{
                    HStack{
                        Image.init(systemName: "star.fill").font(.system(.body, design: .monospaced)).foregroundColor(Color.white).bold()
                        Text("Redeem All Points").font(.system(.body, design: .monospaced)).foregroundColor(Color.white).bold()
                    }
                }.frame(width: screenWidth-20-(screenWidth/5), height: screenHeight/20).background{
                    Color.init("OrangePeel")
                }.cornerRadius(40)
            }
            
            
            }.frame(width: screenWidth, height: screenHeight).background{
                LinearGradient(stops: Homebase.backgroundGradientStops, startPoint: .top, endPoint: .bottom)
        }
    }
}
