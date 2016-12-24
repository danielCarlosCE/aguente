import AVFoundation

class AVCodeReader: NSObject {
    fileprivate(set) var videoPreview = CALayer()

    fileprivate var captureSession: AVCaptureSession?
    fileprivate var didRead: ((String) -> Void)?

    override init() {
        super.init()

        //Make sure the device can handle video
        guard let videoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo),
              let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            return
        }
        captureSession = AVCaptureSession()

        //input
        captureSession?.addInput(deviceInput)

        //output
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        //interprets qr codes only
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]

        //preview
        let captureVideoPreview = AVCaptureVideoPreviewLayer(session: captureSession)!
        captureVideoPreview.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoPreview = captureVideoPreview
    }
}

extension AVCodeReader: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!,
                       from connection: AVCaptureConnection!) {
        guard let readableCode = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let code = readableCode.stringValue else {
             return
        }

        //Vibrate the phone
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        stopReading()

        didRead?(code)
    }
}

extension AVCodeReader: CodeReader {
    func startReading(completion: @escaping (String) -> Void) {
        self.didRead = completion
        captureSession?.startRunning()
    }
    func stopReading() {
        captureSession?.stopRunning()
    }
}
