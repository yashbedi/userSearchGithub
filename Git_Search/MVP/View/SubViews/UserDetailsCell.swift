//
//  UserDetailsCell.swift
//  Git_Search
//
//  Created by Yash Bedi on 22/08/20.
//  Copyright © 2020 Yash Bedi LLC. All rights reserved.
//

import UIKit
import SnapKit

final class UserDetailsCell: UITableViewCell {
    
    private let _titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: H_FONT, size: 15)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let descpLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: H_FONT, size: 13)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInIt()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInIt()
    }
}

private extension UserDetailsCell {
    func commonInIt(){
        setUI()
        setHierarchy()
        setUpConstraints()
    }
    func setUI(){
        selectionStyle = .none
    }
    func setHierarchy(){
        contentView.addSubview(_titleLabel)
        contentView.addSubview(descpLabel)
    }
    func setUpConstraints(){
        
        _titleLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().offset(12)
        }
        descpLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().offset(-22)
            maker.leading.greaterThanOrEqualToSuperview().offset(120)
        }
    }
}

extension UserDetailsCell {
    func set(title: String, descp: String) {
        _titleLabel.text = title
        descpLabel.text = descp
    }
}
