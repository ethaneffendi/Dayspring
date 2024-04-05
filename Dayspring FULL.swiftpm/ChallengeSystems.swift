import SwiftUI
import Foundation
import AVFoundation
import Vision
import UIKit
import CoreImage
import CoreMotion
import Charts

//ModelLocations
class ModelLocations {
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "Models/Leaves", withExtension:"mlmodel")!
    }
}

//Models
class Models{
    static let leavesModelURL = Bundle.main.url(forResource: "Models/LeavesModel", withExtension: "mlmodel")!
    static let leaves_compiledModelURL = try? MLModel.compileModel(at: leavesModelURL)
    static let leavesModel = try? MLModel(contentsOf: leaves_compiledModelURL!)
    static let VNleavesModel = try? VNCoreMLModel(for: leavesModel!)
    
    static let logoModelURL = Bundle.main.url(forResource: "Models/AppleLogoModel", withExtension: "mlmodel")!
    static let logo_compiledModelURL = try? MLModel.compileModel(at: logoModelURL)
    static let logoModel = try? MLModel(contentsOf: logo_compiledModelURL!)
    static let VNlogoModel = try? VNCoreMLModel(for: logoModel!)
    
    static let keyboardModelURL = Bundle.main.url(forResource: "Models/MagicKeyboardModel", withExtension: "mlmodel")!
    static let keyboard_compiledModelURL = try? MLModel.compileModel(at: keyboardModelURL)
    static let keyboardModel = try? MLModel(contentsOf: keyboard_compiledModelURL!)
    static let VNkeyboardModel = try? VNCoreMLModel(for: keyboardModel!)
    
    static let stageModelURL = Bundle.main.url(forResource: "Models/AppleParkStageModel", withExtension: "mlmodel")!
    static let stage_compiledModelURL = try? MLModel.compileModel(at: stageModelURL)
    static let stageModel = try? MLModel(contentsOf: stage_compiledModelURL!)
    static let VNstageModel = try? VNCoreMLModel(for: stageModel!)
    
    static let applesModelURL = Bundle.main.url(forResource: "Models/ApplesModel", withExtension: "mlmodel")!
    static let apples_compiledModelURL = try? MLModel.compileModel(at: applesModelURL)
    static let appleModel = try? MLModel(contentsOf: apples_compiledModelURL!)
    static let VNappleModel = try? VNCoreMLModel(for: appleModel!)
    
    static let bananasModelURL = Bundle.main.url(forResource: "Models/BananasModel", withExtension: "mlmodel")!
    static let bananas_compiledModelURL = try? MLModel.compileModel(at: bananasModelURL)
    static let bananaModel = try? MLModel(contentsOf: bananas_compiledModelURL!)
    static let VNbananaModel = try? VNCoreMLModel(for: bananaModel!)
    
    static let thermometerModelURL = Bundle.main.url(forResource: "Models/ThermometersModel", withExtension: "mlmodel")!
    static let thermometer_compiledModelURL = try? MLModel.compileModel(at: thermometerModelURL)
    static let thermometerModel = try? MLModel(contentsOf: thermometer_compiledModelURL!)
    static let VNthermometerModel = try? VNCoreMLModel(for: thermometerModel!)
}

//UISetup
class Show{
    var features = ["Stopwatch", "Steps", "Challenge"]
    var colors = ["Green", "Yellow", "Amaranth"]
    var stops = [[Gradient.Stop(color: Color.init("JalapeñoGreen"), location: 0), Gradient.Stop(color: Color.init("SonomaGreenDark"), location: 1)],[Gradient.Stop(color: Color.init("MustardYellow"), location: 0), Gradient.Stop(color: Color.init("SunrayYellow"),location: 1)],[Gradient.Stop(color: Color.init("GentleRedDark"), location: 0), Gradient.Stop(color: Color.init("GentleRed"), location: 1)]]
    var showString = ["Show Steps", "Show Challenge", "Show Stopwatch"]
    
    init(){}
}

//ImageViewController
class ImageViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{
    var detectionLayer: CALayer! = nil
    var model: VNCoreMLModel = Models.VNleavesModel!

    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        var currentModel = ChallengeManager.modelList[ChallengeManager.currentChallenge]
        var currentVNModel = try? VNCoreMLModel(for: currentModel!)
        let request = VNCoreMLRequest(model: currentVNModel!){(finishedReq, errors) in
            print("_________________________")
            print(currentModel)
            print(ChallengeManager.currentChallenge)
//            print(finishedReq.results)
            if(finishedReq.results?.count == 0){
                ChallengeManager.itemFound = false
            } else{
                print(ChallengeManager.currentChallenge)
                ChallengeManager.itemFound = true
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
        override func viewDidLoad(){
        super.viewDidLoad()
        
        //SETUP
        let captureSession = AVCaptureSession()
        //-device
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        //-input
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {return}
        captureSession.addInput(input)
        //-output
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        //EXECUTION
        captureSession.startRunning()
        
        //DISPLAY
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        
    }
    
    
}
    
    
    //ImageViewControllerRepresentable
struct ImageViewControllerRepresentable: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIViewController {
        let imageViewController = ImageViewController()
        return imageViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

