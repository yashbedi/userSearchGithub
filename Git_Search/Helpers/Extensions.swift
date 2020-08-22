//
//  Extensions.swift
//  GitUserSearch
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2018 Yash Bedi. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}


extension UITableView {
    func reloadWithAnimation() {
        UIView.transition(with: self,
                          duration: 0.55,
                          options: .transitionCrossDissolve,
                          animations: { self.reloadData() })
    }
}
