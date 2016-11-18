CREATE OR REPLACE FUNCTION f04() RETURNS integer AS $$
DECLARE
	cust customer%ROWTYPE;
	res record;
	amt real;
	vnm text;
	accNum integer;
	counter integer;
	minDate date;
BEGIN
	
	FOR cust IN SELECT * FROM customer LOOP

		accNum := 0;
		select COUNT(*),MAX(T_Date) into accNum,minDate FROM customer NATURAL JOIN transaction NATURAL JOIN vendor 
			WHERE cust.Cname = Cname;
	
		IF (accNum <= 0) THEN raise notice 'No transaction found for customer %',cust.Cname;

		ELSE
		select Amount,Vname into amt,vnm FROM vendor NATURAL JOIN transaction NATURAL JOIN customer 
			WHERE cust.Cname = Cname
			AND T_Date = minDate
			GROUP BY Amount,Vname;  
		
		
		raise notice 'Account number:% | CName:% | Amount:% | Vname:%',cust.Account,cust.Cname,amt,vnm;		 
		
		END IF;
	END LOOP;
	
	RETURN 0;
END;
$$ LANGUAGE plpgsql;
