//
//  ContainerViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/18.
//

import UIKit

import SnapKit

class ContainerViewController: UIViewController {

    let containerView = UIView()
    
    let viewControllers = [
        IntroPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MovieViewController.reuseIdentifier),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TheaterViewController.reuseIdentifier)
    ]
    
    let button1: UIButton = {
        let view = UIButton()
        view.setTitle("인트로", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.tag = 0
        
        return view
    }()
    let button2: UIButton = {
        let view = UIButton()
        view.setTitle("무비", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.tag = 1
        
        return view
    }()
    let button3: UIButton = {
        let view = UIButton()
        view.setTitle("영화관", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.tag = 2
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewUI()
        
        viewControllers.forEach { vc in
            self.addChild(vc)
            containerView.addSubview(vc.view)
            
            vc.view.snp.makeConstraints { $0.edges.equalToSuperview() }
            
            vc.didMove(toParent: self)
        }
       
        
    }
    
    private func setViewUI() {
        
        view.backgroundColor = .systemBackground
        [containerView, button1, button2, button3].forEach {
            view.addSubview($0)
            if let button = $0 as? UIButton {
                button.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
            }
        }
        containerView.backgroundColor = .lightGray
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        button1.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(40)
        }
        button2.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview().inset(40)
        }
        button3.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(40)
        }
        
    }
    

    
    @objc func touchButton(_ sender: UIButton) {
        
        containerView.bringSubviewToFront(viewControllers[sender.tag].view)
        
        /*
        let vc = viewControllers[sender.tag]
        vc.removeFromParent()
        vc.view.removeFromSuperview()
        */
        
    }
    

}
