import SwiftUI
import Foundation
import CoreML
import UserNotifications
import UserNotificationsUI

struct Homebase: View{
    @State static var backgroundGradientStops: [Gradient.Stop] = [Gradient.Stop(color: Color.init("SkyDarkBlue"), location: 0.05), Gradient.Stop(color: Color.init("SkyBlueII"), location: 0.50), Gradient.Stop(color: Color.init("SkyBlue"), location: 1)]
    @State static var capsuleGradientStops: [Gradient.Stop] = [Gradient.Stop(color: Color.init("SonomaGreenDark"), location: 0.0), Gradient.Stop(color: Color.init("SonomaGreenLight"), location: 1)]
    @State var screenHeight = UIScreen.main.bounds.height + 30
    @State var screenWidth = UIScreen.main.bounds.width
    @State var showChallenges = false
    @State var showHelpDesk = false
    @State var capsuleHidden = false
    @State var metricsHidden = true
    @State var defaults = UserDefaults.standard
    private var userData = UserData()
    @State var offset1 = 0
    @State var offset2 = 0
    @EnvironmentObject var appStatus: AppStatus
    @State var currentMetric = 0
    @State var initialHelpShow = true
    @State var showRedemption = false
    var body: some View{
        var stepCount = userData.loadStepCount()
        var challengeCount = userData.loadChallengeCount()
        var pointCount = userData.loadPointCount()
        var stepString = "STEPS"
        var challengeString = "CHALLENGES"
        var pointString = "POINTS"
        
        VStack{
                //
                Spacer().frame(width: screenWidth, height: screenHeight/20)
                
                //Cloud Component
                HStack{
                    Image("Cloud3").resizable().aspectRatio(contentMode: .fill).frame(width: (screenWidth/3)*4).offset(x: CGFloat(offset1)).onAppear{
                        
                        let animationDuration: TimeInterval = 180
                        withAnimation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: true)) {
                            offset1 = Int(screenWidth)
                        }
                        
                    }
                    
                    Image("Cloud3").resizable().aspectRatio(CGSize(width: screenWidth/5, height: screenWidth/20), contentMode: .fill).frame(width: screenWidth/2).scaleEffect(CGSize(width: -1, height: -1)).offset(x: CGFloat(offset2), y: -10).onAppear{
                       
                            let animationDuration: TimeInterval = 120
                            withAnimation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: true)) {
                                offset2 = -Int(screenWidth)
                        }
                    }
                    
                }.frame(maxHeight: screenHeight/6.5)
                
                Spacer().frame(height: screenHeight/20)
                
                //Ring
                ZStack{
                    GeometryReader{geometry in
                        ZStack{
                            Ring(percent: 100, startAngle: -90).stroke(style: StrokeStyle(lineWidth: screenWidth/12)).fill(Color.init("TextBlue")).frame(width: screenWidth-(screenWidth/8), height: screenWidth-(screenWidth/8))
                            if(currentMetric == 0){
                                ZStack{
                                    Ring(percent: Double(((stepCount/1000)*100)+1), startAngle: -90).stroke(style: StrokeStyle(lineWidth: screenWidth/12, lineCap: .round)).fill(Color.init("SkyBlue")).frame(width: screenWidth-(screenWidth/8), height: screenWidth-(screenWidth/8))
                                }
                            } else if(currentMetric == 1){
                                ZStack{
                                    Ring(percent: Double(((challengeCount/10)*100)+1), startAngle: -90).stroke(style: StrokeStyle(lineWidth: screenWidth/12, lineCap: .round)).fill(Color.init("SonomaGreenLight")).frame(width: screenWidth-(screenWidth/8), height: screenWidth-(screenWidth/8))
                                }
                            } else{
                                ZStack{
                                    Ring(percent: Double(((challengeCount/20)*100)+1), startAngle: -90).stroke(style: StrokeStyle(lineWidth: screenWidth/12, lineCap: .round)).fill(Color.init("SunrayYellow")).frame(width: screenWidth-(screenWidth/8), height: screenWidth-(screenWidth/8))
                                }
                            }
                        }
                    }
                    if(currentMetric == 0){
                        VStack{
                            Text(String(stepCount)).foregroundColor(Color.init("TextBlue")).font(.system(size: 100, design: .monospaced)).bold()
                            Text(stepString).font(.system(.body, design: .monospaced)).foregroundColor(Color.init("TextBlue")).bold().kerning(3)
                            Spacer().frame(height: screenHeight/40)
                        }
                    } else if(currentMetric == 1){
                        VStack{
                            Text(String(challengeCount)).foregroundColor(Color.init("SonomaGreenDark")).font(.system(size: 100, design: .monospaced)).bold()
                            Text(challengeString).font(.system(.body, design: .monospaced)).foregroundColor(Color.init("SonomaGreenDark")).bold().kerning(3)
                            Spacer().frame(height: screenHeight/40)
                        }
                    } else{
                        VStack{
                            Text(String(pointCount)).foregroundColor(Color.init("MustardYellow")).font(.system(size: 100, design: .monospaced)).bold()
                            Text(pointString).font(.system(.body, design: .monospaced)).foregroundColor(Color.init("MustardYellow")).bold().kerning(3)
                            Spacer().frame(height: screenHeight/40)
                            
                            Button(action:{
                                showRedemption = true
                            }){
                                Text("Redeem").font(.system(.body , design: .default)).bold().padding(10).foregroundStyle(Color.white).background(Color.init("MustardYellow")).cornerRadius(10)
                            }
                        }.sheet(isPresented: $showRedemption){
                            PointRedemption()
                        }
                    }
                }
                //Next
                HStack{
                    Button(action:{
                        if currentMetric<2{
                            currentMetric+=1
                        } else{
                            currentMetric=0
                        }
                    }){
                        Text("Show Next Metric").bold().padding(10).padding([.horizontal], 5).font(.system(.subheadline, design: .default))
                    }.foregroundStyle(Color.init("TextBlue")).background(Color.init("TextBlue").opacity(0.2)).cornerRadius(10)
                }
                
                Spacer().frame(height: screenHeight/6)
                
                //Challenges-Help Component
                HStack{
                    Button(action:{
                        showChallenges=true
                    }){
                        Text("Quests").font(.system(.subheadline , design: .monospaced)).bold().padding(10)
                    }.foregroundStyle(Color.white).background(Color.white.opacity(0.2)).cornerRadius(30).sheet(isPresented: $showChallenges){
                        Challenges().frame(maxWidth: .infinity, maxHeight: .infinity).environmentObject(appStatus)
                    }
                    Spacer().frame(width: screenWidth/2, height:0)
                    Button(action:{
                        showHelpDesk=true
                    }){
                        Text("?").bold().padding(10).padding([.horizontal], 5).font(.system(.subheadline, design: .monospaced))
                    }.foregroundStyle(Color.white).background(Color.white.opacity(0.2)).cornerRadius(30).sheet(isPresented: $showHelpDesk){
                        HelpDesk()
                    }.background{
                        
                    }
                }.frame(maxHeight: screenHeight/20)
            
            Spacer().frame(height: screenHeight/20)
                
            }.ignoresSafeArea().frame(width: screenWidth, height: screenHeight).background{
                LinearGradient(stops: Homebase.backgroundGradientStops, startPoint: .top, endPoint: .bottom)
                
                
                
            }.onAppear{
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){success, error in
                    
                }
                
            }
    }
}


