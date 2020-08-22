//
//  FollowDetailViewController.swift
//  Git_Search
//
//  Created by Yash Bedi on 22/08/20.
//  Copyright © 2020 Yash Bedi LLC. All rights reserved.
//

import UIKit

final class FollowDetailViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(GitUserCell.self,
                                 forCellReuseIdentifier: kGitUserCell)
        table.keyboardDismissMode = .onDrag
        table.tableFooterView = UIView()
        table.contentInset = UIEdgeInsets.zero
        table.separatorStyle = .none
        return table
    }()
    private var arrayOfUsers = Array<GitUser>()
    private var presenter = FollowDetailPresenter(FollowDetailService())
    
    var gitUserName: String = ""
    var viewFollowers: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewFollowers ? "Followers" : " Following"
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
        presenter.attach(self)
        presenter.getUsersFor(gitUserName, viewFollowers: viewFollowers)
    }
}

extension FollowDetailViewController: FollowDetailView {
    func startLoading() {
        super.showHUD(inView: self.view)
    }
    func stopLoading() {
        super.hideHUD(forView: self.view)
    }
    func setEmptyUsers() {
        super.theBroadCaster(tableView, message: kUserNotFound)
    }
    func set(_ details: [GitUser]) {
        super.theBroadCaster(tableView, message: "")
        arrayOfUsers.removeAll()
        arrayOfUsers = details
        tableView.reloadWithAnimation()
    }
}

extension FollowDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return arrayOfUsers.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 70 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kGitUserCell, for: indexPath) as! GitUserCell
        cell.setData(user: arrayOfUsers[indexPath.row],viewFollowers: true)
        return cell
    }
}
