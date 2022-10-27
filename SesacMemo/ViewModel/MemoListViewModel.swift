//
//  MemoListViewModel.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/10/28.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

enum MemoError: Error {
    
    case realmFailure
    case overPinLimit
    
    var alertMessage: String {
        switch self {
        case .realmFailure:
            return "데이터 변경에 실패했습니다."
        case .overPinLimit:
            return "고정 가능한 최대 개수를 초과했습니다."
        }
    }
    
}

class MemoListViewModel {
    
    lazy var memoData = fetchMemoData()
    
    var searchResult: Results<Memo>?
    
    var memoCollection = PublishSubject<[[Memo]]>()
    
    var memoError = PublishRelay<MemoError>()
    
    private let repository = MemoRealmRepository()
    
    var totalCount: String {
        return memoData.totalMemoCount.decimalString
    }
    
    var isSearching: Bool = false

    
    func fetchMemoData() -> MemoCollection {
        
        let result = repository.fetchTasks()
        
        let pinnedMemos = result.where { $0.isPinned == true }
        let memos = result.where { $0.isPinned == false }
        
        return MemoCollection(pinnedMemos: pinnedMemos, memos: memos)
        
    }
    
    func fetchMemoCollection() {
        
        if isSearching, let searchResult {
            
            let collection: [[Memo]] = [searchResult.map { $0 }]
            
            memoCollection.onNext(collection)
            
        } else {
            
            let collection = memoData.pinnedMemos.count > 0 ? [memoData.pinnedMemoList, memoData.memoList] :
            [memoData.memoList]
            
            memoCollection.onNext(collection)
            
        }
    }
    
    func pinMemo(memo: Memo) {
        
        
        if !memo.isPinned && memoData.pinnedMemos.count >= 5 {
            memoError.accept(MemoError.overPinLimit)
            return
        }
        
        do {
            try self.repository.updateTask {
                memo.isPinned.toggle()
            }
            fetchMemoCollection()
        } catch {
            memoError.accept(MemoError.realmFailure)
        }
        
    }
    
    func deleteMemo(memo: Memo) {
        
        do {
            try repository.deleteTask(task: memo)
            fetchMemoCollection()
        } catch {
            memoError.accept(MemoError.realmFailure)
        }
        
    }
    
    func createMemo(completionHandler: (Memo) -> ()) {
        
        let data = Memo(memoContent: MemoContent())
        
        do {
            try repository.addTask(task: data)
            fetchMemoCollection()
            completionHandler(data)
        } catch {
            memoError.accept(MemoError.realmFailure)
        }
        
    }
    
    func fetchMemoSearchResult(query: String) {
        
        let query = query.trimmingCharacters(in: .whitespaces)
        
        isSearching = !query.isEmpty
        
//        print(query, query.isEmpty)
        
        let result = repository.fetchTasks()
        
        searchResult = result
            .where { $0.content.contains(query) }
        
        fetchMemoCollection()
        
    }
    
}
