//
//  LoadingView.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/03.
//

import Foundation
import UIKit

class LoadingView {
  static func showLoading() {
    DispatchQueue.main.async {
      guard let window = UIApplication.shared.windows.last else { return }
      let loadingView: UIActivityIndicatorView
      if let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView {
        loadingView = existedView
      } else {
        loadingView = UIActivityIndicatorView(style: .large)
        loadingView.frame = window.frame
        loadingView.color = .darkGray
        window.addSubview(loadingView)
      }
      loadingView.startAnimating()
    }
  }
  static func hideLoading() {
    DispatchQueue.main.async {
      guard let window = UIApplication.shared.windows.last else { return }
      window.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
    }
  }
}
