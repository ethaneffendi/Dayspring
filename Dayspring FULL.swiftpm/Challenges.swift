import SwiftUI
import Foundation

struct Challenges: View{
    @State var screenHeight = UIScreen.main.bounds.height
    @State var screenWidth = UIScreen.main.bounds.width
    @EnvironmentObject var appStatus: AppStatus
    var body: some View{
        VStack{
            Spacer().frame(height: screenHeight/9)
            
            HStack{
                
                Text("Quests").font(.system(.title, design: .monospaced)).bold().foregroundStyle(Color.init("SonomaGreenDark")).padding(13)
                
            }
            
            HStack{
                
                Text("Go on a quest to earn your screen time points! You'll walk steps to get exercise and complete challenges to explore the world.").bold().foregroundStyle(Color.init("SonomaGreenLight")).padding(10).multilineTextAlignment(.center).frame(width: screenWidth-20-(screenWidth/5))
            }
            ScrollView{
                VStack(alignment: .leading){
                    Button(action:{
                        appStatus.openApple = true
                        
                    }){
                        VStack{
                            HStack{
                                Image(systemName: "apple.logo").foregroundColor(Color.init("JalapeñoGreen")).frame(minWidth: screenHeight/8, minHeight: screenHeight/8).font(.title)
                                Spacer().frame(maxHeight: .infinity)
                                
                            }
                            HStack{
                                Spacer().frame(width: 35)
                                Text("Adventure Loop").bold().foregroundColor(Color.init("SonomaGreenDark")).font(.system(.title2, design: .monospaced)).frame(maxWidth: .infinity, alignment: .leading)
                            }
                            HStack{
                                Spacer().frame(width: 35)
                                Text("Explore the wonders of Apple Park!").bold().foregroundColor(Color.init("SonomaGreenLight")).font(.subheadline).frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Spacer().frame(maxWidth: .infinity)
                        }.frame(width: screenWidth-20-(screenWidth/5), height: screenHeight/4).background{
                            Color.white.opacity(0.3)
                        }.cornerRadius(40)
                    }
                    
                    Button(action:{
                        appStatus.openSick = true
                    }){
                        VStack{
                            HStack{
                                Image(systemName: "pill.fill").foregroundColor(Color.init("JalapeñoGreen")).frame(minWidth: screenHeight/8, minHeight: screenHeight/8).font(.title)
                                Spacer().frame(maxHeight: .infinity)
                            }
                            HStack{
                                Spacer().frame(width: 35)
                                Text("A Memorable Sick Day").bold().foregroundColor(Color.init("SonomaGreenDark")).font(.system(.title2, design: .monospaced)).frame(maxWidth: .infinity, alignment: .leading)
                            }
                            HStack{
                                Spacer().frame(width: 35)
                                Text("Make a sick day productive!").bold().foregroundColor(Color.init("SonomaGreenLight")).font(.subheadline).frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Spacer().frame(maxWidth: .infinity)
                        }.frame(width: screenWidth-20-(screenWidth/5), height: screenHeight/4).background{
                            Color.white.opacity(0.3)
                        }.cornerRadius(40)
                    }

                    
                }
            }
        }.frame(width: screenWidth, height: screenHeight).ignoresSafeArea().background{
            LinearGradient(stops: [Gradient.Stop(color: Color.init("SkyDarkBlue"), location: 0.05), Gradient.Stop(color: Color.init("SkyBlueII"), location: 0.50), Gradient.Stop(color: Color.init("SkyBlue"), location: 1)], startPoint: .top, endPoint: .bottom)
            
        }
    }
}
