CREATE OR REPLACE FUNCTION f02(name text) RETURNS void AS $$
DECLARE
	cust customer%ROWTYPE;
	pNum text;
	pName text;
	pProvince text;
	transNum integer;
BEGIN
	raise notice 'Found following customers who had transactions with %',name;
	FOR cust in SELECT * FROM customer LOOP
		
		transNum:= 0;
		select COUNT(*),Account,Cname,Province into transNum,pNum,Pname,pProvince from transaction NATURAL JOIN vendor NATURAL JOIN customer 
			WHERE Vname = name AND cust.Cname = Cname
			GROUP BY Account,Cname,Province;
		
		if (transNum > 0) THEN 
			raise notice 'number:% | name:% | province:%',pNum,pName,pProvince;
		END IF;	

	END LOOP;
END;
$$ LANGUAGE plpgsql;
