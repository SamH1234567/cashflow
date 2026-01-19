INSERT INTO users (email, name, password_hash) VALUES
    ('alex@example.com', 'alex', 'hash_alex'),
    ('sam@example.com', 'sam', 'hash_sam');

INSERT INTO financial_statements (
    user_id,
    institution_name,
    account_name,
    statement_period
) VALUES
      (1, 'Chase', 'Checking', '2025-01'),
      (1, 'Chase', 'Checking', '2025-02'),
      (1, 'Ally', 'Savings',  '2025-02'),
      (2, 'Bank of America', 'Checking', '2025-01');

INSERT INTO statement_files (
    statement_id,
    original_filename,
    storage_path,
    file_size_bytes
) VALUES
      (1, 'chase_jan.csv',  's3://statements/1/chase_jan.csv',  48291),
      (2, 'chase_feb.csv',  's3://statements/1/chase_feb.csv',  51234),
      (3, 'ally_feb.csv',   's3://statements/1/ally_feb.csv',   22104),
      (4, 'boa_jan.csv',    's3://statements/2/boa_jan.csv',    39811);

INSERT INTO transactions (
    statement_id,
    transaction_date,
    description,
    amount,
    currency,
    category,
    source_hash
) VALUES
-- Alex – Chase Jan
(1, '2025-01-03', 'Grocery Store',      -82.45, 'USD', 'Food',  'h1'),
(1, '2025-01-05', 'Electric Bill',     -120.00, 'USD', 'Utilities', 'h2'),
(1, '2025-01-10', 'Salary',            3200.00, 'USD', 'Income', 'h3'),

-- Alex – Chase Feb
(2, '2025-02-02', 'Coffee Shop',         -6.75, 'USD', 'Food', 'h4'),
(2, '2025-02-08', 'Internet Bill',      -75.00, 'USD', 'Utilities', 'h5'),
(2, '2025-02-15', 'Salary',            3200.00, 'USD', 'Income', 'h6'),

-- Alex – Ally Savings
(3, '2025-02-01', 'Interest Payment',     14.23, 'USD', 'Interest', 'h7'),
(3, '2025-02-20', 'Transfer from Chase', 500.00, 'USD', 'Transfer', 'h8'),

-- Sam – BoA
(4, '2025-01-07', 'Restaurant',         -54.60, 'USD', 'Food', 'h9'),
(4, '2025-01-12', 'Gas Station',         -41.20, 'USD', 'Transport', 'h10'),
(4, '2025-01-15', 'Salary',             2800.00, 'USD', 'Income', 'h11');
