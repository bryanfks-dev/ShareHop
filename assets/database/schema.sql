CREATE TABLE IF NOT EXISTS connections (
    id TEXT PRIMARY KEY,
    protocol TEXT NOT NULL CHECK (protocol IN ('ftp', 'sftp', 'ftps', 'webdav', 'smb', 'nfs')),
    display_name TEXT NOT NULL,
    remote_address TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'offline' CHECK (status IN ('online', 'offline')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS file_transfers (
    id TEXT PRIMARY KEY,
    file_size INTEGER NOT NULL,
    file_mime_type TEXT NOT NULL,
    source_name TEXT NOT NULL,
    destination_name TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'in_progress', 'completed', 'failed')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
