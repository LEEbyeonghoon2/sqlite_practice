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
        
        if fileMGR.fileExists(atPath: DB_path) == false { // DB_Path 에 파일이 있는지 없는지 체크
            //만약에 없으면
            //앱 번들에 있는 db_pracitce 파일을 가져와 DB_Path에 붙여넣어줍니다.
            let dbSource = Bundle.main.path(forResource: "db_practice", ofType: "sqlite")
            try! fileMGR.copyItem(atPath: dbSource!, toPath: DB_path)
        }
        
        let SQL = "create table if not EXISTS HoonIOS (num INTEGER, age INTEGER)"
        
        if sqlite3_open(DB_path, &db_sqlite3) == SQLITE_OK {
            if sqlite3_prepare(db_sqlite3, SQL, -1, &db_sqlite_stmt, nil) == SQLITE_OK {
                if sqlite3_step(db_sqlite_stmt) == SQLITE_DONE {
                    NSLog("DB Succeess")
                }
                sqlite3_finalize(db_sqlite_stmt)
            } else {
                NSLog("DB Statement Error")
            }
            sqlite3_close(db_sqlite3)
        } else {
            NSLog("DB Connect Error")
            return
        }
        
    }
}
