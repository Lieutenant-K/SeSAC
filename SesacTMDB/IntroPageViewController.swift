//
//  IntroPageViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/16.
//

import UIKit

class IntroPageViewController: UIPageViewController {
    
    var pageViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        setPageViewControllers()
        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        print(#function)
    }
    
    private func setPageViewControllers() {
        
        let sb = UIStoryboard(name: "Intro", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: FirstViewController.reuseIdentifier)
        let vc2 = sb.instantiateViewController(withIdentifier: SecondViewController.reuseIdentifier)
        let vc3 = sb.instantiateViewController(withIdentifier: ThirdViewController.reuseIdentifier)
        
        pageViewControllers = [vc1, vc2, vc3]
        
        setViewControllers([vc1], direction: .forward, animated: true)
        
    }

}

extension IntroPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = pageViewControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        
        return pageViewControllers[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = pageViewControllers.firstIndex(of: viewController), index < pageViewControllers.count-1 else {
            return nil
        }
        
        return pageViewControllers[index+1]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        pendingViewControllers.forEach { print($0) }
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        guard let vc = viewControllers?.first, let index = pageViewControllers.firstIndex(of: vc) else { return 0 }
        
        return index
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pageViewControllers.count
    }
    
}
