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
    
    
    
}

class SearchViewModel {
    
    let photo: Observable<[PhotoResult]>
    var page: Int = 1 {
        didSet { searchPhoto() }
    }
    var itemsPerPage: Int
    var query: String? {
        didSet {
            page = 1
            total = 0
            photo.value = []
        }
    }
    var total: Int = 0
    
    func searchPhoto() {
        
        let url = EndPoint.search(.photos).url
        let parameter: [String: Any] = ["query": query ?? "", "page": page, "per_page": itemsPerPage]
        
        APIManager.shared.requestUnsplashedAPI(url: url, parameter: parameter) { [weak self] data in
            
            self?.photo.value.append(contentsOf: data.results)
            self?.total = data.total
        }
        
    }
    
    func updateNewPage() {
        
        page += 1
        
    }
    
    init(photo: Observable<[PhotoResult]>, itemCount: Int) {
        self.photo = photo
        itemsPerPage = itemCount
    }
    
}
