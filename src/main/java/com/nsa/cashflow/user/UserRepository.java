package com.nsa.cashflow.user;

import java.util.Optional;

public interface UserRepository {
    Optional<User> findByEmail(String email);
    Optional<User> findById(Integer userId);
    Integer findUserIdByEmail(String email);
}
