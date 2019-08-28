//
//  ImageDownloaderProtocol.swift
//  
//
//  Created by Toby Youngberg on 8/20/19.
//

import Foundation
import UIKit

public protocol ImageDownloaderProtocol {
    func set(imageURL: URL, in imageView: UIImageView)
}
