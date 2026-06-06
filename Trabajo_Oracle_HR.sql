-----------CONSULTA DE INDICES-------------------------------
SELECT index_name,
       table_name,
       uniqueness
FROM user_indexes
WHERE table_name IN ('EMPLOYEES','DEPARTMENTS')
ORDER BY table_name;
------------------------------------------------------------

----------CONSULTA RESTRICCIONES----------------------------
SELECT constraint_name,
       constraint_type,
       status,
       table_name
FROM user_constraints
WHERE table_name IN ('EMPLOYEES','DEPARTMENTS')
ORDER BY table_name;
------------------------------------------------------------


--------DESACTIVAR RESTRICCIONES----------------------------

ALTER TABLE departments DISABLE CONSTRAINT DEPT_ID_PK; --no permitió
ALTER TABLE employees DISABLE CONSTRAINT EMP_EMP_ID_PK; --no permitió
ALTER TABLE departments DISABLE CONSTRAINT DEPT_LOC_FK; ----si se pudo desactivar
ALTER TABLE employees DISABLE CONSTRAINT EMP_SALARY_MIN; ---si se pudo desactivar
-------------------------------------------------------------

-------------CONSULTA PARA RESTRICCIONES----------------------------
SELECT constraint_name, status
FROM user_constraints
WHERE table_name IN ('EMPLOYEES','DEPARTMENTS');
---------------------------------------------------------------------

----------------INSERTAR TUPLA A LA TABLA DE DEPARTAMENTO------------
INSERT INTO departments
(
    department_id,
    department_name,
    manager_id,
    location_id
)
VALUES
(
    998,
    'DEPARTAMENTO_PRUEBA',
    NULL,
    8888
);
-------------------------------------------------------------------------


------------------CONSULTAR LAS TUPLAS INSERTADAS------------------------
SELECT *
FROM departments
WHERE department_id in (998,999);
-------------------------------------------------------------------------


------------------------REACTIVAR LAS RESTRICCIONES----------------------

ALTER TABLE departments
ENABLE CONSTRAINT DEPT_LOC_FK;

--------------------------------------------------------------------------

---------------------------CONFIRMAR EL ESTADO----------------------------
SELECT constraint_name,
       status
FROM user_constraints
WHERE table_name = 'DEPARTMENTS'
ORDER BY constraint_name;
---------------------------------------------------------------------------

------------------------INSERT RESTRICCION PARA EMPLEADOS------------------
INSERT INTO employees
(
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id
)
VALUES
(
    999,
    'PRUEBA',
    'SALARIO',
    'PRB999',
    '555.123.4567',
    SYSDATE,
    'IT_PROG',
    -100,
    NULL,
    103,
    60
);
---------------------------------------------------------------------------

-----------------REACTIVAR RESTRICCION DE EMPLEADOS------------------------
ALTER TABLE employees
ENABLE CONSTRAINT EMP_SALARY_MIN;
---------------------------------------------------------------------------

------------------CREAR TABLA DE DEPARTAMENTOS2----------------------------
CREATE TABLE departments2 AS
SELECT *
FROM departments;
---------------------------------------------------------------------------

-------------CONSULTA DE LA TABLA QUE SI HAYA QUEDADO CREADO---------------
SELECT table_name
FROM user_tables
WHERE table_name = 'DEPARTMENTS2';
---------------------------------------------------------------------------

--=========================================================================
------------------INSERTAR TUPLAS EN LA TABLA------------------------------
--=========================================================================

---------primero consulta el maximo DEPARTAMENT_ID que exista--------------
SELECT MAX(department_id)
FROM departments2;
---------------------------------------------------------------------------

------INSERTAR AHORA SI LAS TUPLAS CON LOS 3 ULTIMOS CONSECUTIVOS DEL ID---
INSERT INTO departments2
VALUES (271, 'DEPARTAMENTO_A', NULL, 1700);

INSERT INTO departments2
VALUES (272, 'DEPARTAMENTO_B', NULL, 1700);

INSERT INTO departments2
VALUES (273, 'DEPARTAMENTO_C', NULL, 1700);
----------------------------------------------------------------------------

--------------------------SE REALIZA LA CONSULTA----------------------------
SELECT *
FROM departments2
WHERE department_id IN (271,272,273);
----------------------------------------------------------------------------
--==========================================================================
--==========================================================================


---------------------CREACION DEL BLOQUE ANONIMO-----------------------------
SET SERVEROUTPUT ON;

BEGIN

   DBMS_OUTPUT.PUT_LINE('Inicio de la transaccion');

   INSERT INTO departments2
   VALUES (950, 'PRUEBA_TRANSACCION', NULL, 1700);

   COMMIT;

   DBMS_OUTPUT.PUT_LINE('Fin de la transaccion');

END;
/
---------------------------------------------------------------------------------

---------------------------DESHACER TRANSACCION----------------------------------
ROLLBACK;
---------------------------------------------------------------------------------
