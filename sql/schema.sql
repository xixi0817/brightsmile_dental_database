-- BrightSmile Dental: table structure of the final Microsoft Access database
-- Exported from the .accdb file and rewritten in standard SQL for readability.
-- In Access, several fields (Insurance, Provider, JobTitle, status and procedure)
-- are lookup fields that point to other tables or value lists.

CREATE TABLE PatientTable (
    PatientID          INTEGER PRIMARY KEY,
    FirstName          VARCHAR(255),
    LastName           VARCHAR(255),
    DateOfBirth        DATE,
    Gender             VARCHAR(255),
    CellPhone          VARCHAR(255),
    Address            VARCHAR(255),
    ZipCode            VARCHAR(255),
    City               VARCHAR(255),
    State              VARCHAR(255),
    Insurance          INTEGER,        -- lookup: insurance plan
    Email              VARCHAR(255),
    EmergencyContact   VARCHAR(255),
    EmergencyNumber    VARCHAR(255),
    Notes              TEXT
);

CREATE TABLE EmployeeTable (
    EmployeeID         INTEGER PRIMARY KEY,
    FirstName          VARCHAR(255),
    LastName           VARCHAR(255),
    Phone              VARCHAR(255),
    Email              VARCHAR(255),
    Address            VARCHAR(255),
    City               VARCHAR(255),
    State              VARCHAR(255),
    ZipCode            VARCHAR(255),
    HourlyRate         DECIMAL(10,2),
    JobTitle           INTEGER,        -- lookup: dentist, assistant, front desk, manager
    WorkDay            INTEGER,        -- lookup: scheduled work days
    Login              VARCHAR(25),
    Password           VARCHAR(25)
);

CREATE TABLE Appointment (
    ApptID               INTEGER PRIMARY KEY,
    PatientID            INTEGER NOT NULL REFERENCES PatientTable(PatientID),
    FirstName            VARCHAR(50) NOT NULL,
    LastName             VARCHAR(50) NOT NULL,
    Insurance            INTEGER,      -- lookup
    Gender               INTEGER,      -- lookup
    DOB                  DATE,
    ApptDate             DATETIME,
    ApptTime             DATETIME,
    AppointmentStatus    INTEGER,      -- lookup: Booked, Confirmed, In-Progress, Completed, Cancelled, No-Show
    AppointmentProcedure INTEGER,      -- lookup: ProcedureCatalog
    Provider             INTEGER,      -- lookup: EmployeeTable (dentist)
    ClinicNotes          VARCHAR(200),
    Address              VARCHAR(100),
    City                 VARCHAR(255),
    State                VARCHAR(255),
    ZipCode              VARCHAR(15),
    CellPhone            VARCHAR(20),
    Email                VARCHAR(30),
    EmergencyContact     VARCHAR(20),
    EmergencyNumber      VARCHAR(20),
    PaymentBalance       DECIMAL(10,2),
    EmployeeID           INTEGER REFERENCES EmployeeTable(EmployeeID)
);

CREATE TABLE ProcedureCatalog (
    ProcedureID   INTEGER PRIMARY KEY,
    ProcedureName VARCHAR(255),
    FeeDefault    DECIMAL(10,2)
);

CREATE TABLE AppointmentProcedure (
    ApptID      INTEGER NOT NULL REFERENCES Appointment(ApptID),
    ProcedureID INTEGER NOT NULL REFERENCES ProcedureCatalog(ProcedureID),
    FeeCharged  DECIMAL(10,2),
    PRIMARY KEY (ApptID, ProcedureID)
);

CREATE TABLE InventoryItem (
    ItemID         VARCHAR(255) PRIMARY KEY,
    ItemName       VARCHAR(255),
    QuantityOnHand INTEGER,
    ReorderPoint   INTEGER
);
