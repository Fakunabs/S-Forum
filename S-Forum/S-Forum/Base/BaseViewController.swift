//
//  BaseViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 30/10/2023.
//

import UIKit
import Network

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monitorNetwork()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
    }

    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    print("Connected")
                }
            } else {
                DispatchQueue.main.async {
                    let connectionErrorView = LostConnectionViewController()
                    connectionErrorView.modalPresentationStyle = .overFullScreen
                    connectionErrorView.modalTransitionStyle = .coverVertical
                    self.present(connectionErrorView, animated: false, completion: nil)
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
}
