//
//  PrincipalViewController.swift
//  DisneyAnimation
//
//  Created by Juan vasquez on 02-05-22.
//

import UIKit

final class PrincipalViewController: UITableViewController {

    let themes: [Theme] = [
        Theme(name: "Doctor Strange", withCastle: false),
        Theme(name: "Ethernals", withCastle: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = "Disney animations"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let theme = themes[indexPath.row]
        cell.textLabel?.text = theme.name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
