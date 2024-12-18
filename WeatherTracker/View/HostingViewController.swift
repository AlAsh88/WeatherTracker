//
//  HostingViewController.swift
//  WeatherTracker
//
//  Created by Ayesha Shaikh on 12/18/24.
//

import UIKit
import SwiftUI

class HostingViewController: UIHostingController<ContentView> {

    required init?(coder: NSCoder) {
        let contentView = ContentView(message: "Hello from UIKit!")
        super.init(coder: coder, rootView: contentView)
    }

}
