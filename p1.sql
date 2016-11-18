CREATE OR REPLACE FUNCTION f01(name text) RETURNS void AS $$
DECLARE
	c1 cursor for select Vname,T_Date,Amount from customer NATURAL JOIN transaction NATURAL JOIN vendor WHERE customer.Cname = name;
	pName text;
	pData date;
	pAmount real;
BEGIN
	open c1;

	LOOP
		fetch c1 into pName,pData,pAmount;
		exit when not found;
		raise notice 'name:% | date:% | amount:%',pName,pData,pAmount;
	
	END LOOP;
	close c1;
END;
$$ LANGUAGE plpgsql;
