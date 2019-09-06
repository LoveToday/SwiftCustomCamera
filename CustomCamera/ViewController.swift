//
//  ViewController.swift
//  CustomCamera
//
//  Created by ChenJiangLin on 2019/9/6.
//  Copyright © 2019 ChenJiangLin. All rights reserved.
//

import UIKit
import GPUImage
class ViewController: UIViewController {
    /// 相机
    lazy var videoCamera: GPUImageStillCamera? = {
        let camera = GPUImageStillCamera(sessionPreset: AVCaptureSession.Preset.vga640x480.rawValue, cameraPosition: AVCaptureDevice.Position.front)
        camera?.frameRate = 30
        camera?.outputImageOrientation = UIInterfaceOrientation.portrait
        camera?.delegate = self
        camera?.addAudioInputsAndOutputs()
        camera?.horizontallyMirrorFrontFacingCamera = true
        return camera
    }()
    /// 显示层
    lazy var filterView: GPUImageView = {
        let view = GPUImageView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.width))
        view.fillMode = kGPUImageFillModePreserveAspectRatioAndFill
        return view
    }()
    /// 滤镜
    lazy var filter: TencentBeautyFilter = {
        let fil = TencentBeautyFilter()
        return fil
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(self.filterView)
        videoCamera?.addTarget(filter)
        filter.addTarget(self.filterView)
        DispatchQueue.global().async {
            self.videoCamera?.startCapture()
        }
        
    }


}
extension ViewController: GPUImageVideoCameraDelegate{
    /// 输出原始的buf
    func willOutputSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
        
    }
}

