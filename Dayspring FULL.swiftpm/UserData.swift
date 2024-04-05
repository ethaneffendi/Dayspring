import Foundation

struct UserData{
    var stepKey = "steps"
    var challengesKey = "challenges"
    var pointsKey = "points"
    
    
    let userDefaults = UserDefaults.standard
    
    
    func saveStepCount(stepCount: Int64){
        userDefaults.set(stepCount, forKey: stepKey)
    }
    func loadStepCount() -> Int64{
        guard let stepCount = userDefaults.object(forKey: stepKey) as? Int64 else {return 0}
        return stepCount
    }
    
    
    func saveChallengeCount(challengeCount: Int64){
        userDefaults.set(challengeCount, forKey: challengesKey)
    }
    func loadChallengeCount() -> Int64{
        guard let challengeCount = userDefaults.object(forKey: challengesKey) as? Int64 else {return 0}
        return challengeCount
    }
    
    
    func savePointCount(pointCount: Int64){
        userDefaults.set(pointCount, forKey: pointsKey)
    }
    func loadPointCount() -> Int64{
        guard let pointCount = userDefaults.object(forKey: pointsKey) as? Int64 else {return 0}
        return pointCount
    }
    
    
}


