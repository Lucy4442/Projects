//
//  UIView+SnapShot.swift
//  bottomCard
//
//  Created by mac on 25/04/24.
//  Copyright © 2024 fluffy. All rights reserved.
//

import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
