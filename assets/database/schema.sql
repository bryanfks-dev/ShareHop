CREATE TABLE IF NOT EXISTS encrypted_values (
    id TEXT PRIMARY KEY,
    salt TEXT NOT NULL,
    nonce TEXT NOT NULL,
    cipher_text TEXT NOT NULL,
    mac TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS connections (
    id TEXT PRIMARY KEY,
    protocol TEXT NOT NULL CHECK (protocol IN ('ftp', 'sftp', 'ftps', 'webdav', 'smb', 'nfs')),
    display_name TEXT NOT NULL,
    remote_address TEXT NOT NULL,
    username TEXT NOT NULL,
    password_id TEXT NOT NULL,
    root_path TEXT NOT NULL,
    allow_self_signed_certificate INTEGER NOT NULL CHECK (allow_self_signed_certificate IN (0, 1)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (password_id) REFERENCES encrypted_values(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_connections_protocol ON connections (protocol);

CREATE TABLE IF NOT EXISTS pinned_connections (
    connection_id TEXT PRIMARY KEY NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (connection_id) REFERENCES connections(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS file_transfer_histories (
    id TEXT PRIMARY KEY,
    file_name TEXT NOT NULL,
    file_size INTEGER NOT NULL,
    file_mime_type TEXT NOT NULL,
    source_name TEXT NOT NULL,
    destination_name TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'in_progress', 'completed', 'failed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
