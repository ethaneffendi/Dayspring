import SwiftUI
import Foundation
import AVFoundation
import Vision
import UIKit
import CoreImage
import CoreMotion

struct AdventureLoop: View{
    //App-Level Resources
    @EnvironmentObject var appStatus: AppStatus
    //Device Information
    @State var screenHeight = UIScreen.main.bounds.height + 30
    @State var screenWidth = UIScreen.main.bounds.width
    //Show Modes
    @State var modeFeatures = Show()
    @State var currentIndex = 0
    //Challenge Resources
    @State var challengesCompleted = 0
    @State var currentChallengeNum = 0
    //Stopwatch Resources
    @State var seconds = 0
    @State var minutes = 0
    @State var hours = 0
    //Pedometer Resources
    @State var pedometer = CMPedometer()
    @State var stepCount = 0
    
    var body: some View{
        //Work Splitting
        let currentFeature = modeFeatures.features[currentIndex]
        let currentCircleStyle = modeFeatures.stops[currentIndex]
        let currentShowString = modeFeatures.showString[currentIndex]
        VStack{
            Spacer().frame(height: screenHeight/10)
            
            //FLAG
            HStack{
                Text(currentFeature).font(.system(.body, design: .monospaced)).foregroundColor(Color.white).padding(10).cornerRadius(5).bold()
                Spacer().frame(maxWidth:.infinity)
            }
            
            //SCANNER SET
            ZStack{
                Circle().fill(LinearGradient(stops: currentCircleStyle, startPoint: .leading, endPoint: .trailing))
                ImageViewControllerRepresentable().offset(y:-100).mask(Circle()).scaleEffect(4/5)
            }
            HStack{
                if ChallengeManager.itemFound{
                    Text("⬤").foregroundColor(Color.green).font(.caption)
                } else{
                    Text("⬤").foregroundColor(Color.init("TextBlue")).font(.caption)
                }
                if ChallengeManager.itemFound{
                    Text("Challenge Item Found").foregroundColor(Color.green).font(.caption)
                } else{
                    Text("Challenge Item Not In Frame").foregroundColor(Color.init("TextBlue")).font(.caption)
                }
            }
            Spacer().frame(height: screenHeight/20)
            //NEXT FEATURE BUTTON
            HStack{
                Button(action:{
                    if currentIndex < 2{
                        currentIndex+=1
                    } else{
                        currentIndex = 0
                    }
                    
                }){
                    Text(currentShowString).font(.system(.body , design: .monospaced)).bold().padding(10).foregroundStyle(Color.white).background(Color.white.opacity(0.3)).cornerRadius(30)
                }
            }
            
            Spacer().frame(height: screenHeight/45)
            
            //INFORMATION
            VStack{
                if(currentFeature == "Stopwatch"){
                    HStack{
                        Image.init(systemName: "stopwatch").font(.system(.largeTitle, design: .monospaced)).foregroundColor(Color.init("JalapeñoGreen"))
                        Spacer().frame(width: screenWidth/40)
                        Text(String(hours) + " : " + String(minutes) + " : " + String(seconds)).font(.system(.largeTitle, design: .monospaced)).foregroundColor(Color.init("SonomaGreenDark"))
                    }
                }
                if(currentFeature == "Steps"){
                    HStack{
                        Image.init(systemName: "shoeprints.fill").font(.largeTitle).foregroundColor(Color.init("MustardYellow"))
                        Text(String(stepCount)).foregroundColor(Color.init("MustardYellow")).font(.system(.largeTitle, design: .monospaced))
                    }
                }
                if(currentFeature == "Challenge"){
                    VStack{
                        Text(ChallengeManager.wwHeaders[currentChallengeNum]).foregroundColor(Color.init("SuperLightBlue")).font(.system(.largeTitle, design: .default)).bold()
                        Spacer().frame(height: screenWidth/20)
                        Text(ChallengeManager.wwInstructions[currentChallengeNum]).foregroundColor(Color.init("SuperLightBlue")).font(.system(.caption, design: .default)).bold().multilineTextAlignment(.center).bold()
                        Spacer().frame(height: screenWidth/20)
                        if(ChallengeManager.itemFound){
                            Button(action:{
                                if currentChallengeNum<3{
                                    currentChallengeNum+=1
                                } else{
                                    currentChallengeNum = 0
                                }
                                
                                if ChallengeManager.currentChallenge<3{
                                    ChallengeManager.currentChallenge+=1
                                } else{
                                    ChallengeManager.currentChallenge = 0
                                }
                                
                                let challengeCount = UserData().loadChallengeCount()
                                UserData().saveChallengeCount(challengeCount: challengeCount+1)
                                
                                challengesCompleted+=1
                            }){
                                Text("Claim Challenge").font(.system(.body , design: .default)).bold().padding(10).foregroundStyle(Color.white).background(Color.init("OrangePeel")).cornerRadius(10)
                            }
                        }
                        
                    }
                }
            }.frame(width: screenWidth-10, height: (screenHeight-30)/4).background{
                Color.white.opacity(0.3)}.cornerRadius(30)
            
            Spacer().frame(height: screenHeight/45)
            
            //END SESSION
            HStack{
                Button(action:{
                    appStatus.openApple = false
                    
                    let stepPoints = Int(floor(Double(stepCount/500)))
                    let challengePoints = Int(challengesCompleted)
                    
                    let pointCount = UserData().loadPointCount()
                    UserData().savePointCount(pointCount: pointCount+Int64(stepPoints)+Int64(challengePoints))
                    
                    ChallengeManager.currentChallenge = 0
                }){
                    VStack{
                        Text("End Quest").font(.system(.body, design: .monospaced)).foregroundColor(Color.white).bold()
                    }.frame(width: screenWidth-10, height: screenHeight/20).background{
                        Color.white.opacity(0.3)
                    }.cornerRadius(40)
                }
            }
            
            HStack{
                if currentIndex != 2{
                    Button(action:{
                        currentIndex = 2
                    }){
                        Text("See Challenge").font(.system(.body , design: .default)).bold().padding(10).foregroundStyle(Color.white).background(Color.init("OrangePeel")).cornerRadius(10)
                    }
                }
            }.frame(height: screenHeight/7)
            
        }.ignoresSafeArea().frame(width: screenWidth, height: screenHeight).background{
            LinearGradient(stops: Homebase.backgroundGradientStops, startPoint: .top, endPoint: .bottom)
        }.onAppear{
           //STOPWATCH WORK

            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true){timer in
                if seconds == 59{
                    seconds=0
                } else{
                    seconds+=1
                }
            }
            
            Timer.scheduledTimer(withTimeInterval: 60, repeats: true){timer in
                if minutes == 59{
                    minutes=0
                } else{
                    minutes+=1
                }
            }
            
            Timer.scheduledTimer(withTimeInterval: 3600, repeats: true){timer in
                hours+=1
            }
            
            //PEDOMETER WORK
            if (CMPedometer.isStepCountingAvailable()){
                pedometer.startUpdates(from: Date()){pedometerData, error in
                    guard let pedometerData = pedometerData, error == nil else {
                        return
                    }
                    DispatchQueue.main.async{
                        stepCount = pedometerData.numberOfSteps.intValue
                        
                    }
                }
            }
        }
    }
}

