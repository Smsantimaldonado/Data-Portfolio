USE Music_store;

BULK INSERT Album
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\album.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);

BULK INSERT Artist
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\artist.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);

BULK INSERT Customer
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\customer.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);

BULK INSERT Employee
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\employee.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);

BULK INSERT Genre
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\genre.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);

BULK INSERT Playlist
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\playlist.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);

BULK INSERT PlaylistTrack
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\playlist_track.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);

BULK INSERT MediaType
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\media_type.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);

BULK INSERT Track
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\track.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);

BULK INSERT InvoiceLine
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\invoice_line.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);


-- A problem about data type came up when trying to bulk insert in Invoice table. Therefore I insert
-- the data into a temporary table, then insert it in the appropiate table changing the data type

CREATE TABLE #TempInvoice (
	invoice_id  NVARCHAR(255),
	customer_id  NVARCHAR(255),
	invoice_date DATE,
	billing_address NVARCHAR(255),
	billing_city NVARCHAR(255),
	billing_state NVARCHAR(255),
	billing_country NVARCHAR(255),
	billing_postal_code NVARCHAR(255),
	total NVARCHAR(255)
);

BULK INSERT #TempInvoice
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\invoice.csv'
WITH (
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n', 
    FIRSTROW = 2
);


INSERT INTO Invoice (invoice_id,
					 customer_id,
					 invoice_date,
					 billing_address,
					 billing_city,
					 billing_state,
					 billing_country,
					 billing_postal_code,
					 total)
SELECT 
    CAST(invoice_id AS INT),
    CAST(customer_id AS INT),
    invoice_date,
	billing_address,
	billing_city,
	billing_state,
	billing_country,
	billing_postal_code,
    CAST(total AS DECIMAL(10, 2))
FROM #TempInvoice;

BULK INSERT Invoice
FROM 'C:\Users\santi\Desktop\SQL_Analysis_Music_Store\music store data\invoice.csv'
WITH (
    FORMAT = 'CSV', 
    FIRSTROW = 2, -- Omitir la primera fila (encabezados)
    FIELDTERMINATOR = ',', -- Separador de columnas
    ROWTERMINATOR = '\n',  -- Separador de filas
    TABLOCK);

IF OBJECT_ID('tempdb..#TempInvoice') IS NOT NULL
    DROP TABLE #TempInvoice;