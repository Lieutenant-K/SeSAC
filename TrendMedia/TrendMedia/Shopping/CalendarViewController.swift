//
//  CalendarViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/28.
//

import UIKit

import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {
    
    let tasks: Results<ShoppingItem>
    
    lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.backgroundColor = .systemBackground
        view.calendar.dataSource = self
        view.calendar.delegate = self
        return view
    }()
    
    override func loadView() {
        view = calendarView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    init(tasks: Results<ShoppingItem>) {
        self.tasks = tasks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate  {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        tasks.filter { item in
            item.creationDate >= date && item.creationDate < Date(timeInterval: 86400, since: date)
        }.count
    }
    
}
