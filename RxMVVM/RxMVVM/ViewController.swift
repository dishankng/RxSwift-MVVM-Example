//
//  ViewController.swift
//  RxMVVM
//
//  Created by Dishank Narang on 5/18/18.
//  Copyright © 2018 B0200969. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import UIKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    let disposeBag = DisposeBag()
    
    let viewModel = ViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refreshData()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(reloadData))
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<Section, User>>(
            configureCell: { (_, tv, indexPath, element) in
                if indexPath.section == 0 {
                    if let cell = tv.dequeueReusableCell(withIdentifier: "BlueCell") as? BlueCell {
                         cell.textLabel?.text = "\(element.firstName!) @ row \(indexPath.row)"
                        return cell
                    }
                } else if indexPath.section == 1 {
                    if let cell = tv.dequeueReusableCell(withIdentifier: "GreenCell") as? GreenCell {
                        cell.textLabel?.text = "\(element.firstName!) @ row \(indexPath.row)"
                        return cell
                    }
                }
                else {
                    if let cell = tv.dequeueReusableCell(withIdentifier: "RedCell") as? RedCell {
                        cell.textLabel?.text = "\(element.firstName!) @ row \(indexPath.row)"
                        return cell
                    }
                }
                return UITableViewCell()
        },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model.title
        })
        
        view.addSubview(tableView)
        
        tableView.register(RedCell.self, forCellReuseIdentifier: "RedCell")
        tableView.register(BlueCell.self, forCellReuseIdentifier: "BlueCell")
        tableView.register(GreenCell.self, forCellReuseIdentifier: "GreenCell")
        
        viewModel.items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath.section, indexPath.row)
            }
            .subscribe(onNext: { pair in
                print("Tapped Section:\(pair.0) @ Row:\(pair.1)")
            })
            .disposed(by: disposeBag)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
    
    @objc func reloadData() {
        viewModel.refreshData()
    }
    
}

class RedCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BlueCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GreenCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
