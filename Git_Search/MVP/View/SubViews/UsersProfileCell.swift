//
//  UsersProfileCell.swift
//  Git_Search
//
//  Created by Yash Bedi on 22/08/20.
//  Copyright © 2020 Yash Bedi LLC. All rights reserved.
//

import UIKit
import SnapKit

protocol UserProfileDelegate : class {
    func showFollowersFor(_ userName: String)
    func showFollowingFor(_ userName: String)
}

final class UsersProfileCell: UITableViewCell {

    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 85
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: H_FONT, size: 25)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: H_FONT, size: 17)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: H_FONT, size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector(followersTapped(_:)))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.init(name: H_FONT, size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector(followingTapped(_:)))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 0
        return stack
    }()
    private var userName: String = ""
    
    weak var delegate: UserProfileDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInIt()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInIt()
    }
}

private extension UsersProfileCell {
    func commonInIt(){
        setUI()
        setHierarchy()
        setUpConstraints()
    }
    func setUI(){
        isUserInteractionEnabled = true
        selectionStyle = .none
        contentView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.8)
    }
    func setHierarchy(){
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(followersLabel)
        stackView.addArrangedSubview(followingLabel)
    }
    
    func setUpConstraints(){
        profileImage.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(20)
            maker.height.equalTo(170)
            maker.width.equalTo(170)
            maker.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(profileImage.snp.bottom).offset(10)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
        }
        locationLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(nameLabel.snp.bottom).offset(10)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
        }
        stackView.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview()
            maker.height.equalTo(45)
            maker.bottom.equalToSuperview()
        }
    }
}

private extension UsersProfileCell {
    @objc func followersTapped(_ sender: UITapGestureRecognizer) {
        delegate?.showFollowersFor(userName)
    }
    @objc func followingTapped(_ sender: UITapGestureRecognizer) {
        delegate?.showFollowingFor(userName)
    }
}

extension UsersProfileCell {
    func setData(model: UserDetailsModel){
        userName = model.login ?? ""
        if model.name == nil || model.name == "" {
            nameLabel.text = model.login ?? ""
        }else{
            nameLabel.text = model.name ?? ""
        }
        locationLabel.text = model.location ?? ""
        followersLabel.text = "\(model.followers ?? 0)\nFollowers"
        followingLabel.text = "\(model.following ?? 0)\nFollowing"
        
        guard
            let avatarURL = model.avatarURL,
            let url = URL(string: avatarURL)
            else { return }
        
        let localObject = UserDetailsPresenter(DetailUserService())
        localObject.getImage(from: url) { (imageData) in
            DispatchQueue.main.async {
                self.profileImage.image = UIImage(data: imageData)
            }
        }
    }
}
