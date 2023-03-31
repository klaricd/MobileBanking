//
//  ContainerViewController.swift
//  BankApp
//
//  Created by David Klaric on 24.02.2023..
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let userInfoVC = UserInformationViewController()
    lazy var loginVC = LoginViewController()
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.navigationController?.isNavigationBarHidden = true // ovo ovak nece ic, fix asap
        
        addChildVCs()
    }
    
    //MARK: - Function
    private func addChildVCs() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // UserInfo
        userInfoVC.delegate = self
        let navVC = UINavigationController(rootViewController: userInfoVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
        
    }
}

// MARK: - Extension
extension ContainerViewController: UserInformationViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = self.userInfoVC.view.frame.size.width - 150
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
            
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = 0
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
            
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu { [weak self] in
            switch menuItem {
            case .home:
                break
            case .settings:
                break
            case .info:
                break
            case .logout:
                self?.logout()
            }
        }
    }
    
    func logout() {
        // add login child
        let vc = loginVC
        userInfoVC.addChild(vc)
        userInfoVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: userInfoVC)
        userInfoVC.title = vc.title
    }
}
