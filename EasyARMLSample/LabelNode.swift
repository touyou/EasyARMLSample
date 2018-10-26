//
//  TagNode.swift
//  EasyARMLSample
//
//  Created by 藤井陽介 on 2018/10/23.
//  Copyright © 2018 touyou. All rights reserved.
//

import SceneKit
import Vision

class LabelNode: SCNNode {

    var classificationObservation: VNClassificationObservation? {
        didSet {
            addTextNode()
        }
    }

    func addTextNode() {
        guard let text = classificationObservation?.identifier else { return }
        let node: SCNNode
        if text == "jack" {
            let scene = SCNScene(named: "TextSample.scn")
            node = scene!.rootNode
            node.scale = SCNVector3Make(0.02, 0.02, 0.02)
        } else {
            let scene = SCNScene(named: "TextSample.scn")
            node = scene!.rootNode
            node.scale = SCNVector3Make(0.02, 0.02, 0.02)
        }

        DispatchQueue.main.async {
            self.addChildNode(node)
        }
    }
}
