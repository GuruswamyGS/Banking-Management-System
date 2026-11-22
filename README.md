# Banking Management System (BMS)

> **A Dissertation / Project submitted in partial fulfilment of the requirements for the award of degree of MASTER OF COMPUTER APPLICATIONS of Visvesvaraya Technological University (VTU)**

* **Student:** G S GURUSWAMY  
* **Guide:** Mr. CHETAN KUMAR G S, Asst. Professor (Ad-hoc)  
* **Department:** Department of Master of Computer Applications  
* **Institution:** University B.D.T College of Engineering, Hadadi Road, Davanagere – 577004  
* **Academic Year:** 2026-27  

---

## 📌 1. Project Overview

The **Banking Management System (BMS)** is a web-based financial application developed according to the project synopsis specifications. It automates conventional manual record keeping, provides online banking operations for customers, and provides an administrative console for bank managers.

### Core Architecture:
```
[Client / Browser]
       │  (HTTP / JSP / HTML / CSS / JS)
       ▼
[Apache Tomcat 8.5 Server]
       │
       ▼
[Java Servlets Controller Layer]
       │
       ▼
[Data Access Object (DAO) & Model Layer]
       │  (JDBC Connection Pool)
       ▼
[MySQL / MariaDB Database: banking_db]
```

---

## 🚀 2. Technology Stack

| Component | Technology | Version / Specification |
|:---|:---|:---|
| **Operating System** | Windows / Linux | Windows 11 Compatible |
| **Frontend** | HTML5, CSS3, JavaScript, JSP | Modern Dark Mode Fintech Theme |
| **Backend** | Java Servlets (Java EE) | Java JDK 17 |
| **Database** | MySQL / MariaDB | MariaDB 10.4.32 (via XAMPP) |
| **Database Connectivity**| JDBC | MySQL Connector/J 8.3.0 |
| **Server** | Apache Tomcat | Tomcat 8.5.96 |
| **IDE Compatibility** | Eclipse, NetBeans, IntelliJ IDEA, Antigravity | Standard Dynamic Web Project structure |

---

## 📂 3. Implemented Modules (Per Synopsis Specifications)

### 1. 🛡️ Admin Module
* **Secure Staff Login:** Dedicated portal for bank managers.
* **Executive Dashboard:** Live metrics for Total Bank Liquidity, Registered Customers, Active Accounts, and Transaction counts.
* **Customer Directory:** Full oversight of customers and account records.
* **Account Status Control:** Instantly toggle account states between **Active**, **Inactive**, or **Blocked**.
* **Account Credit:** Admin manual balance adjustment and direct credits.
* **Account Deletion:** Clean cascade removal of customer profiles and history.
* **Global Audit Log:** Searchable and filterable transaction audit log with print options.

### 2. 📝 Customer Registration Module
* Captures Customer Name, Email, Mobile Phone, Date of Birth, Address, Account Type (Savings / Current), and Initial Deposit.
* **Automated Account Number Generation:** Generates unique 12-digit bank account numbers (e.g., `100123456789`).
* Auto-creates opening balance transaction if initial deposit is provided.

### 3. 🔐 Login Module
* Single sign-in accepting either **Account Number** or **Registered Email** with password.
* Secure HTTP session management (`HttpSession`) with auto-timeout.
* Pre-filled one-click demo credentials for quick evaluation.

### 4. 💳 Account Management & Dashboard Module
* **Virtual Banking Card:** Displays cardholder name, masked/revealed balance, account type, chip indicator, and copyable 12-digit account number.
* Shows branch details, IFSC Code (`UBDT0001001`), and active account status.
* Live feed of the recent 5 account transactions.

### 5. 💰 Deposit Module
* Accepts self/online deposits with positive amount validation.
* Quick-add amount buttons (`+₹500`, `+₹1,000`, `+₹5,000`, `+₹10,000`).
* Generates distinct transaction reference ID (`DEP...`) and updates ledger balance.

### 6. 🏧 Withdrawal Module
* Cash and ATM withdrawal with balance sufficiency validation.
* Safeguards against overdrafts or withdrawals on inactive/blocked accounts.
* Generates debit transaction reference (`WDL...`).

### 7. 🔁 Fund Transfer Module
* **Direct Inter-Account Transfer:** Atomically debits sender and credits recipient.
* **Live Beneficiary Verification (AJAX):** Automatically validates the beneficiary account number as the user types and displays the recipient's name to prevent erroneous transfers.
* Self-transfer prevention and active status checks.
* Generates double-entry reference IDs (`TRF-DR-...` for sender, `TRF-CR-...` for recipient).

### 8. ⚖️ Balance Enquiry Module
* Real-time balance certificate detailing available balance, currency (INR), account status, IFSC, and branch coordinates.
* Printable certificate view.

### 9. 📜 Transaction History Module
* Full passbook / statement of all credits and debits.
* Client-side search and filtering by remark, reference ID, or date.
* Summary breakdown of Total Inward (Deposits) vs Total Outward (Debits).
* **Printable Bank Statement:** Formatted print view (`@media print`) rendering a formal white-sheet bank statement.

### 10. 👤 Profile Module
* View and update personal information (Phone, Address, Date of Birth).
* Secure password change with confirmation verification.

### 11. 🔒 Logout Module
* Secure session invalidation and redirection to login.

