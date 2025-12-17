//
//  ViewController.swift
//  PQMD
//
//  Created by izven on 2025/12/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let pages: [(title: String, viewController: UIViewController.Type)] = [
        ("Demo1", Demo1ViewController.self),
        ("Demo2", Demo2ViewController.self),
        ("Demo3", Demo3ViewController.self)
    ]

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchHomeData() // Call the data fetching function
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Home"

        view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func fetchHomeData() {
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func fetchSleepData(){
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pages[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewControllerType = pages[indexPath.row].viewController
        let vc = viewControllerType.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

