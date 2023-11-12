//
//  IconSegment.swift
//  BetterSegmentedControl
//
//  Created by George Marmaridis on 10/02/2018.
//

#if canImport(UIKit)

import UIKit

open class IconSegment: BetterSegmentedControlSegment {
    // MARK: Constants
    private struct DefaultValues {
        static let normalBackgroundColor: UIColor = .clear
        static let selectedBackgroundColor: UIColor = .clear
    }
    
    // MARK: Properties
    public var icon: UIImage
    public var iconSize: CGSize
    
    public var normalBackgroundColor: UIColor
    
    public var selectedBackgroundColor: UIColor
    
    // MARK: Lifecycle
    public init(icon: UIImage,
                iconSize: CGSize,
                normalBackgroundColor: UIColor? = nil,
                selectedBackgroundColor: UIColor? = nil) {
        self.icon = icon.withRenderingMode(.alwaysTemplate)
        self.iconSize = iconSize
        self.normalBackgroundColor = normalBackgroundColor ?? DefaultValues.normalBackgroundColor
        self.selectedBackgroundColor = selectedBackgroundColor ?? DefaultValues.selectedBackgroundColor
    }
    
    // MARK: BetterSegmentedControlSegment
    public var intrinsicContentSize: CGSize? { nil }
    
    public lazy var normalView: UIView = {
        return createView(withIcon: icon,
                          iconSize: iconSize,
                          backgroundColor: normalBackgroundColor)
    }()
    public lazy var selectedView: UIView = {
       return createView(withIcon: icon,
                         iconSize: iconSize,
                         backgroundColor: selectedBackgroundColor)
    }()
    private func createView(withIcon icon: UIImage,
                            iconSize: CGSize,
                            backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        let imageView = UIImageView(image: icon)
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: iconSize.width,
                                 height: iconSize.height)
        imageView.contentMode = .scaleAspectFit
        imageView.autoresizingMask = [.flexibleTopMargin,
                                      .flexibleLeftMargin,
                                      .flexibleRightMargin,
                                      .flexibleBottomMargin]
        view.addSubview(imageView)
        return view
    }
}

public extension IconSegment {
    class func segments(withIcons icons: [UIImage],
                        iconSize: CGSize,
                        normalBackgroundColor: UIColor? = nil,
                        selectedBackgroundColor: UIColor? = nil) -> [BetterSegmentedControlSegment] {
        return icons.map {
            IconSegment(icon: $0,
                        iconSize: iconSize)
        }
    }
}

#endif
