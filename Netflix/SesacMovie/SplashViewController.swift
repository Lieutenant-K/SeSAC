//
//  SplashViewController.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/07/16.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(asset: "movie")
        view.addSubview(animationView)
        
        animationView.frame = view.frame
        animationView.play(fromFrame: 0, toFrame: 74, loopMode: .playOnce) { _ in
            
            self.presentViewControllerModally(viewController: CodeBaseMovieViewController.self)
            
            print("애니메이션 종료")
        }
        

    }
    


}
