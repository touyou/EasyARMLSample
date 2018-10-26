//
//  ViewController.swift
//  EasyARMLSample
//
//  Created by 藤井陽介 on 2018/10/23.
//  Copyright © 2018 touyou. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
// CoreMLの用意
import CoreML
import Vision

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!

    // 機械学習のモデル
    var model: VNCoreMLModel!
    // 画面の真ん中
    var screenCenter: CGPoint?
    // CoreMLが実行中かどうか
    var isPerformingCoreML = false
    // 最新の検知結果
    var latestResult: VNClassificationObservation?
    // ノードのリスト
    var labels: [LabelNode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // CoreMLモデルの準備
        model = try! VNCoreMLModel(for: ImageClassifier().model)
        //        model = try! VNCoreMLModel(for: Inceptionv3().model)

        // Set the view's delegate
        sceneView.delegate = self

        // シーンを生成してARSCNViewにセット
        sceneView.scene = SCNScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // セッションの設定
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true

        // Run the view's session
        sceneView.session.run(configuration)

        // 画面の中心をとる
        screenCenter = CGPoint(x: sceneView.bounds.midX, y: sceneView.bounds.midY)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func hitTest() {
        guard let frame = sceneView.session.currentFrame else { return }
        let state = frame.camera.trackingState
        switch state {
        case .normal:
            guard let pos = screenCenter else { return }
            DispatchQueue.main.async {
                // 平面を対象にヒットテストを実行
                let results1 = self.sceneView.hitTest(pos, types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane])
                if let result = results1.first {
                    // 一個見つかったら置いて、終わり
                    self.addLabel(for: result)
                    return
                }

                // 特徴点を対象にヒットテストを実行
                let results2 = self.sceneView.hitTest(pos, types: .featurePoint)
                if let result  = results2.first {
                    self.addLabel(for: result)
                }
            }
        default:
            break
        }
    }

    func addLabel(for hitTestResult: ARHitTestResult) {
        let labelNode = LabelNode()
        labelNode.transform = SCNMatrix4(hitTestResult.worldTransform)
        labels.append(labelNode)
        labelNode.classificationObservation = latestResult
        sceneView.scene.rootNode.addChildNode(labelNode)
    }
}

// MARK: - ARSCNViewDelegate

extension ViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {

        if !self.isPerformingCoreML {

            // 今写っている画面の画像をとってくる
            guard let imageBuffer = self.sceneView.session.currentFrame?.capturedImage else {
                return
            }

            self.isPerformingCoreML = true

            let handler = VNImageRequestHandler(cvPixelBuffer: imageBuffer)
            let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                guard let best = request.results?.first as? VNClassificationObservation else {
                    self.isPerformingCoreML = false
                    return
                }

                // 信頼度が低い結果は採用しない
                if best.confidence < 0.5 {
                    self.isPerformingCoreML = false
                    return
                }

                // 初めて出る認識結果か
                if self.isFirstOrBestResult(best) {
                    self.latestResult = best
                    self.hitTest()
                }

                self.isPerformingCoreML = false
            })
            request.preferBackgroundProcessing = true

            // 画面の中心でクロップした画像を利用する
            request.imageCropAndScaleOption = .centerCrop
            do {
                try handler.perform([request])
            } catch {
                print(error)
                self.isPerformingCoreML = false
            }
        }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user

    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay

    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required

    }
}
