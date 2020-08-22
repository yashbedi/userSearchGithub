//
//  GitUserCell.swift
//  GitUserSearch
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2018 Yash Bedi. All rights reserved.
//

import UIKit
import SnapKit

final class GitUserCell: UITableViewCell {
    
    private let containerView: UIView = {
        let cView = UIView()
        cView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        cView.layer.cornerRadius = 12
        cView.layer.masksToBounds = true
        return cView
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: H_FONT, size: 20)
        label.textColor = #colorLiteral(red: 0.1137254902, green: 0.1843137255, blue: 0.3294117647, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let rightArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"rightArrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInIt()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInIt()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = nil
    }
}


private extension GitUserCell {
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
        containerView.addSubview(profileImage)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(rightArrow)
    }
    func setUpConstraints(){
        containerView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(5)
            maker.bottom.equalToSuperview().offset(-5)
            maker.leading.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-10)
        }
        profileImage.snp.makeConstraints { (maker) in
            maker.height.equalTo(44)
            maker.width.equalTo(44)
            maker.leading.equalTo(containerView).offset(20)
            maker.centerY.equalTo(containerView)
        }
        userNameLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(profileImage.snp.trailing).offset(10)
            maker.centerY.equalTo(containerView)
            maker.trailing.equalTo(containerView).offset(-65)
        }
        rightArrow.snp.makeConstraints { (maker) in
            maker.height.equalTo(25)
            maker.width.equalTo(40)
            maker.trailing.equalTo(containerView).offset(-20)
            maker.centerY.equalTo(containerView)
        }
    }
}

extension GitUserCell {
    func setData(user: GitUser, viewFollowers: Bool = false){
        userNameLabel.text = user.login
        rightArrow.isHidden = viewFollowers
        guard
            let avatarURL = user.avatarURL,
            let url = URL(string: avatarURL)
            else { return }
        
        let localObject = SearchUserPresenter(SearchUsersService())
        localObject.getImage(from: url) { (imageData) in
            DispatchQueue.main.async {
                self.profileImage.image = UIImage(data: imageData)
            }
        }
    }
}
