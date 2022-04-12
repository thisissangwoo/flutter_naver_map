//
//  UIImage+resize.swift
//  flutter_naver_map
//
//  Created by 강우석 on 2022/04/12.
//

import UIKit

extension UIImage {
    func resize(scale: CGFloat) -> UIImage? {
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        let size = self.size.applying(transform)
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }
}
