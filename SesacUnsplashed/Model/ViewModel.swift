//
//  ViewModel.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/10/23.
//

import Foundation

class Observable<T> {
    
    var value: T {
        didSet {
            listner?()
        }
    }
    
    private var listner: (() -> Void)?
    
    func bind(handler: @escaping () -> Void) {
        listner = handler
        handler()
    }
    
    init(value: T) {
        self.value = value
    }
    
}

class PostViewModel {
    
    let title = Observable<String>(value: "")
    let subtitle = Observable<String>(value: "")
    let content = Observable<String>(value: "")
    
    func inputTitle(text: String) {
        
        let text = text.trimmingCharacters(in: .whitespaces)
        
        title.value = text
        
    }
    
}

class SearchViewModel {
    
    let photo: Observable<[PhotoResult]>
//    var selectedPhoto: Observable<PhotoResult>?
    var page: Int = 1 {
        didSet { searchPhoto() }
    }
    var itemsPerPage: Int
    var query: String? {
        didSet {
            total = 0
            page = 1
            photo.value = []
        }
    }
    var total: Int = 0
    
    func searchPhoto() {
        
        let url = EndPoint.search(.photos).url
        let parameter: [String: Any] = ["query": query ?? "", "page": page, "per_page": itemsPerPage]
        
        APIManager.shared.requestUnsplashedAPI(url: url, parameter: parameter) { [weak self] data in
            
            self?.total = data.totalPages
            self?.photo.value.append(contentsOf: data.results)
        }
        
    }
    
    func updatePage(indexPath: IndexPath) {
        
        let count = photo.value.count
        
        if indexPath.row == count-4 && page < total {
            page += 1
        }
        
    }
    
    func sendImageURL(indexPath: IndexPath) {
        
        let url = photo.value[indexPath.row].urls.regular
        
        NotificationCenter.default.post(name: .sendImageURLNotification, object: nil, userInfo: ["imageURL": url])
        
    }
    
    init(photo: Observable<[PhotoResult]>, itemCount: Int) {
        self.photo = photo
        itemsPerPage = itemCount
    }
    
}
