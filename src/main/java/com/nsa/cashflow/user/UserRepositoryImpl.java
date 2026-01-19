package com.nsa.cashflow.user;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public class UserRepositoryImpl implements UserRepository {
    private final JdbcTemplate jdbc;
    public UserRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbc = jdbcTemplate;
    }

    private static final RowMapper<User> USER_ROW_MAPPER =
            (rs, rowNum) -> new User(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("password_hash")
            );


    @Override
    public Optional<User> findByEmail(String email) {
        return jdbc.query(
                "SELECT * FROM users WHERE email = ?",
                USER_ROW_MAPPER,
                email
        ).stream().findFirst();
    }
    @Override
    public Optional<User> findById(Integer userId) {
        return jdbc.query(
                "SELECT * FROM users WHERE user_id = ?",
                USER_ROW_MAPPER,
                userId
        ).stream().findFirst();
    }


    @Override
    public Integer findUserIdByEmail(String email) {
        String sql = "select user_id from users where email = ?";

        return jdbc.queryForObject(sql, Integer.class, email);
    }
}
