//
//  DetailVC.swift
//  GitUserSearch
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2018 Yash Bedi. All rights reserved.
//

import UIKit
import SnapKit

final class DetailViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UserDetailsCell.self,
                       forCellReuseIdentifier: kUserDetailsCell)
        table.register(UsersProfileCell.self,
                       forCellReuseIdentifier: kUsersProfileCell)
        table.keyboardDismissMode = .onDrag
        table.tableFooterView = UIView()
        table.contentInset = UIEdgeInsets.zero
        return table
    }()
    
    private var presenter: UserDetailsPresenter = UserDetailsPresenter(DetailUserService())
    private var dataModel: UserDetailsModel = UserDetailsModel()
    
    var gitUserName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(gitUserName ?? "")"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
        presenter.attach(self)
        presenter.getUserDetails(from: gitUserName ?? "")
    }
    
    private func saveUser(_ details: UserDetailsModel){
        if CoreDataUtility.shared.retireveUsers().count < 1 {
            CoreDataUtility.shared.save(user: details)
        }else{
            var isPresent = false
            for user in CoreDataUtility.shared.retireveUsers() {
                if user.login == self.dataModel.login { isPresent = true }
            }
            isPresent ? () : CoreDataUtility.shared.save(user: details)
        }
    }
}


extension DetailViewController: UserDetailsView {
    func startLoading() {
        super.showHUD(inView: self.view)
    }
    func stopLoading() {
        super.hideHUD(forView: self.view)
    }
    func setEmptyUser() {
        super.theBroadCaster(tableView, message: kUserNotFound)
    }
    func set(_ details: UserDetailsModel) {
        super.theBroadCaster(tableView, message: "")
        dataModel = details
        DispatchQueue.main.async {
            self.tableView.reloadWithAnimation()
        }
        saveUser(details)
    }
}


extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PhoneConnection.isRechable() {
            return 11
        }else{
            super.showBanner(REACHABILITY.NETWORK_UNAVAILABLE.rawValue)
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0  : return 350
        default : return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUsersProfileCell) as! UsersProfileCell
            cell.delegate = self
            cell.setData(model: dataModel)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailsCell) as! UserDetailsCell
            cell.set(title: "Company",
                     descp: dataModel.company ?? "")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailsCell) as! UserDetailsCell
            cell.set(title: "Email",
                     descp: "\(dataModel.email ?? "")")
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailsCell) as! UserDetailsCell
            cell.set(title: "Public repos",
                     descp: "\(dataModel.publicRepos ?? 0)")
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailsCell) as! UserDetailsCell
            cell.set(title: "Gist",
                     descp: "\(dataModel.publicGists ?? 0)")
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailsCell) as! UserDetailsCell
            cell.set(title: "Blog",
                     descp: "\(dataModel.blog ?? "")")
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailsCell) as! UserDetailsCell
            cell.set(title: "Bio",
                     descp: dataModel.bio ?? "")
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailsCell) as! UserDetailsCell
            cell.set(title: "Twitter",
                     descp: "\(dataModel.twitterUsername ?? "")")
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailsCell) as! UserDetailsCell
            cell.set(title: "Hireable",
                     descp: "\(dataModel.hireable ?? false)")
            return cell
        case 9:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailsCell) as! UserDetailsCell
            cell.set(title: "Member Since",
                     descp: super.getDate(dataModel.createdAt ?? "",
                                          isTimeRequried: false) )
            return cell
        case 10:
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserDetailsCell) as! UserDetailsCell
            cell.set(title: "Last Activity",
                     descp: super.getDate(dataModel.updatedAt ?? "",
                                          isTimeRequried: false))
            return cell
        default: return UITableViewCell()
        }
    }
}

extension DetailViewController : UserProfileDelegate {
    func showFollowersFor(_ userName: String) {
        if PhoneConnection.isRechable() {
            if (dataModel.followers ?? 0) > 0 {
                let vc = FollowDetailViewController()
                vc.gitUserName = userName
                vc.viewFollowers = true
                navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            self.dissmissKeyBoardAndResetData()
            super.showBanner(REACHABILITY.NETWORK_UNAVAILABLE.rawValue)
        }
    }
    func showFollowingFor(_ userName: String) {
        if PhoneConnection.isRechable() {
            if (dataModel.following ?? 0) > 0 {
                let vc = FollowDetailViewController()
                vc.gitUserName = userName
                vc.viewFollowers = false
                navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            self.dissmissKeyBoardAndResetData()
            super.showBanner(REACHABILITY.NETWORK_UNAVAILABLE.rawValue)
        }
    }
}
