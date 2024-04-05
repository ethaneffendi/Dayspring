import SwiftUI
import Foundation

struct HelpDesk: View{
    var body: some View{
        TabView{
            Welcome().tabItem{}
            HowDoesItWork().tabItem{}
            HomebaseIntro().tabItem{}
            QuestIntro().tabItem{}
        }.tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct Welcome: View{
    @State var screenHeight = UIScreen.main.bounds.height
    @State var screenWidth = UIScreen.main.bounds.width
    var body: some View{
        VStack{
            Spacer().frame(height: screenHeight/10)
            Text("Do you spend too much time scrolling?").font(.system(size: 50, design: .default)).foregroundColor(Color.init("JalapeñoGreen")).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            Text("You aren't alone.").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño")).bold().multilineTextAlignment(.center)
            Text("With Dayspring, we can all reharness our time online—for the better.").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño")).bold().multilineTextAlignment(.center)
            Image("Trees2a").resizable().aspectRatio(contentMode: .fill).scaleEffect(1/2)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().background{
            Color.init("SuperLightBlue")
        }
    }
}

struct HowDoesItWork: View{
    @State var screenHeight = UIScreen.main.bounds.height
    @State var screenWidth = UIScreen.main.bounds.width
    var body: some View{
        VStack{
            
            Spacer().frame(height: screenHeight/10)
            Text("How does it all work?").font(.system(size: 50, design: .default)).foregroundColor(Color.init("JalapeñoGreen")).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Text("Fundamentally, Dayspring is your refuge from reels and posts—it's there whenever you want to re-experience the real world.").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño")).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Text("Upon leaving the app, you will be sent continuous notifications. These are meant to guide you back to Dayspring, your island of wellbeing.").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño").opacity(0.75)).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Text("Dayspring won't allow you to sit around and do nothing though! By earning points in Quests, you can purchase time to enjoy other apps in moderation.").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño").opacity(0.5)).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Text("Let's get into some demo material!").font(.system(size: 20, design: .default)).foregroundColor(Color.init("SkyBlueII")).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Image("Trees1").resizable().aspectRatio(contentMode: .fill).scaleEffect(1/2)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().background{
            Color.init("SuperLightBlue")
        }
    }
}

struct HomebaseIntro: View{
    @State var screenHeight = UIScreen.main.bounds.height
    @State var screenWidth = UIScreen.main.bounds.width
    var body: some View{
        VStack{
            
            Spacer().frame(height: screenHeight/30)
            Text("Welcome to Homebase!").font(.system(size: 50, design: .default)).foregroundColor(Color.init("JalapeñoGreen")).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Image("Homebase").resizable().cornerRadius(20).aspectRatio(contentMode: .fit)
            
            Text("By pressing the Show Next Metric button, you can view how many steps you've walked, challenges you've completed, and points you've earned during Quests. ").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño")).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Text("Do you want to go on a Quest? Click the Quest button in the bottom left corner, and choose the Quest that's right for you.").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño").opacity(0.75)).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Text("If you want to redeem your points for free time, click the Show Next Metric button until the Redeem button appears.").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño").opacity(0.5)).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/80)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().background{
            Color.init("SuperLightBlue")
        }
    }
}

struct QuestIntro: View{
    @State var screenHeight = UIScreen.main.bounds.height
    @State var screenWidth = UIScreen.main.bounds.width
    var body: some View{
        VStack{
            
            Spacer().frame(height: screenHeight/30)
            Text("Let's look at a quest.").font(.system(size: 50, design: .default)).foregroundColor(Color.init("JalapeñoGreen")).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Image("Quest").resizable().cornerRadius(20).aspectRatio(contentMode: .fit)
            
            Text("By pressing the button that says Show Steps, Show Challenge, or Show Stopwatch, you can toggle between screens with different metrics.").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño")).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Text("For every 500 steps you walk, you'll receive a point. For every challenge you complete, you'll earn a point as well.").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño").opacity(0.75)).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
            Text("Challenges will ask you to put a certain item in view of your camera. Be on the challenge screen in order to claim an item in view.").font(.system(size: 20, design: .default)).foregroundColor(Color.init("LightJalapeño")).opacity(0.5).bold().multilineTextAlignment(.center)
            Spacer().frame(height: screenHeight/100)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().background{
            Color.init("SuperLightBlue")
        }
    }
}