---

## 🗄️ 4. Database Schema (`banking_db`)

The database consists of four tables with foreign keys and cascade rules:

```sql
-- 1. Admin Table
CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    role VARCHAR(50) DEFAULT 'SUPER_ADMIN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Customer Table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    dob DATE DEFAULT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Account Table
CREATE TABLE account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    account_number VARCHAR(30) NOT NULL UNIQUE,
    account_type VARCHAR(20) NOT NULL DEFAULT 'Savings',
    balance DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    status VARCHAR(20) NOT NULL DEFAULT 'Active',
    branch VARCHAR(100) DEFAULT 'Main Branch - Davanagere',
    ifsc_code VARCHAR(20) DEFAULT 'UBDT0001001',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);

-- 4. Transaction Table
CREATE TABLE transaction (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type VARCHAR(30) NOT NULL, -- 'Deposit', 'Withdrawal', 'Transfer'
    amount DECIMAL(12, 2) NOT NULL,
    balance_after DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    transaction_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(255) NOT NULL,
    reference_no VARCHAR(50) UNIQUE,
    FOREIGN KEY (account_id) REFERENCES account (account_id) ON DELETE CASCADE
);
```

---

## 🔑 5. Pre-Configured Demo Accounts

| Role | Account Number / Username | Password | Details | Initial Balance |
|:---|:---|:---|:---|:---|
| **Administrator** | `admin` | `admin123` | G S Guruswamy (Administrator) | System Control |
| **Customer 1** | `100123456789` (or `rahul@gmail.com`) | `password123` | Rahul Sharma (Savings) | ₹25,000.00 |
| **Customer 2** | `100987654321` (or `priya@gmail.com`) | `password123` | Priya Patel (Savings) | ₹48,500.00 |
| **Customer 3** | `100555666777` (or `anil@gmail.com`) | `password123` | Anil Kumar (Current) | ₹1,12,000.00 |

---

## 💻 6. Quick Start & Execution

### Option A: Using the Provided One-Click Scripts
1. Open PowerShell / Command Prompt in `BankingManagementSystem/`.
2. Run `start-servers.bat` to launch MySQL and Apache Tomcat.
3. Open your browser and navigate to:
   * **Home:** [http://localhost:8080/BankingManagementSystem/](http://localhost:8080/BankingManagementSystem/)
   * **Short URL:** [http://localhost:8080/bms/](http://localhost:8080/bms/)
   * **Customer Login:** [http://localhost:8080/BankingManagementSystem/login](http://localhost:8080/BankingManagementSystem/login)
   * **Admin Portal:** [http://localhost:8080/BankingManagementSystem/admin-login](http://localhost:8080/BankingManagementSystem/admin-login)

### Option B: Compiling & Re-building from Scratch
Run the build script:
```powershell
.\build.bat
```
This script will:
1. Compile all `.java` files using `javac` with Tomcat's `servlet-api.jar` and `jsp-api.jar`.
2. Place class files into `WebContent/WEB-INF/classes`.
3. Package the deployment archive `BankingManagementSystem.war`.
4. Deploy to `C:\xampp\tomcat\webapps\BankingManagementSystem` and `bms`.

---

## 📁 7. Project Directory Structure

```
BankingManagementSystem/
├── src/
│   └── com/
│       └── bms/
│           ├── model/          # Customer, Account, Transaction, Admin POJOs
│           ├── dao/            # CustomerDAO, AccountDAO, TransactionDAO, AdminDAO
│           ├── util/           # DBConnection, PasswordUtil
│           └── servlet/        # Login, Register, Deposit, Withdraw, Transfer, etc.
├── WebContent/
│   ├── css/                    # style.css, dashboard.css
│   ├── js/                     # main.js (live recipient check, toasts, print)
│   ├── WEB-INF/
│   │   ├── classes/            # Compiled .class files
│   │   ├── lib/                # mysql-connector-j-8.3.0.jar, jstl-1.2.jar
│   │   └── web.xml             # Deployment descriptor
│   ├── index.jsp               # Home portal & accreditation
│   ├── login.jsp               # Customer login
│   ├── register.jsp            # Customer registration
│   ├── dashboard.jsp           # Customer dashboard & virtual card
│   ├── deposit.jsp             # Cash & electronic deposit
│   ├── withdraw.jsp            # Withdrawal
│   ├── transfer.jsp            # Direct fund transfer
│   ├── balance.jsp             # Balance certificate
│   ├── transactions.jsp        # Passbook statement & print
│   ├── profile.jsp             # Customer profile & password
│   ├── admin-login.jsp         # Staff admin authentication
│   ├── admin-dashboard.jsp     # Admin analytics
│   ├── admin-customers.jsp     # Customer directory & credit
│   ├── admin-transactions.jsp  # Global audit log
│   └── error.jsp               # Error handler
├── database/
│   └── schema.sql              # Complete database DDL & seed data
├── build.bat                   # Automated compilation & packaging
├── start-servers.bat           # One-click launch
├── BankingManagementSystem.war # Production-ready deployable WAR
└── README.md
```

---

## 🎓 8. Academic Project Verification

All project objectives, modules, database relationships, and technologies outlined in the **MCA Dissertation Synopsis** (`BMS.pdf`) have been developed and tested end-to-end.
