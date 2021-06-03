//
//  makeDataBase.swift
//  sqlite_practice
//
//  Created by 이병훈 on 2021/06/02.
//

import UIKit

class makeDataBaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var db_sqlite3: OpaquePointer? = nil
        var db_sqlite_stmt: OpaquePointer? = nil
        
        let fileMGR = FileManager()
        let DOC_path = fileMGR.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let DB_path = DOC_path.appendingPathComponent("db_pracitce").path
        
        let SQL = "create table if not EXISTS HoonIOS (num INTEGER, age INTEGER)"
        
        sqlite3_open(DB_path, &db_sqlite3)
        sqlite3_prepare(db_sqlite3, SQL, -1, &db_sqlite_stmt, nil)
        sqlite3_step(db_sqlite_stmt)
        sqlite3_finalize(db_sqlite_stmt)
        sqlite3_close(db_sqlite3)
        
    }
}
