--liquibase formatted sql

--changeset rainer.borchardt:1 context:v1 labels:task1
--comment: example comment
create table person (
    id int GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
);
alter table person add constraint pk_person PRIMARY KEY(id);
--rollback DROP TABLE person;

--changeset rainer.borchardt:2 context:v2 labels:task1
--comment: example comment
create table company (
    id int GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
);
alter table company add constraint pk_company PRIMARY KEY(id);
--rollback DROP TABLE company;

--changeset other.dev:3 context:v3 labels:task1
--comment: example comment
alter table person add country varchar(2)
--rollback ALTER TABLE person DROP COLUMN country;

--changeset rainer.borchardt:4 context:v4 labels:task1
ALTER TABLE person ADD worksfor_company_id INT;
--rollback ALTER TABLE person DROP COLUMN worksfor_company_id;

--changeset rainer.borchardt:5 context:v4 labels:task2
ALTER TABLE person ADD CONSTRAINT fk_person_worksfor FOREIGN KEY (worksfor_company_id) REFERENCES company(id);
--rollback ALTER TABLE person drop constraint fk_person_worksfor;