//
//  MyCell.swift
//  AvitoTest
//
//  Created by Artem  on 07.09.2021.
//

import UIKit

final class MyCell: UICollectionViewCell {
    
    static let identifier = "MyCell"
    
    private lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        return label
    }()
    
    private lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        return label
    }()
    
    func setupData(company: String ,employees: Employee) {
        companyNameLabel.text = company
        nameLabel.text = employees.name
        phoneNumberLabel.text = employees.phoneNumber
        skillsLabel.text = employees.skills.joined(separator: ",")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        

        let views = [companyNameLabel ,nameLabel, phoneNumberLabel, skillsLabel]
        
        contentView.layer.cornerRadius = 22
        contentView.layer.masksToBounds = true
        layer.borderWidth = 0.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            skillsLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10),
            skillsLabel.leadingAnchor.constraint(equalTo: phoneNumberLabel.leadingAnchor),

        ])
    }
}
