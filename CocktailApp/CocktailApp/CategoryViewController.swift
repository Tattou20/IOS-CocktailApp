//
//  CategoryViewController.swift
//  CocktailApp
//
//  Created by user238581 on 4/19/24.
//

import UIKit
import SafariServices


class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CategoryTableViewCell.self,
                       forCellReuseIdentifier: CategoryTableViewCell.identifier)
        return table
    }()
    
    private var drinks = [Category]()
    private var viewModels = [CategoryTableViewCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Drinks"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        fetchNonAlcoholic()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchNonAlcoholic() {
        APICallerCategory.shared.getCategory { [weak self] result in
            switch result {
            case .success(let drinks):
                self?.drinks = drinks
                self?.viewModels = drinks.compactMap({
                    CategoryTableViewCellViewModel(title: $0.strDrink, subtitle: $0.idDrink, imageURL: URL(string: $0.strDrinkThumb ?? ""))
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }    }
    
// Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}










