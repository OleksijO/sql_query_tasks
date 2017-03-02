--------------------------------------------------------
--  File created - Tuesday-February-28-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table BUS
--------------------------------------------------------

  CREATE TABLE "DB"."BUS" 
   (	"ID" NUMBER(20,0), 
	"REGISTRATION_NUMBER" VARCHAR2(20 BYTE), 
	"BUS_MODEL_ID" NUMBER(20,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table BUS_EXPENSE
--------------------------------------------------------

  CREATE TABLE "DB"."BUS_EXPENSE" 
   (	"ID" NUMBER(20,0), 
	"EXPENCE_TYPE_ID" NUMBER(20,0), 
	"ROUTE_LOG_ID" NUMBER(20,0), 
	"AMOUNT" NUMBER(20,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table BUS_INCOMES
--------------------------------------------------------

  CREATE TABLE "DB"."BUS_INCOMES" 
   (	"ID" NUMBER(20,0), 
	"INCOME_TYPE_ID" NUMBER(20,0), 
	"ROUTE_LOG_ID" NUMBER(20,0), 
	"AMOUNT" NUMBER(20,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table BUS_MODEL
--------------------------------------------------------

  CREATE TABLE "DB"."BUS_MODEL" 
   (	"ID" NUMBER(20,0), 
	"MODEL" VARCHAR2(45 BYTE), 
	"PASSANGER_CAPACITY" NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table DRIVER
--------------------------------------------------------

  CREATE TABLE "DB"."DRIVER" 
   (	"ID" NUMBER(20,0), 
	"FIRST_NAME" VARCHAR2(20 BYTE), 
	"LAST_NAME" VARCHAR2(45 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table EXPENSE_TYPE
--------------------------------------------------------

  CREATE TABLE "DB"."EXPENSE_TYPE" 
   (	"ID" NUMBER(20,0), 
	"EXPENSE_NAME" VARCHAR2(45 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table INCOME_TYPE
--------------------------------------------------------

  CREATE TABLE "DB"."INCOME_TYPE" 
   (	"ID" NUMBER(20,0), 
	"INCOME_NAME" VARCHAR2(45 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ROUTE
--------------------------------------------------------

  CREATE TABLE "DB"."ROUTE" 
   (	"ID" NUMBER(20,0), 
	"LINE_NUMBER" NUMBER(3,0), 
	"PATH" VARCHAR2(255 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ROUTE_LOG
--------------------------------------------------------

  CREATE TABLE "DB"."ROUTE_LOG" 
   (	"ID" NUMBER(20,0), 
	"ROUTE_ID" NUMBER(20,0), 
	"BUS_ID" NUMBER(20,0), 
	"DRIVER_ID" NUMBER(20,0), 
	"DATE_FROM" TIMESTAMP (6), 
	"DATE_TO" TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index BUS_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."BUS_UK1" ON "DB"."BUS" ("REGISTRATION_NUMBER") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index BUS_MODEL_FK
--------------------------------------------------------

  CREATE INDEX "DB"."BUS_MODEL_FK" ON "DB"."BUS" ("BUS_MODEL_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index BUS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."BUS_PK" ON "DB"."BUS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index BUS_EXPENSE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."BUS_EXPENSE_PK" ON "DB"."BUS_EXPENSE" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index BUS_EXPENSE_FK
--------------------------------------------------------

  CREATE INDEX "DB"."BUS_EXPENSE_FK" ON "DB"."BUS_EXPENSE" ("EXPENCE_TYPE_ID", "ROUTE_LOG_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index BUS_INCOMES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."BUS_INCOMES_PK" ON "DB"."BUS_INCOMES" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index BUS_INCOMES_INDEX_FK
--------------------------------------------------------

  CREATE INDEX "DB"."BUS_INCOMES_INDEX_FK" ON "DB"."BUS_INCOMES" ("INCOME_TYPE_ID", "ROUTE_LOG_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index BUS_MODEL_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."BUS_MODEL_PK" ON "DB"."BUS_MODEL" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index DRIVER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."DRIVER_PK" ON "DB"."DRIVER" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index EXPENSE_TYPE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."EXPENSE_TYPE_PK" ON "DB"."EXPENSE_TYPE" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index INCOME_TYPE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."INCOME_TYPE_PK" ON "DB"."INCOME_TYPE" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index ROUTE_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."ROUTE_UK1" ON "DB"."ROUTE" ("LINE_NUMBER") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index ROUTE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."ROUTE_PK" ON "DB"."ROUTE" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index ROUTE_LOG_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB"."ROUTE_LOG_PK" ON "DB"."ROUTE_LOG" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index ROUTE_LOG_INDEX_FK
--------------------------------------------------------

  CREATE INDEX "DB"."ROUTE_LOG_INDEX_FK" ON "DB"."ROUTE_LOG" ("ROUTE_ID", "BUS_ID", "DRIVER_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table BUS
--------------------------------------------------------

  ALTER TABLE "DB"."BUS" ADD CONSTRAINT "BUS_UK1" UNIQUE ("REGISTRATION_NUMBER")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."BUS" MODIFY ("BUS_MODEL_ID" NOT NULL ENABLE);
  ALTER TABLE "DB"."BUS" ADD CONSTRAINT "BUS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."BUS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "DB"."BUS" MODIFY ("REGISTRATION_NUMBER" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BUS_EXPENSE
--------------------------------------------------------

  ALTER TABLE "DB"."BUS_EXPENSE" ADD CONSTRAINT "BUS_EXPENSE_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."BUS_EXPENSE" MODIFY ("AMOUNT" NOT NULL ENABLE);
  ALTER TABLE "DB"."BUS_EXPENSE" MODIFY ("ROUTE_LOG_ID" NOT NULL ENABLE);
  ALTER TABLE "DB"."BUS_EXPENSE" MODIFY ("EXPENCE_TYPE_ID" NOT NULL ENABLE);
  ALTER TABLE "DB"."BUS_EXPENSE" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BUS_INCOMES
--------------------------------------------------------

  ALTER TABLE "DB"."BUS_INCOMES" MODIFY ("ROUTE_LOG_ID" NOT NULL ENABLE);
  ALTER TABLE "DB"."BUS_INCOMES" ADD CONSTRAINT "BUS_INCOMES_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."BUS_INCOMES" MODIFY ("AMOUNT" NOT NULL ENABLE);
  ALTER TABLE "DB"."BUS_INCOMES" MODIFY ("INCOME_TYPE_ID" NOT NULL ENABLE);
  ALTER TABLE "DB"."BUS_INCOMES" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BUS_MODEL
--------------------------------------------------------

  ALTER TABLE "DB"."BUS_MODEL" ADD CONSTRAINT "BUS_MODEL_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."BUS_MODEL" MODIFY ("PASSANGER_CAPACITY" NOT NULL ENABLE);
  ALTER TABLE "DB"."BUS_MODEL" MODIFY ("MODEL" NOT NULL ENABLE);
  ALTER TABLE "DB"."BUS_MODEL" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DRIVER
--------------------------------------------------------

  ALTER TABLE "DB"."DRIVER" ADD CONSTRAINT "DRIVER_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."DRIVER" MODIFY ("LAST_NAME" NOT NULL ENABLE);
  ALTER TABLE "DB"."DRIVER" MODIFY ("FIRST_NAME" NOT NULL ENABLE);
  ALTER TABLE "DB"."DRIVER" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EXPENSE_TYPE
--------------------------------------------------------

  ALTER TABLE "DB"."EXPENSE_TYPE" ADD CONSTRAINT "EXPENSE_TYPE_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."EXPENSE_TYPE" MODIFY ("EXPENSE_NAME" NOT NULL ENABLE);
  ALTER TABLE "DB"."EXPENSE_TYPE" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table INCOME_TYPE
--------------------------------------------------------

  ALTER TABLE "DB"."INCOME_TYPE" ADD CONSTRAINT "INCOME_TYPE_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."INCOME_TYPE" MODIFY ("INCOME_NAME" NOT NULL ENABLE);
  ALTER TABLE "DB"."INCOME_TYPE" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ROUTE
--------------------------------------------------------

  ALTER TABLE "DB"."ROUTE" ADD CONSTRAINT "ROUTE_UK1" UNIQUE ("LINE_NUMBER")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."ROUTE" ADD CONSTRAINT "ROUTE_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."ROUTE" MODIFY ("PATH" NOT NULL ENABLE);
  ALTER TABLE "DB"."ROUTE" MODIFY ("LINE_NUMBER" NOT NULL ENABLE);
  ALTER TABLE "DB"."ROUTE" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ROUTE_LOG
--------------------------------------------------------

  ALTER TABLE "DB"."ROUTE_LOG" MODIFY ("DATE_TO" NOT NULL ENABLE);
  ALTER TABLE "DB"."ROUTE_LOG" MODIFY ("DATE_FROM" NOT NULL ENABLE);
  ALTER TABLE "DB"."ROUTE_LOG" MODIFY ("DRIVER_ID" NOT NULL ENABLE);
  ALTER TABLE "DB"."ROUTE_LOG" MODIFY ("BUS_ID" NOT NULL ENABLE);
  ALTER TABLE "DB"."ROUTE_LOG" MODIFY ("ROUTE_ID" NOT NULL ENABLE);
  ALTER TABLE "DB"."ROUTE_LOG" ADD CONSTRAINT "ROUTE_LOG_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB"."ROUTE_LOG" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table BUS
--------------------------------------------------------

  ALTER TABLE "DB"."BUS" ADD CONSTRAINT "BUS_MODEL_ID_FK1" FOREIGN KEY ("BUS_MODEL_ID")
	  REFERENCES "DB"."BUS_MODEL" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BUS_EXPENSE
--------------------------------------------------------

  ALTER TABLE "DB"."BUS_EXPENSE" ADD CONSTRAINT "BUS_EXPENSE_ROUTE_ID_FK2" FOREIGN KEY ("ROUTE_LOG_ID")
	  REFERENCES "DB"."ROUTE_LOG" ("ID") ENABLE;
  ALTER TABLE "DB"."BUS_EXPENSE" ADD CONSTRAINT "BUS_EXPENSE_TYPE_ID_FK1" FOREIGN KEY ("EXPENCE_TYPE_ID")
	  REFERENCES "DB"."EXPENSE_TYPE" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BUS_INCOMES
--------------------------------------------------------

  ALTER TABLE "DB"."BUS_INCOMES" ADD CONSTRAINT "BUS_INCOMES_ROUTE_LOG_FK2" FOREIGN KEY ("ROUTE_LOG_ID")
	  REFERENCES "DB"."ROUTE_LOG" ("ID") ENABLE;
  ALTER TABLE "DB"."BUS_INCOMES" ADD CONSTRAINT "BUS_INCOME_TYPE_FK1" FOREIGN KEY ("INCOME_TYPE_ID")
	  REFERENCES "DB"."INCOME_TYPE" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ROUTE_LOG
--------------------------------------------------------

  ALTER TABLE "DB"."ROUTE_LOG" ADD CONSTRAINT "ROUTE_LOG_BUS_ID_FK2" FOREIGN KEY ("BUS_ID")
	  REFERENCES "DB"."BUS" ("ID") ENABLE;
  ALTER TABLE "DB"."ROUTE_LOG" ADD CONSTRAINT "ROUTE_LOG_DRIVER_ID_FK3" FOREIGN KEY ("DRIVER_ID")
	  REFERENCES "DB"."DRIVER" ("ID") ENABLE;
  ALTER TABLE "DB"."ROUTE_LOG" ADD CONSTRAINT "ROUTE_LOG_ROUTE_ID_FK1" FOREIGN KEY ("ROUTE_ID")
	  REFERENCES "DB"."ROUTE" ("ID") ENABLE;
--------------------------------------------------------
--  DDL for Trigger BUS_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."BUS_TRG" 
BEFORE INSERT ON BUS 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."BUS_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BUS_TRG2
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."BUS_TRG2" 
BEFORE INSERT ON BUS 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT BUS_SEQ1.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."BUS_TRG2" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BUS_TRG1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."BUS_TRG1" 
BEFORE INSERT ON BUS 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."BUS_TRG1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BUS_EXPENSE_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."BUS_EXPENSE_TRG" 
BEFORE INSERT ON BUS_EXPENSE 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."BUS_EXPENSE_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BUS_EXPENSE_TRG1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."BUS_EXPENSE_TRG1" 
BEFORE INSERT ON BUS_EXPENSE 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT BUS_EXPENSE_SEQ1.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."BUS_EXPENSE_TRG1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BUS_INCOMES_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."BUS_INCOMES_TRG" 
BEFORE INSERT ON BUS_INCOMES 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT BUS_INCOMES_SEQ.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."BUS_INCOMES_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BUS_MODEL_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."BUS_MODEL_TRG" 
BEFORE INSERT ON BUS_MODEL 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT BUS_MODEL_SEQ.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."BUS_MODEL_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DRIVER_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."DRIVER_TRG" 
BEFORE INSERT ON DRIVER 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT DRIVER_SEQ.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."DRIVER_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger EXPENSE_TYPE_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."EXPENSE_TYPE_TRG" 
BEFORE INSERT ON EXPENSE_TYPE 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT EXPENSE_TYPE_SEQ.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."EXPENSE_TYPE_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger INCOME_TYPE_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."INCOME_TYPE_TRG" 
BEFORE INSERT ON INCOME_TYPE 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT INCOME_TYPE_SEQ.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."INCOME_TYPE_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ROUTE_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."ROUTE_TRG" 
BEFORE INSERT ON ROUTE 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT ROUTE_SEQ.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."ROUTE_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ROUTE_LOG_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB"."ROUTE_LOG_TRG" 
BEFORE INSERT ON ROUTE_LOG 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.ID IS NULL THEN
      SELECT ROUTE_LOG_SEQ.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB"."ROUTE_LOG_TRG" ENABLE;
