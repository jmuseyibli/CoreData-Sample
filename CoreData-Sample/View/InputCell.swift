//
//  InputCell.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/13/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit
import PureLayout

class InputCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var selectOptions = [Pair<String, String>]()
    
    var customField: CustomField? {
        didSet {
            guard let fieldType = customField?.type else { return }
            switch fieldType {
            case CFOptions.TextField.rawValue:
                textField.placeholder = customField?.label
                textField.isHidden = false
                selectedValue = textField.text
            case CFOptions.FloatPoint.rawValue:
                textField.placeholder = customField?.label
                textField.isHidden = false
                textField.keyboardType = .decimalPad
                selectedValue = textField.text
            case CFOptions.Numeric.rawValue:
                textField.placeholder = customField?.label
                textField.isHidden = false
                textField.keyboardType = .numberPad
                selectedValue = textField.text
            case CFOptions.Date.rawValue:
                datePickerLabel.text = customField?.label
                datePickerStackView.isHidden = false
                selectedValue = datePicker.date.stringInDesiredFormat()
            case CFOptions.SelectBox.rawValue:
                pickerStackView.isHidden = false
                pickerLabel.text = customField?.label
                selectOptions = customField?.options ?? []
                selectedValue = selectOptions.first?.k
            default:
                ()
            }
        }
    }
    
    var selectedValue: String?
    
    let textField: IndentedTextField = {
        let textField = IndentedTextField()
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.isHidden = true
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let picker: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let datePickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Date Picker"
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let pickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Picker"
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var datePickerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isHidden = true
        stackView.axis = .vertical
        stackView.addArrangedSubview(datePickerLabel)
        stackView.addArrangedSubview(datePicker)
        return stackView
    }()
    
    lazy var pickerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isHidden = true
        stackView.axis = .vertical
        stackView.addArrangedSubview(pickerLabel)
        stackView.addArrangedSubview(picker)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(textField)
        textField.autoPinEdgesToSuperviewEdges(with: .init(top: 0, left: 16, bottom: 8, right: 16))
        textField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        
        addSubview(datePickerStackView)
        datePickerStackView.autoPinEdgesToSuperviewEdges(with: .init(top: 12, left: 16, bottom: 12, right: 16))
        datePicker.addTarget(self, action: #selector(handleDatePickerChange), for: .valueChanged)
        
        addSubview(pickerStackView)
        pickerStackView.autoPinEdgesToSuperviewEdges(with: .init(top: 0, left: 16, bottom: 0, right: 16))
        picker.dataSource = self
        picker.delegate = self
    }
    
    @objc func handleTextFieldChange(textField: UITextField) {
        selectedValue = textField.text
    }
    
    @objc func handleDatePickerChange(picker: UIDatePicker) {
        selectedValue = picker.date.stringInDesiredFormat()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = selectOptions[row].k
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let titleLabel = view as? UILabel ?? UILabel()
        titleLabel.text = selectOptions[row].v
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        return titleLabel
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectOptions.count
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

