//
//  UINavigationController+Extension.swift
//  IKU
//
//  Created by Shin Jae Ung on 2022/11/28.
//

import UIKit

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
