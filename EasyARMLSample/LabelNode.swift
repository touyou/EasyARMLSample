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
        guard var text = classificationObservation?.identifier else { return }
        print(text)
        if text == "jack" {
            text = "ジャックオーランタン"
        } else {
            text = "コウモリ"
        }
        let node = SCNNode.textNode(text: text)

        DispatchQueue.main.async {
            self.addChildNode(node)
        }
    }
}
