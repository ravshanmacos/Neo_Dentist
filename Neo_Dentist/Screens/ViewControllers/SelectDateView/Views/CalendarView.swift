//
//  CalendarView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 30/12/23.
//

import UIKit
 
protocol CalendarViewDelegate: AnyObject {
    func dayIsSelected(with dayNumber: Int)
}

class CalendarView: BaseView {
    //MARK: Properties
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = CalendarConfigure.shared.getDateFormattedString()
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let width = (contentWidth() - 30) / 7
        layout.itemSize = .init(width: width, height: width)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier)
        return view
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private let weekDaySymbols = CalendarConfigure.shared.getWeekdaySymbols()
    private let firstDayOfMonth = CalendarConfigure.shared.getFirstDayOfMonth()
    private let daysOfCurrentMonth = CalendarConfigure.shared.getDaysOfCurrentMonth()
    private let daysOfPreviousMonth = CalendarConfigure.shared.getDaysOfPreviousMonth()
    private var selectedDay: Int?
    private var number = CalendarConfigure.shared.getFirstDayOfMonth() - 2
    
    var delegate: CalendarViewDelegate?
    var workingDays: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: Methods
    override func setupUI() {
        super.setupUI()
        addSubviews(monthLabel, hStack, collectionView)
        weekDaySymbols.forEach { weekdaySymbol in
            let label = makeWeekdaySymbolLabel(weekdayString: weekdaySymbol)
            hStack.addArrangedSubview(label)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        monthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(8)
        }
        
        hStack.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        backgroundColor = .white
        layer.borderWidth = 0.2
        layer.borderColor = R.color.green_light()?.cgColor
        layer.cornerRadius = 8
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = daysOfCurrentMonth + (firstDayOfMonth - 1 )
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier, for: indexPath) as! CalendarCollectionViewCell
        var dayInt: Int
        if indexPath.row > firstDayOfMonth - 2 {
            dayInt = indexPath.row - (firstDayOfMonth - 2)
            dayInt == selectedDay ? cell.setSelectedDay() : cell.clearDay()
            for weekendDay in CalendarConfigure.shared.getWeekendDays() {
                if weekendDay == indexPath.row {
                    cell.dayLabel.textColor = R.color.red_error()
                    cell.isUserInteractionEnabled = false
                }
            }
             if !workingDays.isEmpty, CalendarConfigure.shared.isTodayOFFDay(daySymbols: workingDays, currentDay: indexPath.row) {
                 cell.dayLabel.textColor = R.color.gray_light()
                 cell.isUserInteractionEnabled = false
             }
        } else {
            dayInt = daysOfPreviousMonth - number
            number -= 1
            cell.dayLabel.textColor = R.color.gray_light()
            cell.isUserInteractionEnabled = false
        }
        cell.setDayLabelText(with: dayInt)
        return cell
    }
}

extension CalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dayIndex = indexPath.row - (firstDayOfMonth - 2)
        delegate?.dayIsSelected(with: dayIndex)
        selectedDay = dayIndex
        collectionView.reloadData()
        
    }
}

private extension CalendarView {
    func makeWeekdaySymbolLabel(weekdayString: String?) -> UILabel {
        let label = UILabel()
        label.text = weekdayString
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = R.color.dark()
        return label
    }
}
