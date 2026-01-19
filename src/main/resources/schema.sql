DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS statement_files;
DROP TABLE IF EXISTS financial_statements;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    email           VARCHAR(255) NOT NULL,
    name            VARCHAR(255) NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;

CREATE UNIQUE INDEX idx_users_email
    ON users(email);

CREATE TABLE financial_statements (
    id                  BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id             BIGINT NOT NULL,
    institution_name    VARCHAR(255) NOT NULL,
    account_name        VARCHAR(255),
    statement_period    VARCHAR(7) NOT NULL,  -- 'YYYY-MM'
    created_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ) ENGINE=InnoDB;

CREATE INDEX idx_statements_user
    ON financial_statements(user_id);

CREATE INDEX idx_statements_period
    ON financial_statements(statement_period);

CREATE TABLE statement_files (
    id                  BIGINT AUTO_INCREMENT PRIMARY KEY,
    statement_id        BIGINT NOT NULL,
    original_filename   VARCHAR(255) NOT NULL,
    storage_path        VARCHAR(512) NOT NULL,
    file_size_bytes     BIGINT,
    uploaded_at         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (statement_id) REFERENCES financial_statements(id)
    ) ENGINE=InnoDB;

CREATE INDEX idx_files_statement
    ON statement_files(statement_id);

CREATE TABLE transactions (
    id                  BIGINT AUTO_INCREMENT PRIMARY KEY,
    statement_id        BIGINT NOT NULL,
    transaction_date    DATE NOT NULL,
    description         VARCHAR(1024) NOT NULL,
    amount              DECIMAL(14, 2) NOT NULL,
    currency            CHAR(3) NOT NULL DEFAULT 'USD',
    category            VARCHAR(255),
    source_hash         CHAR(64),
    created_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (statement_id) REFERENCES financial_statements(id)
    ) ENGINE=InnoDB;

CREATE INDEX idx_transactions_statement
    ON transactions(statement_id);

CREATE INDEX idx_transactions_date
    ON transactions(transaction_date);

CREATE INDEX idx_transactions_category
    ON transactions(category);

CREATE INDEX idx_transactions_source_hash
    ON transactions(source_hash);
