//
//  SCNNode+.swift
//  EasyARMLSample
//
//  Created by 藤井陽介 on 2018/10/23.
//  Copyright © 2018 touyou. All rights reserved.
//
// https://github.com/peaks-cc/iOS11samplecode/tree/master/chapter_02/09_ARObjectDetection

import SceneKit

extension SCNNode {

    static func textNode(text: String) -> SCNNode {

//        // テキストノード
//        let geometry = SCNText(string: text, extrusionDepth: 0.01)
//        geometry.alignmentMode = CATextLayerAlignmentMode.center.rawValue
//        geometry.font = UIFont.systemFont(ofSize: 1, weight: .thin)
//        if let material = geometry.firstMaterial {
//            material.diffuse.contents = UIColor(displayP3Red: 255.0 / 255.0, green: 224.0 / 255.0, blue: 178.0 / 255.0, alpha: 1.0)
//            material.isDoubleSided = true
//        }
//        let textNode = SCNNode(geometry: geometry)
//        textNode.scale = SCNVector3Make(0.02, 0.02, 0.02)
//        let (min, max) = geometry.boundingBox
//        textNode.pivot = SCNMatrix4MakeTranslation((max.x - min.x) / 2, min.y - 0.5, 0)
//
//        // 球体
//        let sphereGeometry = SCNSphere(radius: 0.01)
//        sphereGeometry.materials.first?.diffuse.contents = UIColor(displayP3Red: 255.0 / 255.0, green: 224.0 / 255.0, blue: 178.0 / 255.0, alpha: 1.0)
//        let sphereNode = SCNNode(geometry: sphereGeometry)
//
//        // 光
//        let lightNode = SCNNode()
//        lightNode.light = SCNLight()
//        lightNode.light!.type = .omni
//        lightNode.light!.color = UIColor.orange
//        lightNode.position = textNode.position
//
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light!.type = .ambient
//        ambientLightNode.light!.color = UIColor.orange
//
//        let node = SCNNode()
//        let billboardConstraint = SCNBillboardConstraint()
//        node.constraints = [billboardConstraint]
//        node.addChildNode(textNode)
//        node.addChildNode(sphereNode)
//        node.addChildNode(lightNode)
//        node.addChildNode(ambientLightNode)
//        return node

        let scene = SCNScene(named: "TextSample.scn")
        let node = scene!.rootNode
        node.scale = SCNVector3Make(0.02, 0.02, 0.02)
        return node
    }
}
