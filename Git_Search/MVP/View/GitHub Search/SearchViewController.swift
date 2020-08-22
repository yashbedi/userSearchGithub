//
//  SearchViewController.swift
//  GitUserSearch
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2018 Yash Bedi. All rights reserved.
//

import UIKit

final class SearchViewController: BaseViewController {

    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = UISearchBar.Style.prominent
        search.placeholder = " Enter username.."
        search.isTranslucent = false
        search.backgroundImage = UIImage()
        search.delegate = self
        return search
    }()
    
    private lazy var searchTableView: UITableView = {
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
    
    private var presenter: SearchUserPresenter = SearchUserPresenter(SearchUsersService())
    private var arrayOfUsers = Array<GitUser>()
    private var pageNum: Int = 1
    private var searchStr: String = ""
    
    override func viewDidLoad(){
        super.viewDidLoad()
        presenter.attach(self)
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.title = kGitUserSearch
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        parent?.title = " "
    }
    
    override func dissmissKeyBoardAndResetData() {
        arrayOfUsers.removeAll()
        searchTableView.reloadData()
        searchBar.text = ""
        pageNum = 1
    }
}

private extension SearchViewController {
    func setUI(){
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(50)
        }
        view.addSubview(searchTableView)
        searchTableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(searchBar.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
}


extension SearchViewController : SearchUsersView {
    func set(users: [GitUser]) {
        if pageNum > 1 {
            arrayOfUsers += users
        }else{
            arrayOfUsers.removeAll()
            arrayOfUsers = users
        }
        DispatchQueue.main.async {
            self.searchTableView.reloadWithAnimation()
        }
    }
    func stopLoading() {
        super.hideHUD(forView: self.view)
    }
    func startLoading() {
        super.showHUD(inView: self.view)
    }
    func setEmptyUsers() {
        arrayOfUsers.removeAll()
        searchTableView.reloadData()
        super.theBroadCaster(searchTableView,
                           message: kUserNotFound)
    }
}

extension SearchViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard
            let searchText = searchBar.text,
            searchText.count < 1
            else {return}
        self.dissmissKeyBoardAndResetData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard
            let searchQuery = searchBar.text,
            searchQuery.count > 0
            else{return}
        pageNum = 1
        callApi(with: searchQuery)
    }
    private func callApi(with searchQuery: String){
        if PhoneConnection.isRechable() {
            presenter.getUsersFor(searchQuery, pageNum: pageNum)
        }else{
            self.dissmissKeyBoardAndResetData()
            super.showBanner(REACHABILITY.NETWORK_UNAVAILABLE.rawValue)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        super.dissmissKeyBoardAndResetData()
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if arrayOfUsers.count != 0 {
            super.theBroadCaster(tableView, message: "")
            return 1
        }else {
            super.theBroadCaster(tableView, message: NO_USER_FOUND)
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return arrayOfUsers.count }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { return POWERED_BY_GITHUB }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 70 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kGitUserCell, for: indexPath) as! GitUserCell
        cell.setData(user: arrayOfUsers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if PhoneConnection.isRechable() {
            let user = arrayOfUsers[indexPath.row]
            let detailVC = DetailViewController()
            detailVC.gitUserName = user.login
            navigationController?.pushViewController(detailVC, animated: true)
        }else{
            super.showBanner(REACHABILITY.NETWORK_UNAVAILABLE.rawValue)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endScrolling: CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height + 1
        if (endScrolling >= scrollView.contentSize.height) && arrayOfUsers.count > 0 {
            pageNum += 1
            callApi(with: searchBar.text ?? "")
        }
    }
}
