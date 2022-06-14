//
//  Coordinator.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
