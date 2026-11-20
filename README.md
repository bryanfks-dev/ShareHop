<div align="center">

# ShareHop

**Transfer files seamlessly across your local network and remote servers.**

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/State_Management-Riverpod_3-00D2B4?style=for-the-badge)](https://riverpod.dev)
[![UI Library](https://img.shields.io/badge/UI-Forui-6C5CE7?style=for-the-badge)](https://forui.dev)
[![Security](https://img.shields.io/badge/Security-AES--GCM%20%7C%20Biometrics-red?style=for-the-badge)](#security--privacy)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20macOS%20%7C%20Linux%20%7C%20Windows-blue?style=for-the-badge)](#platform-support)

<p align="center">
  <a href="#key-features">Key Features</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#supported-protocols">Supported Protocols</a> •
  <a href="#quick-start">Quick Start</a> •
  <a href="#project-structure">Project Structure</a> •
  <a href="#security--privacy">Security</a> •
  <a href="#development-commands">Development</a>
</p>

</div>

---

## 📖 Overview

**ShareHop** is a modern, cross-platform file transfer client designed for speed, privacy, and simplicity. Whether you need to push documents to a WebDAV server, sync media with your home NAS over SMB, or transfer files directly from your mobile device's system share sheet, ShareHop streamlines the entire workflow with a unified interface and hardware-accelerated encryption.

Built using **Flutter 3** and modern design principles, ShareHop adheres to a strict **Clean Layered Architecture** with Riverpod 3, SQLite local persistence, and client-side credential encryption.

---

## ✨ Key Features

### 🔌 Multi-Protocol Storage Support

Connect to a wide array of network storage systems:

- **WebDAV / WebDAVS**: Full Nextcloud, ownCloud, Apache, and standard WebDAV server compatibility with custom port and self-signed SSL/TLS support.
- **SMB / CIFS**: Native Windows share and Samba NAS integration.
- **SFTP / SSH**: Secure shell file transfer.
- **FTP / FTPS**: Traditional and SSL/TLS-secured FTP servers.
- **NFS**: Network File System for Linux/UNIX environments.

### 📲 Native OS Share Sheet Integration (Android)

- **Instant Share Target**: ShareHop appears directly in the system Share menu (`ACTION_SEND` and `ACTION_SEND_MULTIPLE`).
- **Dedicated Lightweight Overlay (`shareMain`)**: Launches a native transparent overlay running a dedicated Flutter entry point without booting the full app shell.
- **Quick Upload Flow**: Pick your destination server (pinned or saved), preserve filenames, and kick off background transfers with one tap.

### 🧭 Dual-Pane Landscape Workspace Handoff

- **Split-Screen Productivity**: Rotate your device into landscape mode to enter the dual-pane workspace.
- **Side-by-Side File Explorer**: Device storage on the left, remote server file tree on the right.
- **Seamless Directional Transfers**: Move files in either direction with minimal gestures while retaining your active directory context.

### ⚡ Smart Quick Connect

- Intelligent connection string parser supporting standard URIs:
  ```
  webdav://username:password@nas.local:8080/remote.php/webdav
  smb://storage.local/shared
  sftp://admin@192.168.1.50:22/backups
  ```
- Automatically resolves hostnames, credentials, ports, and root paths with automatic validation.

### 📌 Pinned Connections & Server Management

- Organize connections into **Pinned** (favorites) and **Other Connections**.
- Manage, reorder, unpin, or delete connections with ease.
- Detailed connection views showing server health status, storage usage breakdown, and recent files/folders.

### 📊 Real-Time Transfer Activity Hub

- Live progress tracking for **Active**, **Queued**, and **Completed** transfers.
- Queue management controls: pause, resume, cancel, or retry failed items.
- Granular transfer preferences:
  - **Wi-Fi Only Mode**: Protect cellular data limits.
  - **Background Transfers**: Keep long-running transfers alive in the background.
  - **Simultaneous Transfer Limits**: Regulate concurrent transfer streams (1–10 threads).
  - **Conflict Resolution**: Configurable policies (Ask Every Time, Overwrite, Rename, Skip).

### 🔒 Security & Privacy First

- **Client-Side Secret Cipher**: Connection passwords and keys are encrypted at rest using derived symmetric ciphers (AES-GCM with PBKDF2 key derivation, random salts, and nonces).
- **Biometric App Lock**: Secure app access using device fingerprint or facial recognition (`local_auth`).
- **Zero Cloud Tracking**: All connection configurations, encryption keys, and transfer logs remain strictly on your local device.

### 🎨 Modern UI & Theming

- Built on [Forui](https://forui.dev/) and Material Design tokens.
- Dynamic theme switching: **Light**, **Dark**, and **System Default**.
- Fluid transitions and clean typography.

---

## 🏛️ Architecture

ShareHop is built following **Clean Layered Architecture** to guarantee loose coupling, maintainability, and thorough testability:

```mermaid
flowchart TD
    subgraph Presentation ["Presentation Layer (lib/presentation)"]
        UI["Widgets / Screens / Overlays"]
        Controllers["Riverpod Controllers / Notifiers"]
        ViewModels["View Models"]
    end

    subgraph Core ["Core / Domain Layer (lib/core)"]
        UseCases["Use Cases (call())"]
        DomainModels["Domain Models (Freezed)"]
        ValueObjects["Value Objects"]
        GatewaysPort["Gateways (Interfaces)"]
        RepoPort["Repositories (Interfaces)"]
        SecurityPort["Cipher & Secure Random"]
    end

    subgraph Infrastructure ["Infrastructure Layer (lib/infrastructures)"]
        RepoImpl["Repository Implementations"]
        GatewayImpl["Gateway Implementations (WebDAV, SMB, Biometrics)"]
        DBManager["DatabaseManager (sqflite / SQLite)"]
        CipherImpl["DerivedKeySecretCipher (cryptography)"]
    end

    subgraph Data ["Data Layer (lib/data)"]
        DTOs["DTOs (Freezed / JSON)"]
        Mappers["Mappers (DTO <-> Domain)"]
    end

    UI --> Controllers
    Controllers --> UseCases
    UseCases --> RepoPort
    UseCases --> GatewaysPort
    RepoImpl -.->|implements| RepoPort
    GatewayImpl -.->|implements| GatewaysPort
    RepoImpl --> DBManager
    RepoImpl --> Mappers
    Mappers --> DTOs
```

### Layer Responsibilities

- **Presentation (`lib/presentation/`)**:
  - Flutter UI widgets, screens, and dialogs.
  - Riverpod controllers handling user interaction and state orchestration.
  - Android native share overlay (`ShareOverlay`).
- **Core (`lib/core/`)**:
  - Pure business logic encapsulated in single-purpose Use Cases (`call()` method).
  - Domain models defined with Freezed.
  - Abstract repository and gateway interfaces.
- **Infrastructures (`lib/infrastructures/`)**:
  - Concrete implementations of repositories and external services.
  - Local database access via `sqflite` with SQLite schema migrations.
  - WebDAV client pool manager and session gateway.
  - Cryptographic key derivation and AES-GCM cipher implementations.
- **Data (`lib/data/`)**:
  - DTOs and Data Mappers bridging database records and domain entities.
- **Dependency Injection (`lib/di/`)**:
  - Riverpod code-generated providers linking ports to adapters.

---

## 🌐 Supported Protocols

| Protocol                        |   Status    | Default Port | Sample Connection URI                           |
| :------------------------------ | :---------: | :----------: | :---------------------------------------------- |
| **WebDAV / WebDAVS**            |  Supported  | `80` / `443` | `webdavs://cloud.example.com/remote.php/webdav` |
| **SMB (Samba / Windows Share)** |  Supported  |    `445`     | `smb://192.168.1.100/shared_folder`             |
| **SFTP (SSH)**                  | In Progress |     `22`     | `sftp://user@host.example.com:22/home/user`     |
| **FTP / FTPS**                  | In Progress | `21` / `990` | `ftps://ftp.example.com:990/uploads`            |
| **NFS**                         |   Planned   |    `2049`    | `nfs://nfs.local/mnt/exports`                   |

---

## 📂 Project Structure

```
sharehop/
├── android/                     # Android native project & ShareActivity intent
│   └── app/src/main/kotlin/.../ShareActivity.kt
├── assets/                      # Static assets
│   ├── database/
│   │   ├── migrations/          # SQLite incremental migration scripts
│   │   └── schema.sql           # Canonical database DDL schema
│   └── images/                  # SVGs and UI illustrations
├── lib/
│   ├── core/                    # Domain Layer
│   │   ├── enums/               # Domain enumerations
│   │   ├── errors/              # Domain failure definitions
│   │   ├── gateways/            # Abstract gateway contracts
│   │   ├── models/              # Immutable domain entities (Freezed)
│   │   ├── repositories/        # Repository interfaces
│   │   ├── security/            # Cipher & encryption interfaces
│   │   └── use_cases/           # Encapsulated business operations
│   ├── data/                    # Data Layer
│   │   ├── dto/                 # Data transfer objects
│   │   └── mapper/              # Entity <-> DTO converters
│   ├── di/                      # Riverpod Dependency Injection providers
│   ├── infrastructures/         # Infrastructure & Adapters Layer
│   │   ├── database/            # SQLite manager & schema orchestrator
│   │   ├── gateways/            # Platform & storage gateways (WebDAV, SMB)
│   │   ├── repositories/        # Repository implementations
│   │   ├── security/            # AES-GCM / PBKDF2 implementations
│   │   └── web_dav/             # WebDAV client pool & session management
│   ├── presentation/            # UI Layer
│   │   ├── controllers/         # Riverpod State Notifiers
│   │   ├── enums/               # UI-specific enums
│   │   ├── overlays/            # Android Share Intent Overlay
│   │   ├── screens/             # App screens (Home, Activities, Settings, etc.)
│   │   ├── theme/               # Design tokens, Forui theme styling
│   │   ├── utils/               # Formatting and connection parsing utilities
│   │   └── widgets/             # Reusable UI components
│   └── main.dart                # Application entry points (main & shareMain)
└── test/                        # Comprehensive unit and widget test suite
```

---

## 🚀 Quick Start

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`^3.24.0` or later recommended)
- [Dart SDK](https://dart.dev/get-dart) (`^3.13.4`)
- Android Studio / Xcode (for mobile deployments)

### 1. Clone the Repository

```bash
git clone https://github.com/bryanfks-dev/sharehop.git
cd sharehop
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Code

ShareHop uses `build_runner` for Riverpod and Freezed generation:

```bash
dart run build_runner build -d
```

### 4. Run the Application

Launch on your connected device or emulator:

```bash
# Debug mode
flutter run

# Android target
flutter run -d android

# Desktop (macOS / Linux / Windows)
flutter run -d macos
```

---

## 🛠️ Development & Tooling

| Task                             | Command                               |
| :------------------------------- | :------------------------------------ |
| **Run All Tests**                | `flutter test`                        |
| **Run Analysis / Linter**        | `flutter analyze`                     |
| **Code Generation (One-time)**   | `dart run build_runner build -d`      |
| **Code Generation (Watch Mode)** | `dart run build_runner watch -d`      |
| **Forui UI CLI**                 | `dart run forui_cli`                  |
| **Run Single Test File**         | `flutter test test/path/to/test.dart` |

---

## 🔐 Security & Privacy

1. **Credential Encryption**:
   - Connection credentials (passwords, tokens) are never stored as plain text.
   - When saved, credentials are encrypted using derived keys produced by `cryptography` (AES-GCM algorithm).
   - Stored in the SQLite database under `encrypted_values` alongside cryptographic nonces and authentication tags.

2. **Biometric Guard**:
   - When enabled under **Settings > Security**, app access requires biometric authentication (Fingerprint, Touch ID, Face ID, or device passcode) before displaying connections or workspaces.

3. **Secure Communications**:
   - TLS/SSL is verified by default.
   - An explicit per-connection toggle allows connecting to internal servers with self-signed certificates when configured by the user.

---

## 📱 Platform Support

| Platform    | Support Status | Notes                                                              |
| :---------- | :------------: | :----------------------------------------------------------------- |
| **Android** |  🟢 Complete   | Full support including Native Share Sheet Target (`ShareActivity`) |
| **iOS**     |  🟡 Supported  | Standard app functionality; Share Extension in roadmap             |
| **macOS**   |  🟡 Supported  | Desktop workspace and dual-pane layout                             |
| **Linux**   |  🟡 Supported  | Desktop workspace                                                  |
| **Windows** |  🟡 Supported  | Desktop workspace                                                  |

---

## 📄 License

This project is open-source software licensed under the [MIT License](LICENSE).
