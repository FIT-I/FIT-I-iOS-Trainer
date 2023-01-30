//
//  UIImage+.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/30.
//

import Foundation
import UIKit.UIImage

extension UIImage {
    
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
  
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
    
    func toHEIFString(compressionQuality cq: CGFloat) -> String? {
        let data = self.toHEIFString(compressionQuality: cq)
        return data
    }
}
