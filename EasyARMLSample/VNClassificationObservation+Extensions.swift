//
//  VNClassificationObservation.swift
//  EasyARMLSample
//
//  Created by 藤井陽介 on 2018/10/26.
//  Copyright © 2018 touyou. All rights reserved.
//

import Foundation
import Vision

extension ViewController {

    func isFirstOrBestResult(_ result: VNClassificationObservation) -> Bool {
        for label in labels {
            guard let prevRes = label.classificationObservation else { continue }
            if prevRes.identifier == result.identifier {
                if prevRes.confidence < result.confidence {
                    if let index = labels.index(of: label) {
                        labels.remove(at: index)
                    }
                    label.removeFromParentNode()
                    return true
                }
                return false
            }
        }
        return true
    }
}
