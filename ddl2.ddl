CREATE TABLE Advert 
    ( 
     propertyNo                 VARCHAR2 (10)  NOT NULL , 
     newspaperName              VARCHAR2 (50)  NOT NULL , 
     dateAdvert                 DATE  NOT NULL , 
     PropertyForRent_propertyNo VARCHAR2 (10)  NOT NULL , 
     Newspaper_newspaperName    VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE Advert 
    ADD CONSTRAINT Advert_PK PRIMARY KEY ( propertyNo, newspaperName, dateAdvert ) ;

CREATE TABLE Branch 
    ( 
     branchNo VARCHAR2 (10)  NOT NULL 
    ) 
;

ALTER TABLE Branch 
    ADD CONSTRAINT Branch_PK PRIMARY KEY ( branchNo ) ;

CREATE TABLE BusinessOwner 
    ( 
     ownerNo VARCHAR2 (10)  NOT NULL 
    ) 
;

ALTER TABLE BusinessOwner 
    ADD CONSTRAINT BusinessOwner_PK PRIMARY KEY ( ownerNo ) ;

CREATE TABLE client 
    ( 
     clientNo VARCHAR2 (10)  NOT NULL 
    ) 
;

ALTER TABLE client 
    ADD CONSTRAINT client_PK PRIMARY KEY ( clientNo ) ;

CREATE TABLE Lease 
    ( 
     leaseNo                    VARCHAR2 (10)  NOT NULL , 
     clientNo                   VARCHAR2 (10) , 
     propertyNo                 VARCHAR2 (10) , 
     client_clientNo            VARCHAR2 (10)  NOT NULL , 
     PropertyForRent_propertyNo VARCHAR2 (10)  NOT NULL 
    ) 
;

ALTER TABLE Lease 
    ADD CONSTRAINT Lease_PK PRIMARY KEY ( leaseNo, client_clientNo ) ;

CREATE TABLE Manager 
    ( 
     staffNo         VARCHAR2 (10)  NOT NULL , 
     Branch_branchNo VARCHAR2 (10)  NOT NULL 
    ) 
;
CREATE UNIQUE INDEX Manager__IDX ON Manager 
    ( 
     Branch_branchNo ASC 
    ) 
;

ALTER TABLE Manager 
    ADD CONSTRAINT Manager_PK PRIMARY KEY ( staffNo ) ;

CREATE TABLE Newspaper 
    ( 
     newspaperName VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE Newspaper 
    ADD CONSTRAINT Newspaper_PK PRIMARY KEY ( newspaperName ) ;

CREATE TABLE PrivateOwner 
    ( 
     ownerNo VARCHAR2 (10)  NOT NULL 
    ) 
;

ALTER TABLE PrivateOwner 
    ADD CONSTRAINT PrivateOwner_PK PRIMARY KEY ( ownerNo ) ;

CREATE TABLE PropertyForRent 
    ( 
     propertyNo            VARCHAR2 (10)  NOT NULL , 
     ownerNo               VARCHAR2 (10) , 
     staffNo               VARCHAR2 (10) , 
     branchNo              VARCHAR2 (10) , 
     PrivateOwner_ownerNo  VARCHAR2 (10)  NOT NULL , 
     BusinessOwner_ownerNo VARCHAR2 (10)  NOT NULL 
    ) 
;

ALTER TABLE PropertyForRent 
    ADD CONSTRAINT PropertyForRent_PK PRIMARY KEY ( propertyNo ) ;

CREATE TABLE Registration 
    ( 
     clientNo        VARCHAR2 (10)  NOT NULL , 
     branchNo        VARCHAR2 (10)  NOT NULL , 
     staffNo         VARCHAR2 (10) , 
     Staff_staffNo   VARCHAR2 (10)  NOT NULL , 
     Branch_branchNo VARCHAR2 (10)  NOT NULL , 
     client_clientNo VARCHAR2 (10)  NOT NULL 
    ) 
;
CREATE UNIQUE INDEX Registration__IDX ON Registration 
    ( 
     client_clientNo ASC 
    ) 
;

ALTER TABLE Registration 
    ADD CONSTRAINT Registration_PK PRIMARY KEY ( clientNo, branchNo, Staff_staffNo ) ;

CREATE TABLE Staff 
    ( 
     staffNo         VARCHAR2 (10)  NOT NULL , 
     Staff_staffNo   VARCHAR2 (10)  NOT NULL , 
     Branch_branchNo VARCHAR2 (10)  NOT NULL 
    ) 
;

ALTER TABLE Staff 
    ADD CONSTRAINT Staff_PK PRIMARY KEY ( staffNo ) ;

CREATE TABLE Telephone 
    ( 
     tellNo          VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
                     NOT NULL , 
     Branch_branchNo VARCHAR2 (10)  NOT NULL 
    ) 
;

ALTER TABLE Telephone 
    ADD CONSTRAINT Telephone_PK PRIMARY KEY ( tellNo ) ;

CREATE TABLE Viewing 
    ( 
     clientNo                   VARCHAR2 (10)  NOT NULL , 
     propertyNo                 VARCHAR2 (10)  NOT NULL , 
     client_clientNo            VARCHAR2 (10)  NOT NULL , 
     PropertyForRent_propertyNo VARCHAR2 (10)  NOT NULL 
    ) 
;

ALTER TABLE Viewing 
    ADD CONSTRAINT Viewing_PK PRIMARY KEY ( clientNo, propertyNo ) ;

ALTER TABLE Advert 
    ADD CONSTRAINT Advert_Newspaper_FK FOREIGN KEY 
    ( 
     Newspaper_newspaperName
    ) 
    REFERENCES Newspaper 
    ( 
     newspaperName
    ) 
;

ALTER TABLE Advert 
    ADD CONSTRAINT Advert_PropertyForRent_FK FOREIGN KEY 
    ( 
     PropertyForRent_propertyNo
    ) 
    REFERENCES PropertyForRent 
    ( 
     propertyNo
    ) 
;

ALTER TABLE Lease 
    ADD CONSTRAINT Lease_client_FK FOREIGN KEY 
    ( 
     client_clientNo
    ) 
    REFERENCES client 
    ( 
     clientNo
    ) 
;

ALTER TABLE Lease 
    ADD CONSTRAINT Lease_PropertyForRent_FK FOREIGN KEY 
    ( 
     PropertyForRent_propertyNo
    ) 
    REFERENCES PropertyForRent 
    ( 
     propertyNo
    ) 
;

ALTER TABLE Manager 
    ADD CONSTRAINT Manager_Branch_FK FOREIGN KEY 
    ( 
     Branch_branchNo
    ) 
    REFERENCES Branch 
    ( 
     branchNo
    ) 
;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE PropertyForRent 
    ADD CONSTRAINT PropertyForRent_BusinessOwner_FK FOREIGN KEY 
    ( 
     BusinessOwner_ownerNo
    ) 
    REFERENCES BusinessOwner 
    ( 
     ownerNo
    ) 
;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE PropertyForRent 
    ADD CONSTRAINT PropertyForRent_PrivateOwner_FK FOREIGN KEY 
    ( 
     PrivateOwner_ownerNo
    ) 
    REFERENCES PrivateOwner 
    ( 
     ownerNo
    ) 
;

ALTER TABLE Registration 
    ADD CONSTRAINT Registration_Branch_FK FOREIGN KEY 
    ( 
     Branch_branchNo
    ) 
    REFERENCES Branch 
    ( 
     branchNo
    ) 
;

ALTER TABLE Registration 
    ADD CONSTRAINT Registration_client_FK FOREIGN KEY 
    ( 
     client_clientNo
    ) 
    REFERENCES client 
    ( 
     clientNo
    ) 
;

ALTER TABLE Registration 
    ADD CONSTRAINT Registration_Staff_FK FOREIGN KEY 
    ( 
     Staff_staffNo
    ) 
    REFERENCES Staff 
    ( 
     staffNo
    ) 
;

ALTER TABLE Staff 
    ADD CONSTRAINT Staff_Branch_FK FOREIGN KEY 
    ( 
     Branch_branchNo
    ) 
    REFERENCES Branch 
    ( 
     branchNo
    ) 
;

ALTER TABLE Staff 
    ADD CONSTRAINT Staff_Staff_FK FOREIGN KEY 
    ( 
     Staff_staffNo
    ) 
    REFERENCES Staff 
    ( 
     staffNo
    ) 
;

ALTER TABLE Telephone 
    ADD CONSTRAINT Telephone_Branch_FK FOREIGN KEY 
    ( 
     Branch_branchNo
    ) 
    REFERENCES Branch 
    ( 
     branchNo
    ) 
;

ALTER TABLE Viewing 
    ADD CONSTRAINT Viewing_client_FK FOREIGN KEY 
    ( 
     client_clientNo
    ) 
    REFERENCES client 
    ( 
     clientNo
    ) 
;

ALTER TABLE Viewing 
    ADD CONSTRAINT Viewing_PropertyForRent_FK FOREIGN KEY 
    ( 
     PropertyForRent_propertyNo
    ) 
    REFERENCES PropertyForRent 
    ( 
     propertyNo
    ) 
;
