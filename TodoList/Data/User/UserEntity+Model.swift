//
//  UserEntity+Model.swift
//  TodoList
//
//  Copyright © 2024 Q42. All rights reserved.
//

import Foundation

extension UserModel {
    init(userEntity: UserEntity) {
        self.email = userEntity.email
    }
}
