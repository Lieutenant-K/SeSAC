//
//  GCDViewController.swift
//  SesacWeek9
//
//  Created by 김윤수 on 2022/09/02.
//

import UIKit

class GCDViewController: UIViewController {
    
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
        let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
        let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func serialSync(_ sender: UIButton) {
        
        print("Start")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        
        print("End")
    }
    
    @IBAction func serialAsync(_ sender: UIButton) {
        
        print("Start")
        
        //        DispatchQueue.main.async {
        //            for i in 1...100 {
        //                print(i, terminator: " ")
        //            }
        //
        //        }
        
        for i in 1...100 {
            DispatchQueue.main.async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        
        print("End")
    }
    
    @IBAction func concurrentSync(_ sender: UIButton) {
        
        print("Start")
        
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        
        print("End")
        
    }
    
    @IBAction func concurrentAsync(_ sender: UIButton) {
        
        print("Start", "\(Thread.isMainThread)")
        
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
            
        }
        
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        
        print("End, \(Thread.isMainThread)")
    }
    
    @IBAction func qos(_ sender: UIButton) {
        
        let customQueue = DispatchQueue(label: "sesac", qos: .userInteractive, attributes: .concurrent)
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print(i, terminator: " ")
            }
        }
        
        
        for i in 101...200 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        
        
        for i in 201...300 {
            DispatchQueue.global(qos: .utility).async {
                print(i, terminator: " ")
            }
        }
        
    }
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        
        let gruop = DispatchGroup()
        
        DispatchQueue.global().async(group: gruop) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: gruop) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: gruop) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        gruop.notify(queue: .main) {
            print("그룹 종료")
        }
        
//        print("끝")
    }
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    completionHandler(UIImage(systemName: "star"))
                    return
                }

                let image = UIImage(data: data)
                completionHandler(image)
                                      
            }.resume()
        }
    
    @IBAction func nasaDispatchGroup(_ sender: UIButton) {
        
//        request(url: url1) { image in
//            print("1")
//            self.request(url: self.url2) { image in
//                print("2")
//                self.request(url: self.url3) { image in
//                    print("3")
//                }
//            }
//        }
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url1) { image in
                print("1")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url2) { image in
                print("2")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url3) { image in
                print("3")
            }
        }
        
        group.notify(queue: .main) {
            print("그룹 종료")
        }
        
        
        
    }
    @IBAction func enterAndLeave(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        var imageList: [UIImage] = []
        
        group.enter()
        request(url: url1) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url2) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url3) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.imageView1.image = imageList[0]
            self.imageView2.image = imageList[1]
            self.imageView3.image = imageList[2]
        }
        
    }
    
    
    @IBAction func raceCondition(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        var nickname = "SeSAC"
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "안녕하세요"
            print("first: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "저는"
            print("second: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "기모찌입니다."
            print("third: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("\(nickname)")
        }
        
    }
    
    
}
