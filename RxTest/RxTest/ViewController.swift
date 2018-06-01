//
//  ViewController.swift
//  RxTest
//
//  Created by Dishank Narang on 5/17/18.
//  Copyright © 2018 B0200969. All rights reserved.
//
import RxSwift
import RxCocoa
import UIKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    let disposeBag = DisposeBag()
    
    let viewModel = ViewModel()
    
    
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>(
        configureCell: { (_, tv, indexPath, element) in
            if indexPath.row == 0 {
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(indexPath.row)"
                return cell
            }
            
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(indexPath.row)"
            return cell
            
    },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
    }
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        viewModel.observableSections.asObservable()
            .bind(to: tableView.rx.items(dataSource: <#T##RxTableViewDataSourceType & UITableViewDataSource#>))
            
            .disposed(by: disposeBag)
        
        
        
    }
}

