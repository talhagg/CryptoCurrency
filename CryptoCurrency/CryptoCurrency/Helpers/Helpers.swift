//
//  Helpers.swift
//  CryptoCurrency
//
//  Created by Talha Gölcügezli on 11.02.2023.
//

import UIKit
import Kingfisher
import SVGKit


public struct SVGImgProcessor:ImageProcessor {
    public var identifier: String = "com.appidentifier.webpprocessor"
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}
