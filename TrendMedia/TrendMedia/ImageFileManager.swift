//
//  ImageFileManager.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/27.
//

import UIKit

class ImageFileManager {
    
    static let shared = ImageFileManager()
    
    private init() { }
    
    func saveImageToDocument(image: UIImage, fileName: String) {
        
        
        guard let imageURL = URL.documentPath?.appendingPathComponet(pathComponent: .imageDirectory) else { return }
        
        if !FileManager.default.fileExists(atPath: imageURL.path) {
            
            do {
                try FileManager.default.createDirectory(at: imageURL, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print(error)
            }
        }
        
        let url = imageURL.appendingPathComponent("\(fileName).png")
        
        let data = image.pngData()
        
        do {
            try data?.write(to: url)
        } catch let error {
            print(error)
        }

    }

    func loadImageFromDocument(fileName: String) -> UIImage? {
        
        guard let imageURL = URL.documentPath?.appendingPathComponet(pathComponent: .imageDirectory) else { return nil }
        
        let url = imageURL.appendingPathComponent("\(fileName).png")
        
        if FileManager.default.fileExists(atPath: url.path) {
            return UIImage(contentsOfFile: url.path)
        } else {
            return .init(systemName: "xmark")
        }

    }

    func removeImageFromDocument(fileName: String) {
        
        guard let imageURL = URL.documentPath?.appendingPathComponet(pathComponent: .imageDirectory) else { return }
        
        let url = imageURL.appendingPathComponent("\(fileName).png")
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                
                try FileManager.default.removeItem(at: url)
                
            } catch let error {
                print(error)
            }
        } else {
            print("File is not Exist")
        }
        
        
        
    }

    
}
