//
//  CachedCell.swift
//  GitUserSearch
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2018 Yash Bedi. All rights reserved.
//

import UIKit

final class CachedCell: UITableViewCell {
    
    private let containerView: UIView = {
        let cView = UIView()
        cView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        cView.layer.cornerRadius = 12
        cView.layer.masksToBounds = true
        return cView
    }()
    
    private let rightArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"rightArrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: H_FONT, size: 15)
        label.textColor = #colorLiteral(red: 0.1729411185, green: 0.2858031988, blue: 0.5201928616, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let locationNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: H_FONT, size: 10)
        label.textColor = #colorLiteral(red: 0.1137254902, green: 0.1843137255, blue: 0.3294117647, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
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
private extension CachedCell {
    func commonInIt(){
        setUI()
        setHierarchy()
        setUpConstraints()
    }
    func setUI(){
        selectionStyle = .none
    }
    func setHierarchy(){
        contentView.addSubview(containerView)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(locationNameLabel)
        containerView.addSubview(rightArrow)
    }
    func setUpConstraints(){
        containerView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(2.5)
            maker.bottom.equalToSuperview().offset(-2.5)
            maker.leading.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-10)
        }
        userNameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(containerView).offset(5)
            maker.leading.equalTo(containerView).offset(15)
            maker.trailing.equalTo(containerView).offset(20)
        }
        locationNameLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(containerView).offset(-5)
            maker.leading.equalTo(containerView).offset(15)
            maker.trailing.equalTo(containerView).offset(40)
        }
        rightArrow.snp.makeConstraints { (maker) in
            maker.height.equalTo(17)
            maker.width.equalTo(25)
            maker.trailing.equalTo(containerView).offset(-20)
            maker.centerY.equalTo(containerView)
        }
    }
}

extension CachedCell {
    func setData(name: String, location: String){
        locationNameLabel.text = location
        userNameLabel.text = name
    }
}
